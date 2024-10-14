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
                IEnumerable<ItemProvaDTO>? items = csv.GetRecords<ItemProvaDTO>();

                Console.WriteLine(items.Count());
            }
        }

        private class Foo : IEqualityComparer<Item>
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

    public class ItemProvaDTO
    {
        public int CO_ITEM { get; set; }
        public int CO_PROVA { get; set; }
        public int CO_HABILIDADE { get; set; }
        public double? NU_PARAM_A { get; set; }
        public double? NU_PARAM_B { get; set; }
        public double? NU_PARAM_C { get; set; }
        public bool IN_ITEM_ABAN { get; set; }
        public char TX_GABARITO { get; set; }
        public string? TP_LINGUA { get; set; }
    }
}