using Microdados.Enem.API.DbData;
using Microsoft.EntityFrameworkCore;

internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers();
        builder.Services.AddCors();

        builder.Services.AddDbContext<AppDbContext>((provider, options) =>
        {
            options.UseSqlite("Data Source={/home/leo/git/microdados-enem/test.db}"); // <-- get this from env (options)
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
