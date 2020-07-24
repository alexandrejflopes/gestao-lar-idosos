-- Devolve num de quarto do utente se tiver quarto ou 0 se não tiver

go
create function CheckQuarto(@utente_no INT) returns INT
	as
	begin

	declare @aloj_id INT;
	select @aloj_id = id_alojamento from UTENTE where no_utente = @utente_no;
	declare @quarto_id INT;
	declare @count INT;
	select @count = COUNT(*) from QUARTO where id = @aloj_id;
	if(@count = 0)
		begin
		set @quarto_id = 0;
	end
	else
		begin
		select @quarto_id = numero from QUARTO where id = @aloj_id;
	end
	return @quarto_id;
end
go


-- Obter Lista de Utentes

go
create function GetUtentes() returns table
	as
	return (SELECT * from UTENTE)
go



-- Obter tuplo de um utente específico

go
create function GetUtente(@num INT) returns table
	as
	return (SELECT * from UTENTE where no_utente=@num);
go 

-- Obter todos os responsáveis

go
create function GetResponsaveis() returns table
	as
	return (SELECT * from RESPONSAVEL);
go 



-- Obter o responsavel de um dadto utente
go
create function GetUtenteResponsavel(@no_utente int) returns table
	as
	return (select cartao_cidadao, R.nome as Rnome, morada, tipo, numero_telefone from utente as U join responsavel as R on cc_responsavel = cartao_cidadao where no_utente=@no_utente);
go 




-- Obter lista de visitantes

go
create function GetVisitantes() returns table
	as
	return (SELECT * from VISITANTE);
go


-- Obter lista de visitas com nomes de utente e visitante

go
create function GetVisitas() returns table
	as
	return (SELECT temp.no_utente, UTENTE.nome as nome_utente, temp.cc_visitante, temp.nome as nome_visitante, data, hora_entrada, hora_saida from UTENTE join 
								(select * from VISITANTE join VISITA on cartao_cidadao=cc_visitante)
								as temp on  UTENTE.no_utente = temp.no_utente );
go


-- Obter todos os cuidados

go
create function getCuidados() returns table
	as
	return (SELECT * from CUIDADO);
go



-- Obter Cuidados de um utente 

go
create function getCuidadosUtente(@no_utente INT) returns table
	as
	return (SELECT tipo from NECESSITA where no_utente=@no_utente);
go

-- Obter Lista de Quartos (Por numero de quarto, não de alojamento)

go
create function getQuartos() returns table
	as
	return (SELECT numero from QUARTO);
go

-- Obter tuplo completo de todos os Quartos (Por numero de quarto, não de alojamento)

go
create function getAllQuartos() returns table
	as
	return (SELECT * from QUARTO);
go


-- Obter o tuplo do quarto de um utente
go
create function getUtenteQuarto(@no_utente int) returns table
	as
	return (select id, numero, detalhes from utente join quarto on id_alojamento = id where no_utente=@no_utente);
go


-- obter o tuplo da casa de um utente
go
create function getUtenteCasa(@no_utente int) returns table
	as
	return (select id, morada, numero_telefone from utente join casa on id_alojamento = id where no_utente=@no_utente);
go




-- Obter Apolice de um utente

go
create function getApolice(@no_utente INT) returns table
	as
	return (SELECT * from APOLICE_SEGURO where num_utente=@no_utente);
go

-- Verificar se utente tem seguro criado (retorna 0 se não, 1 se sim)

go
create function hasApolice(@no_utente INT) returns INT
	as
	begin
	declare @count int;
	select @count = COUNT(*) from APOLICE_SEGURO where num_utente=@no_utente;
	if(@count=0)
		begin
		return @count;
	end
	return 1;
end
go

-- Obter danos cobertos por uma apólice

go
create function GetDanosByApolice(@apolice_num INT) returns table
	as
	return (SELECT descricao from COBRE where num_apolice=@apolice_num );
go

-- Obter todos os danos disponíveis (para seleção)

go
create function GetDanos() returns table
	as
	return (SELECT * from DANO);
go

-- Obter Lista de Enfermeiros

go
create function GetEnfermeiros() returns table
	as
	return (SELECT ENFERMEIRO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone, num_ordem_enfermeiros from ENFERMEIRO join EMPREGADO on ENFERMEIRO.num_id = EMPREGADO.num_id);
go

--Obter Lista de Funcionarios

go
create function GetFuncionarios() returns table
	as
	return (SELECT FUNCIONARIO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone from FUNCIONARIO join EMPREGADO on FUNCIONARIO.num_id = EMPREGADO.num_id);
go

--Obter Informações de enfermeiro

