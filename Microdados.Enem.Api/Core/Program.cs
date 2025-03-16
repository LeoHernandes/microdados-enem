using Core.Data;
using Microsoft.EntityFrameworkCore;

internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers();
        builder.Services.AddCors();

        builder.Services.AddDbContext<AppDbContext>(options =>
        {
            string? connectionString = builder.Configuration
                .GetRequiredSection("DatabaseSettings")
                .GetValue<string>("SQLiteConnectionString") ?? throw new ApplicationException();

            options.UseSqlite(connectionString);
        });

        var app = builder.Build();

        app.UseRouting();

        app.UseCors(builder =>
            builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());

        app.UseAuthentication();

        app.UseAuthorization();

        app.MapControllers();

        app.Run();
    }
}
