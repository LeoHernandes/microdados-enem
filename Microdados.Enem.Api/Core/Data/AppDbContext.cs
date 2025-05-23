using Core.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace Core.Data;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Item>(entity =>
        {
            entity.ToTable("Itens");
            entity.HasKey(i => i.ItemId);

            entity.HasMany(i => i.ProvasPorItem)
                .WithOne(ip => ip.Item)
                .HasForeignKey(ip => ip.ItemId);

            entity.Property(i => i.LinguaEstrangeira)
                .HasConversion<int>();
        });

        modelBuilder.Entity<ItemPorProva>(entity =>
        {
            entity.ToTable("ItensPorProvas");
            entity.HasKey(e => new { e.ItemId, e.ProvaId });

            entity.Property(e => e.Posicao).IsRequired();
        });

        modelBuilder.Entity<Prova>(entity =>
        {
            entity.ToTable("Provas");
            entity.HasKey(p => p.ProvaId);

            entity.HasMany(p => p.ItensPorProva)
                .WithOne(ip => ip.Prova)
                .HasForeignKey(ip => ip.ProvaId);
        });

        modelBuilder.Entity<Participante>(entity =>
        {
            entity.ToTable("Participantes");
            entity.HasKey(p => p.ParticipanteId);

            entity.Property(p => p.LinguaEstrangeira)
                .HasConversion<int>();

            entity.Property(p => p.TipoEscola)
                .HasConversion<int>();

            entity.HasOne(part => part.ProvaCH)
                .WithMany(prova => prova.ParticipantesCH)
                .HasForeignKey(part => part.ProvaIdCH);

            entity.HasOne(part => part.ProvaCN)
                .WithMany(prova => prova.ParticipantesCN)
                .HasForeignKey(part => part.ProvaIdCN);

            entity.HasOne(part => part.ProvaLC)
                .WithMany(prova => prova.ParticipantesLC)
                .HasForeignKey(part => part.ProvaIdLC);

            entity.HasOne(part => part.ProvaMT)
                .WithMany(prova => prova.ParticipantesMT)
                .HasForeignKey(part => part.ProvaIdMT);
        });
    }

    public DbSet<Item> Itens { get; set; }
    public DbSet<Prova> Provas { get; set; }
    public DbSet<Participante> Participantes { get; set; }
    public DbSet<ItemPorProva> ItensPorProvas { get; set; }
}