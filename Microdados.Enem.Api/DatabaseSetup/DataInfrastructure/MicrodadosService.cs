using System.Globalization;
using System.Text;
using Core.DbData;
using CsvHelper;
using CsvHelper.Configuration;
using EFCore.BulkExtensions;

namespace DatabaseSetup.DataInfrastructure;

public class MicrodadosService(AppDbContext dbContext)
{
    private const string ITENS_FILE_PATH = "./ITENS_PROVA_2023.csv";
    private const string PARTICIPANTES_FILE_PATH = "./MICRODADOS_ENEM_2023.csv";

    private AppDbContext DbContext { get; set; } = dbContext;
    private readonly CsvConfiguration CsvHelperConfig = new(CultureInfo.InvariantCulture)
    {
        Delimiter = ";",
        HasHeaderRecord = true,
        Encoding = Encoding.Latin1
    };


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
                ProvaId = item.CO_PROVA
            })];

        HashSet<Prova> dbProvasSet = itemsDTO
            .Select(item => new Prova
            {
                ProvaId = item.CO_PROVA,
                AreaSigla = item.SG_AREA,
                Cor = item.TX_COR == "LEITOR TELA" ? null : item.TX_COR,
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
                LinguaEstrangeira = item.TP_LINGUA == 0 ? "Espanhol" : "Inglês",
            })
            .ToHashSet(new ItemEqualityComparer());

        DbContext.Itens.AddRange(dbItensSet);
        DbContext.ItensPorProvas.AddRange(dbItensPorProvas);
        DbContext.Provas.AddRange(dbProvasSet);
        DbContext.SaveChanges();
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
            .Select(participante => new Participante
            {
                ParticipanteId = participante.NU_INSCRICAO,
                Treineiro = participante.IN_TREINEIRO == 1,
                Municipio = participante.NO_MUNICIPIO_ESC ?? "",
                ProvaIdCH = participante.CO_PROVA_CH ?? -1,
                ProvaIdCN = participante.CO_PROVA_CN ?? -1,
                ProvaIdLC = participante.CO_PROVA_LC ?? -1,
                ProvaIdMT = participante.CO_PROVA_MT ?? -1,
                StatusRE = participante.TP_STATUS_REDACAO ?? -1,
                RespostasCH = participante.TX_RESPOSTAS_CH ?? "",
                RespostasCN = participante.TX_RESPOSTAS_CN ?? "",
                RespostasLC = participante.TX_RESPOSTAS_LC ?? "",
                RespostasMT = participante.TX_RESPOSTAS_MT ?? "",
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