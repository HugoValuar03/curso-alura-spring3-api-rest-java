CREATE TABLE usuarios (
                          id BIGINT NOT NULL AUTO_INCREMENT,
                          login VARCHAR(100) NOT NULL,
                          senha VARCHAR(255) NOT NULL,

                          PRIMARY KEY (id),
                          UNIQUE (login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE medicos (
                         id BIGINT NOT NULL AUTO_INCREMENT,
                         nome VARCHAR(100) NOT NULL,
                         email VARCHAR(100) NOT NULL,
                         crm VARCHAR(6) NOT NULL,
                         especialidade VARCHAR(100) NOT NULL,
                         logradouro VARCHAR(100) NOT NULL,
                         bairro VARCHAR(100) NOT NULL,
                         cep VARCHAR(9) NOT NULL,
                         complemento VARCHAR(100),
                         numero VARCHAR(20),
                         uf CHAR(2) NOT NULL,
                         cidade VARCHAR(100) NOT NULL,
                         telefone VARCHAR(20) NOT NULL,
                         ativo TINYINT,

                         PRIMARY KEY (id),
                         UNIQUE (crm),
                         UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pacientes (
                           id BIGINT NOT NULL AUTO_INCREMENT,
                           nome VARCHAR(100) NOT NULL,
                           email VARCHAR(100) NOT NULL,
                           telefone VARCHAR(20) NOT NULL,
                           logradouro VARCHAR(100) NOT NULL,
                           bairro VARCHAR(100) NOT NULL,
                           cep VARCHAR(9) NOT NULL,
                           complemento VARCHAR(100),
                           numero VARCHAR(20),
                           uf CHAR(2) NOT NULL,
                           cidade VARCHAR(100) NOT NULL,
                           cpf VARCHAR(11) NOT NULL,
                           ativo TINYINT DEFAULT 1,

                           PRIMARY KEY (id),
                           UNIQUE (email),
                           UNIQUE (cpf)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE consultas (
                           id BIGINT NOT NULL AUTO_INCREMENT,
                           medico_id BIGINT NOT NULL,
                           paciente_id BIGINT NOT NULL,
                           data_consulta DATETIME NOT NULL,
                           motivo VARCHAR(255),
                           cancelada TINYINT DEFAULT 0,

                           PRIMARY KEY (id),

                           CONSTRAINT fk_consulta_medico
                               FOREIGN KEY (medico_id)
                                   REFERENCES medicos (id),

                           CONSTRAINT fk_consulta_paciente
                               FOREIGN KEY (paciente_id)
                                   REFERENCES pacientes (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO medicos (
    nome, email, crm, especialidade,
    logradouro, bairro, cep, complemento, numero,
    uf, cidade, telefone, ativo
) VALUES
      (
          'Rodrigo Ferreira',
          'rodrigo.ferreira@voll.med',
          '123456',
          'ORTOPEDIA',
          'Rua 1',
          'Bairro',
          '12345678',
          'Complemento',
          '1',
          'DF',
          'Brasília',
          '61981230000',
          1
      ),
      (
          'João Carlos',
          'joao.carlos@voll.med',
          '123999',
          'ORTOPEDIA',
          'Rua 1',
          'Bairro',
          '12345678',
          'Complemento',
          '1',
          'DF',
          'Brasília',
          '61988880000',
          0
      ),
      (
          'Carla Azevedo',
          'carla.azevedo@voll.med',
          '188777',
          'ORTOPEDIA',
          'Rua 1',
          'Bairro',
          '12345678',
          'Complemento',
          '1',
          'DF',
          'Brasília',
          '63984460331',
          1
      ),
      (
          'Carla Azeite',
          'carla.az@voll.med',
          '132132',
          'ORTOPEDIA',
          'Rua 1',
          'Bairro',
          '12345678',
          'Complemento',
          '1',
          'DF',
          'Brasília',
          '61981230000',
          1
      );

INSERT INTO pacientes (
    nome, email, telefone,
    logradouro, bairro, cep, complemento, numero,
    uf, cidade, cpf, ativo
) VALUES
      (
          'Ana Paula Souza',
          'ana.souza@email.com',
          '11999990000',
          'Rua das Flores',
          'Centro',
          '01001000',
          'Apto 12',
          '120',
          'SP',
          'São Paulo',
          '12312312312',
          1
      ),
      (
          'Bruno Henrique Lima',
          'bruno.lima@email.com',
          '21988887777',
          'Av. Brasil',
          'Jardim América',
          '22290040',
          'Casa',
          '850',
          'RJ',
          'Rio de Janeiro',
          '12312312313',
          1
      ),
      (
          'Carla Mendes Ribeiro',
          'carla.ribeiro@email.com',
          '31977776666',
          'Rua Bahia',
          'Savassi',
          '30140071',
          'Bloco B',
          '45',
          'MG',
          'Belo Horizonte',
          '12312312315',
          1
      ),
      (
          'Diego Fernandes Alves',
          'diego.alves@email.com',
          '81966665555',
          'Rua do Comércio',
          'Boa Viagem',
          '51011000',
          'Sala 03',
          '300',
          'PE',
          'Recife',
          '12312312311',
          1
      ),
      (
          'Eduarda Martins Costa',
          'eduarda.costa@email.com',
          '51955554444',
          'Rua das Palmeiras',
          'Três Figueiras',
          '91330002',
          'Fundos',
          '78',
          'RS',
          'Porto Alegre',
          '12312312314',
          1
      );
