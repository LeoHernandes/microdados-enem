using System.Globalization;
using System.Text;
using Core.DbData;
using CsvHelper;
using CsvHelper.Configuration;

namespace DatabaseSetup.DataInfrastructure;

public class MicrodadosService(AppDbContext dbContext)
{
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
        using StreamReader reader = new("./ITENS_PROVA_2023.csv");
        using CsvReader csv = new(reader, CsvHelperConfig);
        {
            itemsDTO = [.. csv.GetRecords<ItemProvaDTO>()];
        }

        ItemPorProva[] dbItensPorProvas = itemsDTO
            .Select(item => new ItemPorProva
            {
                ItemId = item.CO_ITEM,
                ProvaId = item.CO_PROVA
            })
            .ToArray();

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



    public void TransferMicrodadosParticipantesToDb()
    {
        const int INSERTION_BATCH_SIZE = 1000;

        IEnumerable<ParticipanteDTO> participantesDTO;
        using StreamReader reader = new("./MICRODADOS_ENEM_2023.csv");
        using CsvReader csv = new(reader, CsvHelperConfig);
        {
            participantesDTO = csv.GetRecords<ParticipanteDTO>();
        }

        int insertionElementsCount = 0;
        int insertionCount = 0;
        IEnumerable<Participante> participantesToInsert = [];
        foreach (var participante in participantesDTO)
        {
            bool wasPresentInCH = Convert.ToBoolean(participante.TP_PRESENCA_CH);
            bool wasPresentInCN = Convert.ToBoolean(participante.TP_PRESENCA_CN);
            bool wasPresentInLC = Convert.ToBoolean(participante.TP_PRESENCA_LC);
            bool wasPresentInMT = Convert.ToBoolean(participante.TP_PRESENCA_MT);

            if (!wasPresentInCH || !wasPresentInCN || !wasPresentInLC || !wasPresentInMT)
            {
                continue;
            }

            participantesToInsert = participantesToInsert.Append(new Participante
            {
                ParticipanteId = participante.NU_INSCRICAO,
                Treineiro = participante.IN_TREINEIRO == 1,
                Municipio = participante.NO_MUNICIPIO_ESC ?? "",
                ProvaIdCH = participante.CO_PROVA_CH ?? -1,
                ProvaIdCN = participante.CO_PROVA_CN ?? -1,
                ProvaIdLC = participante.CO_PROVA_LC ?? -1,
                ProvaIdMT = participante.CO_PROVA_MT ?? -1,
                StatusCH = participante.TP_PRESENCA_CH,
                StatusCN = participante.TP_PRESENCA_CN,
                StatusLC = participante.TP_PRESENCA_LC,
                StatusMT = participante.TP_PRESENCA_MT,
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
            insertionElementsCount++;

            if (insertionElementsCount == INSERTION_BATCH_SIZE)
            {
                DbContext.Participantes.AddRange(participantesToInsert);
                DbContext.SaveChanges();
                insertionElementsCount = 0;
                participantesToInsert = [];
                Console.WriteLine($"{++insertionCount}");
            }
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