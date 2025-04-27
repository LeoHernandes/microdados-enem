namespace Core.Data.Models;

public class ItemPorProva
{
    public int ItemId { get; set; }
    public int ProvaId { get; set; }
    public int Posicao { get; set; }

    public Item Item { get; set; } = default!;
    public Prova Prova { get; set; } = default!;
}