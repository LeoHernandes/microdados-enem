namespace Core.DbData
{
    public class Participante
    {
        public int ParticipanteId { get; set; }
        public bool Treineiro { get; set; }
        public string Municipio { get; set; } = default!;
        public int ProvaId { get; set; }
        public int StatusCH { get; set; }
        public int StatusCN { get; set; }
        public int StatusLC { get; set; }
        public int StatusMT { get; set; }
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

        public Item Item { get; set; } = default!;
    }
}
