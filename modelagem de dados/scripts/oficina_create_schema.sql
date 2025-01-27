create database oficina;

use oficina;

create table mecanico(
	idMecanico int auto_increment primary key,
    nome varchar(45) not null,
    endereco varchar(45) not null,
    especialização varchar(45) not null
);

create table ordemDeServico(
	idOS int auto_increment primary key,
    data_emissao date,
    data_entrega date,
    valor float,
    mecanicoId int,
    statusOS enum('Concluída', 'Em andamento', 'Não iniciada'),
    constraint fk_mecanicoId foreign key (mecanicoId) references mecanico(idMecanico)
);

create table servico(
	idServico int auto_increment primary key,
    tipoServico varchar(45)
);

create table servicosOS(
	OSId int,
    servicoId int,
    primary key (OSId, servicoId),
    constraint fk_servicos_OS foreign key (OSId) references ordemDeServico(idOS),
    constraint fk_OS_servicos foreign key (servicoId) references servico(idServico)
);

create table peca(
	idPeca int auto_increment primary key,
    descricaoPeca varchar(20)
);

create table pecaOS(
	OSId int,
    pecaId int,
    primary key (OSId, pecaId),
    constraint fk_pecas_OS foreign key (OSId) references ordemDeServico(idOS),
    constraint fk_OS_pecas foreign key (pecaId) references peca(idPeca)
);

create table cliente(
	clienteId int auto_increment primary key,
    nome varchar(45),
    identificacao varchar(45)
);

create table veiculo(
	idVeiculo int auto_increment primary key,
    placa char(7) not null,
    modelo varchar(45),
    ano year,
    idCliente int,
    constraint fk_veiculo_cliente foreign key (idCliente) references cliente(clienteId)
);

create table OSExecutadaVeiculo(
	idOrdem int,
    veiculoId int,
    idCliente int,
    OSAutorizada boolean,
    constraint fk_OS_veiculo_cliente foreign key (idOrdem) references ordemDeServico(idOS),
    constraint fk_veiculo_OS_cliente foreign key (veiculoId) references veiculo(idVeiculo),
    constraint fk_cliente_veiculo_OS foreign key (idCliente) references cliente(clienteId)
);

alter table mecanico auto_increment = 1;
alter table ordemDeServico auto_increment = 1;
alter table servico auto_increment = 1;
alter table peca auto_increment = 1;
alter table cliente auto_increment = 1;
alter table veiculo auto_increment = 1;

show tables;

