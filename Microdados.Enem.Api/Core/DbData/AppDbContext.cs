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
                entity.HasKey(i => i.ItemId);

                entity.HasOne(i => i.Prova)
                .WithMany(prova => prova.Itens)
                .HasForeignKey(i => i.ProvaId);
            });

            modelBuilder.Entity<Prova>(entity =>
            {
                entity.ToTable("Provas");
                entity.HasKey(i => i.ProvaId);
            });

            modelBuilder.Entity<Participante>(entity =>
            {
                entity.ToTable("Participantes");
                entity.HasKey(p => p.ParticipanteId);

                entity.HasOne(part => part.ProvaCH)
                    .WithMany(prova => prova.Participantes)
                    .HasForeignKey(part => part.ProvaIdCH);

                entity.HasOne(part => part.ProvaCN)
                    .WithMany(prova => prova.Participantes)
                    .HasForeignKey(part => part.ProvaIdCN);

                entity.HasOne(part => part.ProvaLC)
                    .WithMany(prova => prova.Participantes)
                    .HasForeignKey(part => part.ProvaIdLC);

                entity.HasOne(part => part.ProvaMT)
                    .WithMany(prova => prova.Participantes)
                    .HasForeignKey(part => part.ProvaIdMT);
            });
        }

        public DbSet<Item> Itens { get; set; }
        public DbSet<Prova> Provas { get; set; }
        public DbSet<Participante> Participantes { get; set; }
    }
}