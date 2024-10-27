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
        Cor TEXT NULL,
        Adaptacao TEXT NULL
);