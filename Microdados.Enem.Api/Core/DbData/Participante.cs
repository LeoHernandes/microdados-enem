namespace Core.DbData
{
    public class Participante
    {
        public long ParticipanteId { get; set; }
        public bool Treineiro { get; set; }
        public string Municipio { get; set; } = default!;
        public int ProvaIdCH { get; set; }
        public int ProvaIdCN { get; set; }
        public int ProvaIdLC { get; set; }
        public int ProvaIdMT { get; set; }
        public int StatusRE { get; set; }
        public string RespostasCH { get; set; } = default!;
        public string RespostasCN { get; set; } = default!;
        public string RespostasLC { get; set; } = default!;
        public string RespostasMT { get; set; } = default!;
        public float NotaCH { get; set; }
        public float NotaCN { get; set; }
        public float NotaLC { get; set; }
        public float NotaMT { get; set; }
        public float NotaRE { get; set; }
        public float NotaRECompetencia1 { get; set; }
        public float NotaRECompetencia2 { get; set; }
        public float NotaRECompetencia3 { get; set; }
        public float NotaRECompetencia4 { get; set; }
        public float NotaRECompetencia5 { get; set; }

        public Prova ProvaCH { get; set; } = default!;
        public Prova ProvaCN { get; set; } = default!;
        public Prova ProvaLC { get; set; } = default!;
        public Prova ProvaMT { get; set; } = default!;
    }
}
