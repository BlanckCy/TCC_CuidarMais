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

/*create table nivelCuidado(
	idnivelcuidado int auto_increment primary key,
    descricao varchar(255)
);*/

create table paciente(
	idpaciente int auto_increment primary key,
    nome varchar(100),
    email_responsavel varchar(100),
    nome_responsavel  varchar(100),
    idade int,
    genero char(2),
    idcuidador int,
    foreign key (idcuidador) references cuidador(idcuidador)
    -- idnivelcuidado int,
    -- foreign key (idnivelcuidado) references nivelCuidado(idnivelcuidado)
);

create table lista_compra(
	idlista_compra int auto_increment primary key,
    descricao varchar(255),
    quantidade int,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table contato_emergencia(
	idcontato_emergencia int auto_increment primary key,
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

create table rotina(
	idrotina int auto_increment primary key,
    data_hora datetime,
    realizado boolean default 0,
    tipo_cuidado int,
    cuidado varchar(255),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidado_medicacao_lista(
	idcuidado_medicacao_lista int auto_increment primary key,
    medicamento varchar(255),
    dosagem varchar(10),
    hora time,
    tipo varchar(50),
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente)
);

create table cuidado_medicacao(
	idcuidado_medicacao int auto_increment primary key,
    data_hora datetime,
    realizado boolean default 0,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente),
    idcuidado_medicacao_lista int,
    foreign key (idcuidado_medicacao_lista) references cuidado_medicacao_lista(idcuidado_medicacao_lista),
    idrotina int,
    foreign key (idrotina) references rotina(idrotina)
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
    foreign key (idpaciente) references paciente(idpaciente),
    idrotina int,
    foreign key (idrotina) references rotina(idrotina)
);

create table cuidado_mudancadecubito(
	idcuidado_mudancadecubito int auto_increment primary key,
    mudanca varchar(255),
    hora time,
    data_hora datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente),
    idrotina int,
    foreign key (idrotina) references rotina(idrotina)
);

create table cuidado_higiene(
	idcuidado_higiene int auto_increment primary key,
    tarefa varchar(255),
    hora time,
    data_hora datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente),
    idrotina int,
    foreign key (idrotina) references rotina(idrotina)
);

create table cuidado_atividadefisica(
	idcuidado_atividadefisica int auto_increment primary key,
    avaliacao boolean,
    hora time,
    descricao varchar(255),
    data_hora datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente),
    idrotina int,
    foreign key (idrotina) references rotina(idrotina)
);

create table cuidado_refeicao(
	idcuidado_refeicao int auto_increment primary key,
    avaliacao_cafe boolean,
    hora_cafe time,
    descricao_cafe varchar(255),
    avaliacao_almoco boolean,
    hora_almoco time,
    descricao_almoco varchar(255),
    descricao_jantar varchar(255),
    avaliacao_jantar boolean,
    hora_jantar time,
    data_hora datetime,
    idpaciente int,
    foreign key (idpaciente) references paciente(idpaciente),
    idrotina int,
    foreign key (idrotina) references rotina(idrotina)
);

