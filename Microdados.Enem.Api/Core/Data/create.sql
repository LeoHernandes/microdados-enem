CREATE TABLE IF NOT EXISTS Itens (
        ItemId INTEGER NOT NULL PRIMARY KEY,
        HabilidadeId INTEGER NOT NULL,
        ParamDiscriminacao REAL NULL,
        ParamDificuldade REAL NULL,
        ParamAcaso REAL NULL,
        FoiAbandonado INTEGER NOT NULL,
        Gabarito TEXT NOT NULL,
        LinguaEstrangeira TEXT NULL
);

CREATE TABLE IF NOT EXISTS ItensPorProvas (
        ItemId INTEGER NOT NULL,
        ProvaId INTEGER NOT NULL,
        PRIMARY KEY (ItemId, ProvaId)
);

CREATE TABLE IF NOT EXISTS Provas (
        ProvaId INTEGER NOT NULL PRIMARY KEY,
        AreaSigla TEXT NOT NULL,
        Cor TEXT NULL
);

CREATE TABLE IF NOT EXISTS Participantes
(
        ParticipanteId TEXT NOT NULL PRIMARY KEY,
        Treineiro INTEGER NOT NULL,
        Municipio TEXT NOT NULL,
        ProvaIdCH INTEGER NOT NULL,
        ProvaIdCN INTEGER NOT NULL,
        ProvaIdLC INTEGER NOT NULL,
        ProvaIdMT INTEGER NOT NULL,
        StatusRE INTEGER NOT NULL,
        RespostasCH TEXT NOT NULL,
        RespostasCN TEXT NOT NULL,
        RespostasLC TEXT NOT NULL,
        RespostasMT TEXT NOT NULL,
        NotaCH REAL NOT NULL,
        NotaCN REAL NOT NULL,
        NotaLC REAL NOT NULL,
        NotaMT REAL NOT NULL,
        NotaRE REAL NOT NULL,
        NotaRECompetencia1 REAL NOT NULL,
        NotaRECompetencia2 REAL NOT NULL,
        NotaRECompetencia3 REAL NOT NULL,
        NotaRECompetencia4 REAL NOT NULL,
        NotaRECompetencia5 REAL NOT NULL
);