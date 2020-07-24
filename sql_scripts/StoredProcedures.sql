-- Adicionar Utente

go
create procedure AddUtente @cc_resp CHAR(12), @nome varchar(50), @alcunha varchar(50), @data_nasc DATE, @sexo CHAR,
	@estado_civil	VARCHAR(20),
	@NIF				CHAR(9),
	@data_entrada	DATE, 
	@sns				CHAR(9),
	@niss			CHAR(11),
	@subsistema_saude VARCHAR(15),
	@grau_dependencia VARCHAR(50),
	@morada_anterior	VARCHAR(100) = null, -- null se estiver numa casa propria
	@fotografia character = null,
	@num_telemovel	CHAR(9) = null, -- nem todos tem: apenas aos que tem vai ser passado o argumento
	@morada			varchar(100) = null,
	@num_tel		char(9) = null, -- telefone da casa
	@numero			INT = null -- numero do quarto
	as

	declare @no_utente INT;
	select @no_utente = Max(no_utente)+1 from UTENTE;

	if(@morada is null and @numero is not null)
	begin
		declare @q_id INT;
		select @q_id = id from QUARTO where numero=@numero
		insert into UTENTE values (@no_utente, @cc_resp,@q_id, @nome , @fotografia , @alcunha , @data_nasc , @sexo ,@estado_civil, @NIF,
	@morada_anterior, @data_entrada, @sns, @niss, @subsistema_saude, @grau_dependencia , @num_telemovel);	 
	end
	else if (@morada is not null and @num_tel is not null and @numero is null)
	begin
		declare @exist INT;
		select @exist = count(*) from CASA where morada=@morada;
		if(@exist = 0)
		begin
			declare @max_id int;
			select @max_id = Max(id)+1 from ALOJAMENTO;
			insert into ALOJAMENTO values (@max_id);
			insert into CASA values (@max_id, @morada, @num_tel);
			insert into UTENTE values (@no_utente, @cc_resp,@max_id, @nome , @fotografia , @alcunha , @data_nasc , @sexo ,@estado_civil, @NIF,
			@morada_anterior, @data_entrada, @sns, @niss, @subsistema_saude, @grau_dependencia , @num_telemovel);
		end
		else 
		begin
			declare @m_id int;
			select @m_id = id from CASA where morada = @morada;
			insert into UTENTE values (@no_utente, @cc_resp,@m_id, @nome , @fotografia , @alcunha , @data_nasc , @sexo ,@estado_civil, @NIF,
			@morada_anterior, @data_entrada, @sns, @niss, @subsistema_saude, @grau_dependencia , @num_telemovel);
		end
	end
go



-- Alterar Utente

go

create procedure AlterUtente @no_utente INT, @cc_resp CHAR(12), @nome varchar(50), @alcunha varchar(50), @data_nasc DATE, @sexo CHAR,
	@estado_civil		VARCHAR(20),
	@NIF				CHAR(9),
	@data_entrada		DATE, 
	@sns				CHAR(9),
	@niss				CHAR(11),
	@subsistema_saude	VARCHAR(15),
	@grau_dependencia	VARCHAR(50),
	@morada_anterior	VARCHAR(100) = null, -- null se estiver numa casa propria
	@num_telemovel		CHAR(9) = null, -- nem todos tem: apenas aos que tem vai ser passado o argumento
	@morada				varchar(100) =null,
	@num_tel			char(9) = null,
	@numero				INT = null,
	@fotografia character = null
	as

	UPDATE UTENTE SET cc_responsavel = @cc_resp WHERE no_utente=@no_utente;
	UPDATE UTENTE SET nome = @nome						   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET fotografia = @fotografia			   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET alcunha = @alcunha				   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET data_nasc = @data_nasc			   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET sexo = @sexo						   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET estado_civil = @estado_civil		   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET NIF = @NIF						   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET morada_anterior = @morada_anterior   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET data_entrada = @data_entrada		   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET sns = @sns						   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET niss = @niss						   WHERE no_utente=@no_utente;
	UPDATE UTENTE SET subsistema_saude = @subsistema_saude WHERE no_utente=@no_utente;
	UPDATE UTENTE SET grau_dependencia = @grau_dependencia WHERE no_utente=@no_utente;
	UPDATE UTENTE SET num_telemovel = @num_telemovel

	if(@morada is null and @numero is not null)
	begin
		declare @q_id INT;
		select @q_id = id from QUARTO where numero=@numero
		UPDATE UTENTE SET id_alojamento = @q_id WHERE no_utente=@no_utente; 
	end
	else if (@morada is not null and @num_tel is not null and @numero is null) -- garantir que os dados da casa têm valor
	begin
		declare @exist INT;
		select @exist = count(*) from CASA where morada=@morada;
		if(@exist = 0)
		begin
			declare @max_id int;
			select @max_id = Max(id)+1 from ALOJAMENTO;
			insert into ALOJAMENTO values (@max_id);
			insert into CASA values (@max_id, @morada, @num_tel);
			UPDATE UTENTE SET id_alojamento = @max_id WHERE no_utente=@no_utente;
		end
		else 
		begin
			declare @m_id int;
			select @m_id = id from CASA where morada = @morada;
			UPDATE UTENTE SET id_alojamento = @m_id WHERE no_utente=@no_utente; 
			end
	end
