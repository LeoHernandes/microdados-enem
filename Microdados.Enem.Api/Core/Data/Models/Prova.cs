using System.ComponentModel.DataAnnotations.Schema;

namespace Core.Data.Models;

public class Prova
{
    public int ProvaId { get; set; }
    public string AreaSigla { get; set; } = default!;
    public string? Cor { get; set; }
    public bool Reaplicacao { get; set; }

    public IEnumerable<Participante> ParticipantesCH { get; set; } = default!;
    public IEnumerable<Participante> ParticipantesCN { get; set; } = default!;
    public IEnumerable<Participante> ParticipantesLC { get; set; } = default!;
    public IEnumerable<Participante> ParticipantesMT { get; set; } = default!;

    public IEnumerable<ItemPorProva> ItensPorProva { get; set; } = default!;
}