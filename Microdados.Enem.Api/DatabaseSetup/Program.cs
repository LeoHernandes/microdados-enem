using System.Globalization;
using Core.DbData;
using CsvHelper;
using CsvHelper.Configuration;
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

            CsvConfiguration csvHelperConfig = new(CultureInfo.InvariantCulture)
            {
                Delimiter = ";"
            };

            using StreamReader reader = new("./ITENS_PROVA_2023.csv");
            using CsvReader csv = new(reader, csvHelperConfig);
            {
                csv.Context.RegisterClassMap<ItemMap>();
                IEnumerable<Item>? items = csv.GetRecords<Item>();
                Console.WriteLine(items.Count());
                foreach (var item in items)
                {
                    dbContext.Add(item);
                }
                dbContext.SaveChanges();
            }
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

    public class ItemMap : ClassMap<Item>
    {
        public ItemMap()
        {
            Map(m => m.ItemId).Name("CO_ITEM");
            Map(m => m.ProvaId).Name("CO_PROVA");
            Map(m => m.HabilidadeId).Name("CO_HABILIDADE");
            Map(m => m.ParamDiscriminacao).Name("NU_PARAM_A");
            Map(m => m.ParamDificuldade).Name("NU_PARAM_B");
            Map(m => m.ParamAcaso).Name("NU_PARAM_C");
            Map(m => m.FoiAbandonado).Name("IN_ITEM_ABAN");
            Map(m => m.Gabarito).Name("TX_GABARITO");
        }
    }

}