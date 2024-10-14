CREATE TABLE IF NOT EXISTS Itens (
        ItemId INTEGER NOT NULL PRIMARY KEY,
        AreaId INTEGER NOT NULL,
        HabilidadeId INTEGER NOT NULL,
        ParamDiscriminacao REAL NOT NULL,
        ParamDificuldade REAL NOT NULL,
        ParamAcaso REAL NOT NULL,
        FoiAbandonado INTEGER NOT NULL,
        ProvaId INTEGER NOT NULL,
        Gabarito TEXT NOT NULL,
        LinguaEstrangeira TEXT NULL
);
