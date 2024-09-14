using Microsoft.EntityFrameworkCore;

namespace Core.DbData
{

    public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
    {
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Item>(entity =>
            {
                entity.ToTable("Itens");
                entity.HasKey(item => item.ItemId);
            });

            modelBuilder.Entity<Participante>(entity =>
            {
                entity.ToTable("Participantes");
                entity.HasKey(participante => participante.ParticipanteId);
            });
        }

        public DbSet<Item> Itens { get; set; }
        public DbSet<Participante> Participantes { get; set; }
    }
}