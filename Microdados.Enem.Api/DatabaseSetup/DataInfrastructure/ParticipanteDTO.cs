namespace DatabaseSetup.DataInfrastructure;

public class ParticipanteDTO
{
    public string NU_INSCRICAO { get; set; } = default!;
    public int IN_TREINEIRO { get; set; }
    public string? NO_MUNICIPIO_ESC { get; set; } = default!;
    public int? CO_PROVA_CN { get; set; }
    public int? CO_PROVA_CH { get; set; }
    public int? CO_PROVA_LC { get; set; }
    public int? CO_PROVA_MT { get; set; }
    public int TP_LINGUA { get; set; }
    public int TP_PRESENCA_CN { get; set; }
    public int TP_PRESENCA_CH { get; set; }
    public int TP_PRESENCA_LC { get; set; }
    public int TP_PRESENCA_MT { get; set; }
    public int? TP_STATUS_REDACAO { get; set; }
    public string? TX_RESPOSTAS_CN { get; set; } = default!;
    public string? TX_RESPOSTAS_CH { get; set; } = default!;
    public string? TX_RESPOSTAS_LC { get; set; } = default!;
    public string? TX_RESPOSTAS_MT { get; set; } = default!;
    public float? NU_NOTA_CN { get; set; }
    public float? NU_NOTA_CH { get; set; }
    public float? NU_NOTA_LC { get; set; }
    public float? NU_NOTA_MT { get; set; }
    public int? NU_NOTA_REDACAO { get; set; }
    public int? NU_NOTA_COMP1 { get; set; }
    public int? NU_NOTA_COMP2 { get; set; }
    public int? NU_NOTA_COMP3 { get; set; }
    public int? NU_NOTA_COMP4 { get; set; }
    public int? NU_NOTA_COMP5 { get; set; }
}