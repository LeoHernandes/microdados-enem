CREATE TABLE IF NOT EXISTS Itens (
        ItemId INTEGER NOT NULL PRIMARY KEY,
        AreaId INTEGER NOT NULL,
        HabilidadeId INTEGER NOT NULL,
        ParamDescricao REAL NOT NULL,
        ParamDificuldade REAL NOT NULL,
        ParamAcaso REAL NOT NULL,
        FoiAbandonado INTEGER NOT NULL,
        ProvaId INTEGER NOT NULL,
        LinguaId INTEGER NOT NULL,
        Gabarito TEXT NOT NULL
);