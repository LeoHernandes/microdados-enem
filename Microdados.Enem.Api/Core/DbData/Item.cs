namespace Core.DbData
{
    public class Item
    {
        public int ItemId { get; set; }
        public int ProvaId { get; set; }
        public int HabilidadeId { get; set; }
        public double ParamDescricao { get; set; }
        public double ParamDificuldade { get; set; }
        public double ParamAcaso { get; set; }
        public bool FoiAbandonado { get; set; }
        public char Gabarito { get; set; }
        public string? Lingua { get; set; }

        public Prova Prova { get; set; } = default!;
    }
}