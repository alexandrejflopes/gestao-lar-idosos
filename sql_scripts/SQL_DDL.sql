
create table ALOJAMENTO (
	id		INT,
	primary key(id));

create table CASA (
	id				INT references ALOJAMENTO(id),
	morada			VARCHAR(100) NOT NULL, 
	numero_telefone	CHAR(9), 
	primary key(id));


create table QUARTO (
	id				INT references ALOJAMENTO(id),
	numero			INT NOT NULL,
	detalhes		VARCHAR(100),
	primary key(id));

create table RESPONSAVEL (
	cartao_cidadao	CHAR(12) NOT NULL,
	nome			VARCHAR(50),
	morada			VARCHAR(100) NOT NULL,
	tipo			VARCHAR(50),
	numero_telefone	CHAR(9) NOT NULL,
	primary key(cartao_cidadao));

create table UTENTE (
	no_utente		INT, -- 
	cc_responsavel	CHAR(12) references RESPONSAVEL(cartao_cidadao) on delete no action,
	id_alojamento	INT references ALOJAMENTO(id) on delete no action NOT NULL,
	nome			VARCHAR(50)	NOT NULL, --
	fotografia		CHARACTER, -- 
	alcunha			VARCHAR(50), --
	data_nasc		DATE, -- 
	sexo			CHAR, --
	estado_civil	VARCHAR(20), -- 
	NIF				CHAR(9) UNIQUE NOT NULL, --
	morada_anterior	VARCHAR(100), --
	data_entrada	DATE NOT NULL, 
	sns				char(9), --
	niss			CHAR(11), --
	subsistema_saude VARCHAR(15), --
	grau_dependencia VARCHAR(50), --
	num_telemovel	CHAR(9) --
	primary key(no_utente));

create table CUIDADO (
	tipo	VARCHAR(50), 
	primary key(tipo));

create table NECESSITA (
	no_utente	INT references UTENTE(no_utente) on delete cascade,
	tipo		VARCHAR(50) references CUIDADO(tipo) on delete cascade,
	primary key (no_utente, tipo));

create table VISITANTE (
	cartao_cidadao	CHAR(12),
	nome			VARCHAR(50) NOT NULL,
	primary key(cartao_cidadao));

create table VISITA ( 
	no_utente		INT references UTENTE(no_utente) on delete cascade,
	cc_visitante	CHAR(12) references VISITANTE(cartao_cidadao),
	data			DATE ,
	hora_entrada	TIME(0) default '14:00', -- hora de inicio das visitas
	hora_saida	TIME(0) default '19:30', -- hora de fim das visitas
	primary key(no_utente,cc_visitante, data));


create table APOLICE_SEGURO ( 
	num				INT,
	nome_seguradora	VARCHAR(50),
	nome_plano		VARCHAR(50),
	num_utente		INT references UTENTE(no_utente) on delete cascade,
	preco			DECIMAL(7,2), 
	tipo			VARCHAR(15),
	data_inicio		DATE,
	data_expiracao	DATE,
	modalidade_pagamento	VARCHAR(15),
	primary key (num));

create table DANO (
	descricao		VARCHAR(100),
	primary key(descricao));

create table COBRE (
	num_apolice		INT references APOLICE_SEGURO(num) on delete cascade,
	descricao		VARCHAR(100) references DANO(descricao) on delete cascade,
	primary key (num_apolice, descricao));

create table EMPREGADO(
	num_id			INT,
	fotografia		CHARACTER,
	nome			VARCHAR(50) NOT NULL,
	nif				CHAR(9) UNIQUE NOT NULL,
	data_nasc		DATE,
	sexo			CHAR,
	num_telefone	CHAR(9),
	primary key(num_id));

create table FUNCIONARIO (
	num_id			INT references EMPREGADO(num_id) on delete cascade,
	primary key(num_id));

create table ENFERMEIRO (
	num_id			INT references EMPREGADO(num_id) on delete cascade,
	num_ordem_enfermeiros	INT UNIQUE NOT NULL,
	primary key(num_id));

create table PRESTA (
	num_emp			INT references EMPREGADO(num_id) on delete cascade,
	tipo_cuidado	VARCHAR(50) references CUIDADO(tipo) on delete cascade, 
	primary key(num_emp, tipo_cuidado));

create table MEDICO (
	num_id			INT,
	nome			VARCHAR(50),
	primary key(num_id));

create table CONSULTA (
	num_consulta	INT,
	ano				INT,
	no_utente		INT references UTENTE(no_utente) on delete cascade NOT NULL,
	data			DATE,
	num_id_medico	INT references MEDICO(num_id),
	primary key(num_consulta, ano));

create table PRESCRICAO (
	num_prescricao		INT,
	data				DATE,
	num_consulta		INT,
	ano					INT,
	primary key(num_prescricao),
	foreign key(num_consulta, ano) references CONSULTA(num_consulta, ano) on delete cascade);

create table FARMACO (
	nome			VARCHAR(50),
	farmaceutica	VARCHAR(50),
	formula			VARCHAR(30) NOT NULL,
	primary key(nome, farmaceutica));

create table REFERE (
	nome_farmaco		VARCHAR(50),
	farmaceutica		VARCHAR(50),
	num_prescricao		INT references PRESCRICAO(num_prescricao) on delete cascade,
	data_fim_tratamento DATE,
	freq				VARCHAR(20),
	primary key(nome_farmaco, farmaceutica, num_prescricao),
	constraint fk_farmaco_farmaceutica
		foreign key(nome_farmaco, farmaceutica)
		references FARMACO(nome, farmaceutica)
		on delete cascade);

