namespace Core.Data.Models;

public class Item
{
    public int ItemId { get; set; }
    public int HabilidadeId { get; set; }
    public double? ParamDiscriminacao { get; set; }
    public double? ParamDificuldade { get; set; }
    public double? ParamAcaso { get; set; }
    public bool FoiAbandonado { get; set; }
    public char Gabarito { get; set; }
    public ForeignLanguage? LinguaEstrangeira { get; set; }

    public IEnumerable<ItemPorProva> ProvasPorItem { get; set; } = default!;
}