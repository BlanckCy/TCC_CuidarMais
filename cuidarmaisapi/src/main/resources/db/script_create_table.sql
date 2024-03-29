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
    data_hora timestamp,
    dia_semana varchar(50),
    dtAlteracao timestamp,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table pontoEletronico(
	idpontoEletronico int auto_increment primary key,
    data_hora_entrada timestamp,
    data_hora_saida timestamp,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidado(
	idcuidado int auto_increment primary key,
    data_hora timestamp,
    realizado boolean default 0,
    tipo_cuidado int,
    descricao varchar(255), 
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadoSinalVital(
	idcuidadoSinalVital int auto_increment primary key,
    pressao_arterial varchar(100),
    temperatura varchar(100),
    saturacao varchar(100),
    glicose varchar(100),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadoMedicaoLista(
	idcuidadoMedicacaoLista int auto_increment primary key,
    medicamento varchar(255),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadoFeridaLista(
	idcuidadoFeridaLista int auto_increment primary key,
    ferida varchar(255),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidadoEquipamentoLista(
	idcuidadoEquipamentoLista int auto_increment primary key,
    equipamento varchar(255),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);
