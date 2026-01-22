ALTER TABLE consultas
    DROP COLUMN motivo,
    DROP COLUMN cancelada,
    CHANGE COLUMN data_consulta data DATETIME NOT NULL;