go
create function GetEnfermeiroInfo(@num_id INT) returns table
	as
	return (SELECT ENFERMEIRO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone, num_ordem_enfermeiros from ENFERMEIRO join EMPREGADO on ENFERMEIRO.num_id = EMPREGADO.num_id where ENFERMEIRO.num_id=@num_id);
go

-- Obter informações de funcionario

go
create function GetFuncionariosInfo(@num_id INT) returns table
	as
	return (SELECT FUNCIONARIO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone from FUNCIONARIO join EMPREGADO on FUNCIONARIO.num_id = EMPREGADO.num_id where FUNCIONARIO.num_id=@num_id);
go

-- Obter cuidados prestados por funcionário

go
create function GetCuidadosFuncionario(@num_id INT) returns table
	as
	return (SELECT Presta.tipo_cuidado from PRESTA where num_emp=@num_id);
go

-- Obter lista de consultas

go
create function GetConsultas() returns table
	as
	return (SELECT * from CONSULTA);
go

-- Obter Lista de cosnsultas de um utente

go
create function GetConsultasUtente(@no_utente INT) returns table
	as
	return (SELECT num_consulta, ano, data, num_id_medico, nome as nome_medico from CONSULTA join MEDICO on CONSULTA.num_id_medico=MEDICO.num_id where no_utente=@no_utente);
go

-- Obter Lista de medicos

go
create function GetMedicos() returns table
	as
	return (SELECT * from MEDICO);
go

-- Obter consulta dada por médico

go
create function GetConsultasMedico(@num_id INT) returns table
	as
	return (SELECT * from CONSULTA where num_id_medico=@num_id)
go


-- Verificar se Consulta tem alguma prescrição (return 1 se true 0 se false)

go
create function ConsultaHasPrescricao(@num_consulta INT, @ano INT) returns INT
	as
	begin
	declare @count int;
	SELECT @count = COUNT(*) from PRESCRICAO where num_consulta=@num_consulta and ano=@ano;
	return @count;
end
go



-- Obter todos os farmacos

go
create function GetFarmacos() returns table
	as
	return (SELECT * from FARMACO);
go

-- Obter todas prescrições

go
create function GetPrescricoes() returns table
	as
	return (SELECT * from PRESCRICAO);
go

-- Obter Numero de vezes que cada farmaco foi receitado

go
create function GetNumPrescricaoPorFarmaco() returns table
	as
	return (SELECT nome, FARMACO.farmaceutica, formula, numeroVezes from FARMACO join 
											(SELECT nome_farmaco, farmaceutica, COUNT(*) as numeroVezes 
											from REFERE 
											group by nome_farmaco, farmaceutica) as temp
											on FARMACO.nome=temp.nome_farmaco and FARMACO.farmaceutica=temp.farmaceutica);
go

-- Obter farmacos referidos por uma prescrição

go
create function GetFarmacosPrescricao(@num_prescricao int) returns table
	as
	return (SELECT nome_farmaco, FARMACO.farmaceutica, formula from REFERE join FARMACO on REFERE.nome_farmaco=FARMACO.nome and REFERE.farmaceutica=FARMACO.farmaceutica
																where REFERE.num_prescricao=@num_prescricao);
go


-- Obter farmacos utilizados por um paciente

go
create function GetFarmacosPaciente(@no_utente int) returns table
	as
	return (SELECT nome,  FARMACO.farmaceutica, formula from FARMACO join (
																		SELECT nome_farmaco, farmaceutica from REFERE join(
																						SELECT no_utente, num_prescricao from PRESCRICAO join CONSULTA on PRESCRICAO.num_consulta=CONSULTA.num_consulta and PRESCRICAO.ano=CONSULTA.ano where CONSULTA.no_utente=@no_utente)
																		as temp1 on REFERE.num_prescricao=temp1.num_prescricao)
																as temp2 on temp2.farmaceutica=FARMACO.farmaceutica and temp2.nome_farmaco=FARMACO.nome)

go

-- Obter farmacos de uma consulta

go
create function GetFarmacosConsulta(@ano int, @no_consulta int) returns table
	as
	return (SELECT nome,  FARMACO.farmaceutica, formula from FARMACO join (
												SELECT nome_farmaco, farmaceutica
												from PRESCRICAO join REFERE on PRESCRICAO.num_prescricao=REFERE.num_prescricao
												where PRESCRICAO.ano=@ano and PRESCRICAO.num_consulta=@no_consulta) as temp
										on FARMACO.nome=temp.nome_farmaco and FARMACO.farmaceutica=temp.farmaceutica);
go


-- Obter o numero de prescricao de uma consulta

go
create function getPrescricaoConsulta(@no_consulta int, @ano int) returns int
	as
	begin
	declare @presc int;
	SELECT @presc = num_prescricao from PRESCRICAO where num_consulta=@no_consulta and ano=@ano;
	return @presc;
	end
go