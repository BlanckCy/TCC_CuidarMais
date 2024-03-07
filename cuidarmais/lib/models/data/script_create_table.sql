create table cuidador(
	idcuidador int auto_increment primary key,
    nome varchar(100),
    email varchar(100),
    senha char(8),
    telefone varchar(20),
    idade int,
    genero char(2)
);

create table paciente(
	idpaciente int auto_increment primary key,
    nome varchar(100),
    email_responsavel varchar(100),
    nome_responsavel  varchar(100),
    idade int,
    genero char(2)
);

create table nivelCuidado(
	idnivelCuidado int auto_increment primary key,
    descricao varchar(255)
);

create table vincularPaciente(
	idvincularPaciente int auto_increment primary key,
    idcuidador int,
	idpaciente int,
    idnivelCuidado int,
    foreign key (idcuidador) references cuidador(idcuidador),
    foreign key (idpaciente) references paciente(idpaciente),
    foreign key (idnivelCuidado) references nivelCuidado(idnivelCuidado)
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
    cuidado varchar(255), 
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

/*

-- acho que não precisa
create table cuidadoRefeicao(
	idcuidadoRefeicao int auto_increment primary key,
    data_hora timestamp,
    acao varchar(255) -- qual a refeicao
);

-- acho que não precisa
create table cuidadoAtividadeFisica(
	idcuidadoAtividadeFisica int auto_increment primary key,
    data_hora timestamp,
    acao varchar(255) -- qual a atividade
);

-- acho que não precisa - poderia ser uma lista que o cuidador adiciona medicamentos
create table cuidadoMedicacao(
	idcuidadoMedicacao int auto_increment primary key,
    data_hora timestamp,
    medicamento varchar(255),
    realizou char(1) default 0,
    idcuidado int,
    foreign key (idcuidado) references cuidado(idcuidado)
);

-- acho que não precisa
create table cuidadoHigiene(
	idcuidadoHigiene int auto_increment primary key,
    data_hora timestamp,
    acao varchar(255) -- qual a higiene
);

-- acho que não precisa - poderia ser uma lista que o cuidador adiciona as feridas a serem tratadas
create table cuidadoFerida(
	idcuidadoFerida int auto_increment primary key,
    ferida varchar(255),
    realizou char(1) default 0,
    idcuidado int,
    foreign key (idcuidado) references cuidado(idcuidado)
);

-- acho que não precisa - poderia ser uma lista que o cuidador adiciona os equipamentos a serem trocados
create table cuidadoEquipamentoMedico(
	idcuidadoEquipamentoMedico int auto_increment primary key,
    equipamento varchar(255),
    realizouTroca char(1) default 0,
    idcuidado int,
    foreign key (idcuidado) references cuidado(idcuidado)
);

-- acho que não precisa 
create table cuidadoDecubito(
	idcuidadoDecubito int auto_increment primary key,
    data_hora timestamp,
    acao varchar(255) -- qual a posicao
);

*/







