drop database cuidarmais;
create database cuidarmais;

create table cuidador(
	idcuidador int auto_increment primary key,
    nome varchar(100),
    email varchar(100),
    senha char(8),
    telefone varchar(20),
    idade int,
    genero char(2)
);

create table nivelCuidado(
	idnivelcuidado int auto_increment primary key,
    descricao varchar(255)
);

create table paciente(
	idpaciente int auto_increment primary key,
    nome varchar(100),
    email_responsavel varchar(100),
    nome_responsavel  varchar(100),
    idade int,
    genero char(2),
    idcuidador int,
    idnivelcuidado int,
    foreign key (idcuidador) references cuidador(idcuidador),
    foreign key (idnivelcuidado) references nivelCuidado(idnivelcuidado)
);

create table listaCompra(
	idlistaCompra int auto_increment primary key,
    descricao varchar(255),
    quantidade int,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table contatoEmergencia(
	idcontatoEmergencia int auto_increment primary key,
    nome varchar(100),
    telefone varchar(20),
    parentesco varchar(100),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table escala(
	idescala int auto_increment primary key,
    data_hora datetime,
    dia_semana varchar(50),
    dtAlteracao datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table pontoEletronico(
	idpontoEletronico int auto_increment primary key,
    data_hora_entrada datetime,
    data_hora_saida datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadomedicao_lista(
	idcuidadomedicacao_lista int auto_increment primary key,
    medicamento varchar(255),
    dosagem varchar(10),
    hora time,
    tipo varchar(50),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidado(
	idcuidado int auto_increment primary key,
    data_hora datetime,
    realizado boolean default 0,
    horario_realizado time,
    tipo_cuidado int,
    cuidado varchar(255),
    descricao varchar(255), 
    avaliacao boolean,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente),
    idcuidadomedicacao_lista int,
    foreign key (idcuidadomedicacao_lista) references cuidadomedicao_lista(idcuidadomedicacao_lista)
);

create table cuidado_sinaisvitais(
	idcuidado_sinaisvitais int auto_increment primary key,
    pressao_sistolica varchar(10),
    pressao_diastolica varchar(10),
    temperatura varchar(10),
    frequencia_respiratoria varchar(10),
    frequencia_cardiaca varchar(10),
    data_hora datetime,
    descricao varchar(255), 
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadoferida_lista(
	idcuidadoferida_lista int auto_increment primary key,
    ferida varchar(255),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadoequipamento_lista(
	idcuidadoequipamento_lista int auto_increment primary key,
    equipamento varchar(255),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidado_mudancadecubito(
	idcuidado_mudancadecubito int auto_increment primary key,
    mudanca varchar(255),
    hora time,
    data_hora datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);