go



-- Remover Utente

go
create procedure RemoveUtente @no_utente INT
	as
	declare @aloj_id INT;
	select @aloj_id = id_alojamento from UTENTE where no_utente=@no_utente;
	declare @count int;
	select @count = COUNT(*) from CASA where CASA.id=@aloj_id;
	delete from UTENTE where no_utente=@no_utente;
	if(@count!=0)
	begin
		delete from CASA where id=@aloj_id;
		delete from ALOJAMENTO where id=@aloj_id;
	end
go



-- Adicionar Responsável

go
create procedure AddResponsavel @cartao_cidadao	CHAR(12),@nome VARCHAR(50),@morada VARCHAR(100),@tipo VARCHAR(50),@numero_telefone CHAR(9)
	as
	insert into RESPONSAVEL values (@cartao_cidadao, @nome, @morada, @tipo,@numero_telefone);
go



-- Alterar Responsável

go
create procedure AlterResponsavel @cartao_cidadao CHAR(12),@nome VARCHAR(50),@morada VARCHAR(100),@tipo VARCHAR(50),@numero_telefone CHAR(9)
	as

	UPDATE RESPONSAVEL SET nome = @nome WHERE @cartao_cidadao=@cartao_cidadao;
	UPDATE RESPONSAVEL SET morada = @morada WHERE @cartao_cidadao=@cartao_cidadao;
	UPDATE RESPONSAVEL SET tipo = @tipo WHERE @cartao_cidadao=@cartao_cidadao;
	UPDATE RESPONSAVEL SET numero_telefone= @numero_telefone WHERE @cartao_cidadao=@cartao_cidadao;
go


-- Adicionar Visitante

go
create procedure AddVisitante @cartao_cidadao CHAR(12),@nome VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from VISITANTE where cartao_cidadao=@cartao_cidadao;
	if(@count=0)
	begin
		insert into VISITANTE values (@cartao_cidadao, @nome);
	end
go

--Adicionar Visita

go
create procedure AddVisita @no_utente INT, @cc_visitante CHAR(12),@data DATE , @hora_entrada TIME(0) = '14:00',@hora_saida TIME(0) = '19:30'
	as
	insert into VISITA values (@no_utente, @cc_visitante, @data ,@hora_entrada, @hora_saida);
go



--Adicionar apolice

go
create procedure AddApolice @nome_seguradora VARCHAR(50), @nome_plano VARCHAR(50), @num_utente INT , @preco DECIMAL(7,2), @tipo VARCHAR(15), @data_inicio DATE, @data_expiracao	DATE, @modalidade_pagamento VARCHAR(15)
	as
	declare @num INT;
	select @num = Max(num)+1 from APOLICE_SEGURO;
	insert into APOLICE_SEGURO values (@num , @nome_seguradora , @nome_plano , @num_utente , @preco , @tipo , @data_inicio , @data_expiracao	, @modalidade_pagamento);
go

--Alterar apolice

