using Core.Controllers;

namespace Core.DbData
{
    public class Prova
    {
        public int ProvaId { get; set; }
        public string AreaSigla { get; set; } = default!;
        public string Cor { get; set; } = default!;
        public string Adaptacao { get; set; } = default!;

        public IEnumerable<Participante> Participantes { get; set; } = default!;
        public IEnumerable<Item> Itens { get; set; } = default!;
    }
}