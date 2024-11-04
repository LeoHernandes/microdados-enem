using Core.DbData;
using DatabaseSetup.DataInfrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace DatabaseSetup
{
    internal class Program
    {
        private static void Main()
        {
            ServiceProvider services = ConfigureServices();
            AppDbContext dbContext = services.GetRequiredService<AppDbContext>();
            MicrodadosReader reader = new();

            ItemProvaDTO[] itemsDTO = reader.GetMicrodadosItems();

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

            dbContext.Itens.AddRange(dbItensSet);
            dbContext.ItensPorProvas.AddRange(dbItensPorProvas);
            dbContext.Provas.AddRange(dbProvasSet);
            dbContext.SaveChanges();
        }

        private static ServiceProvider ConfigureServices()
        {
            ServiceCollection services = new();

            services.AddDbContext<AppDbContext>(options =>
            {
                options.UseSqlite("Data Source=/home/leo/git/microdados-enem/Microdados.Enem.Api/Database/test.db;Mode=ReadWrite;"); // <-- get this from env (options)
            });

            return services.BuildServiceProvider();
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
}