go
create procedure AlterApolice  @num INT ,@nome_seguradora VARCHAR(50), @nome_plano VARCHAR(50), @num_utente INT , @preco DECIMAL(7,2), @tipo VARCHAR(15), @data_inicio DATE, @data_expiracao	DATE, @modalidade_pagamento VARCHAR(15)
	as
	insert into APOLICE_SEGURO values (@num , @nome_seguradora , @nome_plano , @num_utente , @preco , @tipo , @data_inicio , @data_expiracao	, @modalidade_pagamento);
	
	UPDATE APOLICE_SEGURO SET nome_seguradora = @nome_seguradora WHERE num=@num;
	UPDATE APOLICE_SEGURO SET nome_plano = @nome_plano WHERE num=@num;
	UPDATE APOLICE_SEGURO SET num_utente = @num_utente WHERE num=@num;
	UPDATE APOLICE_SEGURO SET preco= @preco WHERE num=@num;
	UPDATE APOLICE_SEGURO SET tipo= @tipo WHERE num=@num;
	UPDATE APOLICE_SEGURO SET data_inicio= @data_inicio WHERE num=@num;
	UPDATE APOLICE_SEGURO SET data_expiracao= @data_expiracao WHERE num=@num;
	UPDATE APOLICE_SEGURO SET modalidade_pagamento = @modalidade_pagamento WHERE num=@num;
go


-- Remove apolice

go
create procedure RemoveApolice @num int
	as
	delete from COBRE where COBRE.num_apolice=@num;
	delete from APOLICE_SEGURO where num=@num;
go


--Adicionar Danos que apolice cobre -- Selecionar danos

go
create procedure AddDanoToApolice @num_apolice INT, @descricao VARCHAR(100)
	as
	declare @count int;
	select @count = count(*) from COBRE where num_apolice=@num_apolice and descricao=@descricao;
	if(@count=0)
	begin
		insert into COBRE values (@num_apolice, @descricao);
	end
go

--Remover Danos que apolice cobre -- Selecionar danos

go
create procedure RemoveDanoToApolice @num_apolice INT, @descricao VARCHAR(100)
	as
	declare @count int;
	select @count = count(*) from COBRE where num_apolice=@num_apolice and descricao=@descricao;
	if(@count=1)
	begin
		delete from COBRE where num_apolice=@num_apolice and descricao=@descricao;
	end
go

--Adicionar Enfermeiro

go
create procedure AddEnfermeiro @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9),@num_ordem_enfermeiros INT, @fotografia CHARACTER = null
	as
	declare @num_id INT;
	select @num_id= Max(num_id)+1 from EMPREGADO;
	if(@fotografia is not null)
	begin
		insert into EMPREGADO values (@num_id , @fotografia ,@nome ,@nif ,@data_nasc ,@sexo, @num_telefone);
		insert into ENFERMEIRO values (@num_id, @num_ordem_enfermeiros);
	end
	else
	begin
		insert into EMPREGADO values (@num_id , @fotografia ,@nome ,@nif ,@data_nasc ,@sexo, @num_telefone);
		insert into ENFERMEIRO values (@num_id, @num_ordem_enfermeiros);
	end
go



--Alterar Enfermeiro

go
create procedure AlterEnfermeiro @num_id INT, @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9),@num_ordem_enfermeiros INT, @fotografia CHARACTER = null
	as
	if(@fotografia is not null)
	begin
		UPDATE EMPREGADO SET fotografia= @fotografia WHERE num_id=@num_id;
	end
	UPDATE EMPREGADO SET nome= @nome WHERE num_id=@num_id;
	UPDATE EMPREGADO SET nif= @nif WHERE num_id=@num_id;
	UPDATE EMPREGADO SET data_nasc= @data_nasc WHERE num_id=@num_id;
	UPDATE EMPREGADO SET sexo= @sexo WHERE num_id=@num_id;
	UPDATE EMPREGADO SET num_telefone= @num_telefone WHERE num_id=@num_id;
	UPDATE ENFERMEIRO SET num_ordem_enfermeiros = @num_ordem_enfermeiros WHERE num_id=@num_id;
go


--Adicionar Funcionário

go
create procedure AddFuncionario @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9), @fotografia CHARACTER = null
	as
	declare @num_id INT;
	select @num_id= Max(num_id)+1 from EMPREGADO;
	if(@fotografia is not null)
	begin
		insert into EMPREGADO values (@num_id , @fotografia ,@nome ,@nif ,@data_nasc ,@sexo, @num_telefone);
		insert into FUNCIONARIO values (@num_id);
	end
	else
	begin
		insert into EMPREGADO values (@num_id , @fotografia ,@nome ,@nif ,@data_nasc ,@sexo, @num_telefone);
		insert into FUNCIONARIO values (@num_id);
	end
