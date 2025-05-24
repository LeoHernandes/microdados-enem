using System.Globalization;
using System.Text;
using Core.Data;
using Core.Data.Models;
using CsvHelper;
using CsvHelper.Configuration;
using EFCore.BulkExtensions;

namespace DatabaseSetup.DataInfrastructure;

public class MicrodadosService(AppDbContext dbContext)
{
    private const string ITENS_FILE_PATH = "./ITENS_PROVA_2023.csv";
    private const string PARTICIPANTES_FILE_PATH = "./MICRODADOS_ENEM_2023.csv";
    private const int EXAM_REAPPLICATION_START_ID = 1271;

    private AppDbContext DbContext { get; set; } = dbContext;
    private Dictionary<int, string> Gabaritos { get; set; } = [];
    private readonly CsvConfiguration CsvHelperConfig = new(CultureInfo.InvariantCulture)
    {
        Delimiter = ";",
        HasHeaderRecord = true,
        Encoding = Encoding.Latin1
    };

    // Has the side effect of populating the `Gabaritos` dictionary 
    public void TransferMicrodadosItemsToDb()
    {
        ItemProvaDTO[] itemsDTO = [];
        using StreamReader reader = new(ITENS_FILE_PATH);
        using CsvReader csv = new(reader, CsvHelperConfig);
        {
            itemsDTO = [.. csv.GetRecords<ItemProvaDTO>()];
        }

        ItemPorProva[] dbItensPorProvas = [.. itemsDTO
            .Select(item => new ItemPorProva
            {
                ItemId = item.CO_ITEM,
                ProvaId = item.CO_PROVA,
                Posicao = item.CO_POSICAO
            })];

        HashSet<Prova> dbProvasSet = itemsDTO
            .Select(item => new Prova
            {
                ProvaId = item.CO_PROVA,
                AreaSigla = item.SG_AREA,
                Cor = item.TX_COR == "LEITOR TELA" ? null : item.TX_COR,
                Reaplicacao = item.CO_PROVA >= EXAM_REAPPLICATION_START_ID,
            })
            .ToHashSet(new ProvaEqualityComparer());

        HashSet<Item> dbItensSet = itemsDTO
            .Select(item => new Item
            {
                ItemId = item.CO_ITEM,
                HabilidadeId = item.CO_HABILIDADE,
                ParamDiscriminacao = item.NU_PARAM_A,
                ParamDificuldade = item.NU_PARAM_B,
                ParamAcaso = item.NU_PARAM_C,
                FoiAbandonado = item.IN_ITEM_ABAN,
                Gabarito = item.TX_GABARITO,
                LinguaEstrangeira = (ForeignLanguage?)item.TP_LINGUA,
            })
            .ToHashSet(new ItemEqualityComparer());

        DbContext.Itens.AddRange(dbItensSet);
        DbContext.ItensPorProvas.AddRange(dbItensPorProvas);
        DbContext.Provas.AddRange(dbProvasSet);
        DbContext.SaveChanges();

        // Dict used to calculate the number of correctly answered question for each area for each user
        // Is better to generate the dict here instead of building it from the DB due to obvious performance reasons
        // OBS:
        //   LC exam have repeated 1-5 questions, so we consider TP_LINGUA as the second order criteria, where
        //      0 - English
        //      1 - Spanish
        foreach (Prova prova in dbProvasSet)
        {
            string gabarito = string.Concat(itemsDTO
                .Where(items => items.CO_PROVA == prova.ProvaId)
                .OrderBy(items => items.CO_POSICAO)
                .ThenBy(items => items.TP_LINGUA)
                .Select(items => items.TX_GABARITO));

            this.Gabaritos.Add(prova.ProvaId, gabarito);
        }
    }

