namespace Microdados.Enem.API.DbData
{
    public class Item
    {
        public int ItemId { get; set; }
        public int AreaId { get; set; }
        public int HabilidadeId { get; set; }
        public double ParamDescricao { get; set; }
        public double ParamDificuldade { get; set; }
        public double ParamAcaso { get; set; }
        public bool FoiAbandonado { get; set; }
        public int ProvaId { get; set; }
        public int LinguaId { get; set; }
        public char Gabarito { get; set; }
    }
}