namespace DatabaseSetup.DataInfrastructure;

public class ItemProvaDTO
{
    public int CO_POSICAO { get; set; }
    public int CO_ITEM { get; set; }
    public int CO_PROVA { get; set; }
    public string SG_AREA { get; set; } = default!;
    public int CO_HABILIDADE { get; set; }
    public double? NU_PARAM_A { get; set; }
    public double? NU_PARAM_B { get; set; }
    public double? NU_PARAM_C { get; set; }
    public bool IN_ITEM_ABAN { get; set; }
    public char TX_GABARITO { get; set; }
    public string TX_COR { get; set; } = default!;
    public int? TP_LINGUA { get; set; }
}