    public void BulkTransferMicrodadosParticipantesToDb()
    {
        using StreamReader reader = new(PARTICIPANTES_FILE_PATH);
        using CsvReader csv = new(reader, CsvHelperConfig);
        IEnumerable<ParticipanteDTO> participantesDTO = csv.GetRecords<ParticipanteDTO>();

        IEnumerable<Participante> filteredParticipantes = participantesDTO
            .Where(participante =>
            {
                bool wasPresentInCH = participante.TP_PRESENCA_CH == 1;
                bool wasPresentInCN = participante.TP_PRESENCA_CN == 1;
                bool wasPresentInLC = participante.TP_PRESENCA_LC == 1;
                bool wasPresentInMT = participante.TP_PRESENCA_MT == 1;

                return wasPresentInCH && wasPresentInCN && wasPresentInLC && wasPresentInMT;
            })
            .Select(participante =>
            {
                int provaIdCH = participante.CO_PROVA_CH ?? -1;
                int provaIdCN = participante.CO_PROVA_CN ?? -1;
                int provaIdLC = participante.CO_PROVA_LC ?? -1;
                int provaIdMT = participante.CO_PROVA_MT ?? -1;

                string respostasCH = participante.TX_RESPOSTAS_CH ?? "";
                string respostasCN = participante.TX_RESPOSTAS_CN ?? "";
                string respostasLC = participante.TX_RESPOSTAS_LC ?? "";
                string respostasMT = participante.TX_RESPOSTAS_MT ?? "";

                return new Participante
                {
                    ParticipanteId = participante.NU_INSCRICAO,
                    Treineiro = participante.IN_TREINEIRO == 1,
                    TipoEscola = (SchoolType)(participante.TP_ESCOLA ?? 1),
                    Municipio = participante.NO_MUNICIPIO_ESC ?? "",
                    ProvaIdCH = provaIdCH,
                    ProvaIdCN = provaIdCN,
                    ProvaIdLC = provaIdLC,
                    ProvaIdMT = provaIdMT,
                    StatusRE = participante.TP_STATUS_REDACAO ?? -1,
                    LinguaEstrangeira = (ForeignLanguage)participante.TP_LINGUA,
                    RespostasCH = respostasCH,
                    RespostasCN = respostasCN,
                    RespostasLC = respostasLC,
                    RespostasMT = respostasMT,
                    AcertosCH = GetCorrectItemsCount(provaIdCH, respostasCH),
                    AcertosCN = GetCorrectItemsCount(provaIdCN, respostasCN),
                    AcertosLC = GetCorrectItemsCount(provaIdLC, respostasLC, participante.TP_LINGUA),
                    AcertosMT = GetCorrectItemsCount(provaIdMT, respostasMT),
                    NotaCH = participante.NU_NOTA_CH ?? -1,
                    NotaCN = participante.NU_NOTA_CN ?? -1,
                    NotaLC = participante.NU_NOTA_LC ?? -1,
                    NotaMT = participante.NU_NOTA_MT ?? -1,
                    NotaRE = participante.NU_NOTA_REDACAO ?? -1,
                    NotaRECompetencia1 = participante.NU_NOTA_COMP1 ?? -1,
                    NotaRECompetencia2 = participante.NU_NOTA_COMP2 ?? -1,
                    NotaRECompetencia3 = participante.NU_NOTA_COMP3 ?? -1,
                    NotaRECompetencia4 = participante.NU_NOTA_COMP4 ?? -1,
                    NotaRECompetencia5 = participante.NU_NOTA_COMP5 ?? -1,
                };
            });

        BulkConfig bulkConfig = new() { SetOutputIdentity = false };
        // There are approximately 4 million entries in the array,
        // we need to work in chunks to avoid OOM problems
        // 
        // ==> Chunk size can be optimized! <==
        // Current metrics for 4000 chunk size
        // - Time: 02:45
        // - Mem: 188.50 (MB)
        foreach (Participante[] batch in filteredParticipantes.Chunk(4000))
        {
            DbContext.BulkInsert(batch, bulkConfig);
        }
    }

    private int GetCorrectItemsCount(int provaId, string participantAnswers, int? language = null)
    {
        string testAnswers = this.Gabaritos[provaId];
        // If is LC exam answers
        if (language != null)
        {
            const int FOREIGN_SKIP = 10;
            const int FOREIGN_COUNT = 5;


            // Deal with foreign language questions
            string foreignLanguageAnswers = participantAnswers[..FOREIGN_COUNT];
            int correctItemsCount = foreignLanguageAnswers
                .Select((answer, index) => answer == testAnswers[index + language.Value] ? 1 : 0)
                .Sum();

            string remainingAnswers = participantAnswers[FOREIGN_COUNT..];
            correctItemsCount += remainingAnswers
                .Select((answer, index) => answer == testAnswers[index + FOREIGN_SKIP] ? 1 : 0)
                .Sum();
            return correctItemsCount;
        }
        else
        {
            return participantAnswers
                .Select((answer, index) => answer == testAnswers[index] ? 1 : 0)
                .Sum();
        }
    }
}


public class ItemEqualityComparer : IEqualityComparer<Item>
{
    public bool Equals(Item? x, Item? y)
    {
        return x?.ItemId == y?.ItemId;
    }

    public int GetHashCode(Item obj)
    {
        return obj.ItemId;
    }
}

public class ProvaEqualityComparer : IEqualityComparer<Prova>
{
    public bool Equals(Prova? x, Prova? y)
    {
        return x?.ProvaId == y?.ProvaId;
    }

    public int GetHashCode(Prova obj)
    {
        return obj.ProvaId;
    }
}