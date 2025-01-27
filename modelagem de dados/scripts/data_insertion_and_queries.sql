-- Inserindo dados na tabela 'cliente'
INSERT INTO cliente (nome, identificacao) VALUES
('João Silva', '123456789'),
('Maria Oliveira', '987654321'),
('Carlos Souza', '543216789'),
('Ana Costa', '112233445'),
('José Pereira', '998877665');

select * from cliente;

-- Inserindo dados na tabela 'mecanico'
INSERT INTO mecanico (nome, endereco, especialização) VALUES
('Roberto Santos', 'Rua A, 123', 'Mecânico Geral'),
('Fernanda Lima', 'Avenida B, 456', 'Eletricista Automotivo'),
('Carlos Martins', 'Rua C, 789', 'Mecânico de Suspensão'),
('Luciana Costa', 'Rua D, 101', 'Mecânico de Motor'),
('José Almeida', 'Avenida E, 202', 'Pintura Automotiva');

select * from mecanico;

-- Inserindo dados na tabela 'servico'
INSERT INTO servico (tipoServico) VALUES
('Troca de Óleo'),
('Reparo no Sistema de Suspensão'),
('Alinhamento e Balanceamento'),
('Troca de Pastilhas de Freio'),
('Reparo no Sistema Elétrico');

select * from servico;

-- Inserindo dados na tabela 'peca'
INSERT INTO peca (descricaoPeca) VALUES
('Pastilha de Freio'),
('Óleo Lubrificante'),
('Amortecedor'),
('Filtro de Ar'),
('Correia Dentada');

select * from peca;

-- Inserindo dados na tabela 'ordemDeServico'
INSERT INTO ordemDeServico (data_emissao, data_entrega, valor, mecanicoId, statusOS) VALUES
('2025-01-01', '2025-01-05', 250.00, 1, 'Em andamento'),
('2025-01-02', '2025-01-06', 350.00, 2, 'Concluída'),
('2025-01-03', '2025-01-07', 150.00, 3, 'Não iniciada'),
('2025-01-04', '2025-01-08', 500.00, 4, 'Em andamento'),
('2025-01-05', '2025-01-09', 200.00, 5, 'Concluída');

select * from ordemDeServico;

-- Inserindo dados na tabela 'servicosOS'
INSERT INTO servicosOS (OSId, servicoId) VALUES
(1, 1), (1, 3),
(2, 2), (2, 5),
(3, 4),
(4, 1), (4, 5),
(5, 3), (5, 4);

select * from servicosOS;

-- Inserindo dados na tabela 'pecaOS'
INSERT INTO pecaOS (OSId, pecaId) VALUES
(1, 1), (1, 3),
(2, 2), (2, 4),
(3, 1), (3, 5),
(4, 2), (4, 5),
(5, 3), (5, 4);

select * from pecaOS;

-- Inserindo dados na tabela 'veiculo'
INSERT INTO veiculo (placa, modelo, ano, idCliente) VALUES
('ABC1234', 'Fusca', 1975, 1),
('DEF5678', 'Civic', 2020, 2),
('GHI9101', 'Palio', 2007, 3),
('JKL1122', 'Fiesta', 2015, 4),
('MNO3344', 'Gol', 2019, 5);

select * from veiculo;

-- Inserindo dados na tabela 'OSExecutadaVeiculo'
INSERT INTO OSExecutadaVeiculo (idOrdem, veiculoId, idCliente, OSAutorizada) VALUES
(1, 1, 1, TRUE),
(2, 2, 2, TRUE),
(3, 3, 3, FALSE),
(4, 4, 4, TRUE),
(5, 5, 5, FALSE);

select * from OSExecutadaVeiculo;

-- quais mecânicos estão com OS com status "Em andamento"?
select idMecanico, nome, idOS, statusOS from mecanico
	inner join ordemDeServico on mecanicoId = idMecanico
    where statusOs = 'Em andamento';
    
-- quais clientes possuem veículos que já passaram por uma ordem de serviço?
select clienteId, nome as Nome, veiculoId, idOS as NumeroOS from cliente
	inner join OSExecutadaVeiculo on clienteId = idCliente
    inner join ordemDeServico on idOS = idOrdem
    where statusOS = 'Concluída';
    
-- quais serviços foram realizados na ordem de serviço com ID 2?
select servicoId, tipoServico from servico
	inner join servicosOS on servicoId = idServico
    where OSId = 2;
    
-- quais peças foram utilizadas nas ordens de serviço que custaram mais de R$ 300,00?
select idPeca, descricaoPeca as Descrição, OSId as OS from ordemDeServico
	inner join pecaOS on OSId = idOS
    inner join peca on idPeca = pecaId
    where valor >= 300;
    
-- quantas ordens de serviço cada mecânico já executou
select idMecanico, nome, count(*) from ordemDeServico
	inner join mecanico on idMecanico = mecanicoId
    group by idMecanico;