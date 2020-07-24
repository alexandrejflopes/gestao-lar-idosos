use testesProjeto;

go
create trigger check_responsavel on utente
after delete
as
	declare @cc_responsavel CHAR(12);
	declare @times INT;

	declare c cursor fast_forward
	for select cc_responsavel from deleted;

	open c;

	fetch c into @cc_responsavel; -- var sobre a qual vamos iterar

	while @@fetch_status = 0
		begin
			if (@cc_responsavel = null) -- @cc_responsavel vai sendo igual ao cartao_cidadao do select
				begin
				fetch c into @cc_responsavel;
				continue;
				end

			select @times = COUNT(cc_responsavel) from UTENTE where cc_responsavel=@cc_responsavel
			
			if (@times>0) -- responsavel ainda tem mais utentes ao seu cargo, portanto, permanece no sistema
				begin
					continue;
				end
			
			else if (@times=0) -- nao e responsavel por mais ninguem, entao pode ser eliminado
				begin
					delete from RESPONSAVEL where cartao_cidadao=@cc_responsavel;
				end

			fetch c into @cc_responsavel;

		end
go

go
create trigger CheckAlojamento on UTENTE
after delete
	as

	declare @id_aloj INT;
	declare @times INT;

	declare c cursor fast_forward
	for select id_alojamento from deleted;

	open c;

	fetch c into @id_aloj; -- var sobre a qual vamos iterar

	while @@fetch_status = 0
		begin
		 declare @count INT;
		 select @count = COUNT(*) from CASA where CASA.id=@id_aloj;

		 if(@count!=0)
		 begin
			delete from CASA where id=@id_aloj;
			delete from ALOJAMENTO where id=@id_aloj;
		 end
		 fetch c into @id_aloj;
	end

go