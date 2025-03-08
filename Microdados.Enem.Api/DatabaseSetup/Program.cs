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
            dbContext.ChangeTracker.AutoDetectChangesEnabled = false;

            MicrodadosService microdadosService = new(dbContext);

            microdadosService.TransferMicrodadosItemsToDb();
            microdadosService.BulkTransferMicrodadosParticipantesToDb();
        }

        private static ServiceProvider ConfigureServices()
        {
            ServiceCollection services = new();

            services.AddDbContext<AppDbContext>(options =>
            {
                options.UseSqlite("Data Source=/home/leo/git/microdados-enem/Microdados.Enem.Api/Database/test.db;Mode=ReadWrite;");
            });

            return services.BuildServiceProvider();
        }
    }
}