go



--Alterar Funcionário

go
create procedure AlterFuncionario @num_id INT, @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9), @fotografia CHARACTER = null
	as
	if(@fotografia is not null)
	begin
		UPDATE EMPREGADO SET fotografia= @fotografia WHERE num_id=@num_id;
	end
	UPDATE EMPREGADO SET nome= @nome WHERE num_id=@num_id;
	UPDATE EMPREGADO SET nif= @nif WHERE num_id=@num_id;
	UPDATE EMPREGADO SET data_nasc= @data_nasc WHERE num_id=@num_id;
	UPDATE EMPREGADO SET sexo= @sexo WHERE num_id=@num_id;
	UPDATE EMPREGADO SET num_telefone= @num_telefone WHERE num_id=@num_id;
go



-- Remover Empregado

go
create procedure RemoveEmpregado @num_id int
	as
	delete from EMPREGADO where num_id=@num_id;
go

--Adicionar cuidado a ter a um paciente

go
create procedure AddUtenteCuidado @no_utente INT , @tipo VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from NECESSITA where no_utente=@no_utente and tipo=@tipo;
	if(@count=0)
	begin
		insert into NECESSITA values (@no_utente, @tipo);
	end
go

--Remover cuidado a um paciente

go
create procedure RemoveUtenteCuidado @no_utente INT , @tipo VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from NECESSITA where no_utente=@no_utente and tipo=@tipo;
	if(@count=1)
	begin
		delete from NECESSITA where no_utente=@no_utente and tipo=@tipo;
	end
go


--Adicionar Cuidado prestado por um funcionário

go
create procedure AddCuidadoPrestado @num_emp INT , @tipo_cuidado VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from PRESTA where num_emp=@num_emp and tipo_cuidado=@tipo_cuidado;
	if(@count=0)
	begin
		insert into PRESTA values (@num_emp, @tipo_cuidado);
	end
go

--Remover cuidado prestado por um funcionário



go
create procedure RemoveCuidadoPrestado @num_emp INT , @tipo_cuidado VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from PRESTA where num_emp=@num_emp and tipo_cuidado=@tipo_cuidado;
	if(@count=1)
	begin
		delete from PRESTA where num_emp=@num_emp and tipo_cuidado=@tipo_cuidado;
	end
go


-- Adicionar medico

go
create procedure AddMedico @num_id INT, @nome VARCHAR(50)
	as
	insert into MEDICO values(@num_id, @nome);
go

-- Alterar medico

go
create procedure AlterMedico @num_id INT, @nome VARCHAR(50)
	as
	UPDATE MEDICO SET nome= @nome WHERE num_id=@num_id;
go

-- Adicionar consulta

go
create procedure AddConsulta @no_utente INT, @data DATE, @num_id_medico INT
	as
	declare @ano_max int;
	select @ano_max = MAX(ano) from CONSULTA;
	declare @numero_consulta INT;
	select @numero_consulta = MAX(num_consulta)+1 from CONSULTA where ano=@ano_max;
	insert into CONSULTA values (@numero_consulta, @ano_max, @no_utente, @data, @num_id_medico);
go

-- Adicionar Prescrição

go
create procedure AddPrescricao @num_prescricao INT, @data DATE, @num_consulta INT, @ano INT
	as
	insert into PRESCRICAO values (@num_prescricao, @data, @num_consulta, @ano);
go

--Adicionar Farmaco

go
create procedure AddFarmaco @nome VARCHAR(50), @farmaceutica VARCHAR(50), @formula VARCHAR(30)
	as
	insert into FARMACO values (@nome, @farmaceutica, @formula);
go

-- Adicionar referencia entre prescrição e farmaco

go
create procedure AddReferencia @nome_farmaco VARCHAR(50), @farmaceutica VARCHAR(50), @num_prescricao INT, @data_fim_tratamento DATE, @freq VARCHAR(20)
	as
	insert into REFERE values (@nome_farmaco, @farmaceutica, @num_prescricao, @data_fim_tratamento, @freq);
go