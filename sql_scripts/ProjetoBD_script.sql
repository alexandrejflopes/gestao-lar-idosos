USE [master]
GO
/****** Object:  Database [p5g1]    Script Date: 06/06/2019 21:55:50 ******/
CREATE DATABASE [p5g1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'p5g1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\p5g1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'p5g1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\p5g1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [p5g1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [p5g1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [p5g1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [p5g1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [p5g1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [p5g1] SET ARITHABORT OFF 
GO
ALTER DATABASE [p5g1] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [p5g1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [p5g1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [p5g1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [p5g1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [p5g1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [p5g1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [p5g1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [p5g1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [p5g1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [p5g1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [p5g1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [p5g1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [p5g1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [p5g1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [p5g1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [p5g1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [p5g1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [p5g1] SET  MULTI_USER 
GO
ALTER DATABASE [p5g1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [p5g1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [p5g1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [p5g1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [p5g1] SET DELAYED_DURABILITY = DISABLED 
GO
USE [p5g1]
GO
/****** Object:  User [p5g1]    Script Date: 06/06/2019 21:55:50 ******/
CREATE USER [p5g1] FOR LOGIN [p5g1] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p5g1]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckQuarto]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CheckQuarto](@utente_no INT) returns INT
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

GO
/****** Object:  UserDefinedFunction [dbo].[ConsultaHasPrescricao]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ConsultaHasPrescricao](@num_consulta INT, @ano INT) returns INT
	as
	begin
	declare @count int;
	SELECT @count = COUNT(*) from PRESCRICAO where num_consulta=@num_consulta and ano=@ano;
	return @count;
end

GO
/****** Object:  UserDefinedFunction [dbo].[getPrescricaoConsulta]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getPrescricaoConsulta](@no_consulta int, @ano int) returns int
	as
	begin
	declare @presc int;
	SELECT @presc = num_prescricao from PRESCRICAO where num_consulta=@no_consulta and ano=@ano;
	return @presc;
	end

GO
/****** Object:  UserDefinedFunction [dbo].[hasApolice]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[hasApolice](@no_utente INT) returns INT
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

GO
/****** Object:  Table [dbo].[ALOJAMENTO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALOJAMENTO](
	[id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[APOLICE_SEGURO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[APOLICE_SEGURO](
	[num] [int] NOT NULL,
	[nome_seguradora] [varchar](50) NULL,
	[nome_plano] [varchar](50) NULL,
	[num_utente] [int] NULL,
	[preco] [decimal](7, 2) NULL,
	[tipo] [varchar](15) NULL,
	[data_inicio] [date] NULL,
	[data_expiracao] [date] NULL,
	[modalidade_pagamento] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CASA]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CASA](
	[id] [int] NOT NULL,
	[morada] [varchar](100) NOT NULL,
	[numero_telefone] [char](9) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[COBRE]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COBRE](
	[num_apolice] [int] NOT NULL,
	[descricao] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_apolice] ASC,
	[descricao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONSULTA]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONSULTA](
	[num_consulta] [int] NOT NULL,
	[ano] [int] NOT NULL,
	[no_utente] [int] NOT NULL,
	[data] [date] NULL,
	[num_id_medico] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[num_consulta] ASC,
	[ano] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CUIDADO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CUIDADO](
	[tipo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DANO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DANO](
	[descricao] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[descricao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EMPREGADO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EMPREGADO](
	[num_id] [int] NOT NULL,
	[fotografia] [char](1) NULL,
	[nome] [varchar](50) NOT NULL,
	[nif] [char](9) NOT NULL,
	[data_nasc] [date] NULL,
	[sexo] [char](1) NULL,
	[num_telefone] [char](9) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ENFERMEIRO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ENFERMEIRO](
	[num_id] [int] NOT NULL,
	[num_ordem_enfermeiros] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FARMACO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FARMACO](
	[nome] [varchar](50) NOT NULL,
	[farmaceutica] [varchar](50) NOT NULL,
	[formula] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nome] ASC,
	[farmaceutica] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FUNCIONARIO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUNCIONARIO](
	[num_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MEDICO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MEDICO](
	[num_id] [int] NOT NULL,
	[nome] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[num_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NECESSITA]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NECESSITA](
	[no_utente] [int] NOT NULL,
	[tipo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[no_utente] ASC,
	[tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PRESCRICAO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRESCRICAO](
	[num_prescricao] [int] NOT NULL,
	[data] [date] NULL,
	[num_consulta] [int] NULL,
	[ano] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[num_prescricao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PRESTA]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PRESTA](
	[num_emp] [int] NOT NULL,
	[tipo_cuidado] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[num_emp] ASC,
	[tipo_cuidado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QUARTO]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QUARTO](
	[id] [int] NOT NULL,
	[numero] [int] NOT NULL,
	[detalhes] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REFERE]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REFERE](
	[nome_farmaco] [varchar](50) NOT NULL,
	[farmaceutica] [varchar](50) NOT NULL,
	[num_prescricao] [int] NOT NULL,
	[data_fim_tratamento] [date] NULL,
	[freq] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[nome_farmaco] ASC,
	[farmaceutica] ASC,
	[num_prescricao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RESPONSAVEL]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RESPONSAVEL](
	[cartao_cidadao] [char](12) NOT NULL,
	[nome] [varchar](50) NULL,
	[morada] [varchar](100) NOT NULL,
	[tipo] [varchar](50) NULL,
	[numero_telefone] [char](9) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cartao_cidadao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UTENTE]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UTENTE](
	[no_utente] [int] NOT NULL,
	[cc_responsavel] [char](12) NULL,
	[id_alojamento] [int] NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[fotografia] [char](1) NULL,
	[alcunha] [varchar](50) NULL,
	[data_nasc] [date] NULL,
	[sexo] [char](1) NULL,
	[estado_civil] [varchar](20) NULL,
	[NIF] [char](9) NOT NULL,
	[morada_anterior] [varchar](100) NULL,
	[data_entrada] [date] NOT NULL,
	[sns] [char](9) NULL,
	[niss] [char](11) NULL,
	[subsistema_saude] [varchar](15) NULL,
	[grau_dependencia] [varchar](50) NULL,
	[num_telemovel] [char](9) NULL,
PRIMARY KEY CLUSTERED 
(
	[no_utente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VISITA]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VISITA](
	[no_utente] [int] NOT NULL,
	[cc_visitante] [char](12) NOT NULL,
	[data] [date] NOT NULL,
	[hora_entrada] [time](0) NULL DEFAULT ('14:00'),
	[hora_saida] [time](0) NULL DEFAULT ('19:30'),
PRIMARY KEY CLUSTERED 
(
	[no_utente] ASC,
	[cc_visitante] ASC,
	[data] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VISITANTE]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VISITANTE](
	[cartao_cidadao] [char](12) NOT NULL,
	[nome] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cartao_cidadao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[getAllQuartos]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getAllQuartos]() returns table
	as
	return (SELECT * from QUARTO);

GO
/****** Object:  UserDefinedFunction [dbo].[getApolice]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getApolice](@no_utente INT) returns table
	as
	return (SELECT * from APOLICE_SEGURO where num_utente=@no_utente);

GO
/****** Object:  UserDefinedFunction [dbo].[GetConsultas]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetConsultas]() returns table
	as
	return (SELECT * from CONSULTA);

GO
/****** Object:  UserDefinedFunction [dbo].[GetConsultasMedico]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetConsultasMedico](@num_id INT) returns table
	as
	return (SELECT * from CONSULTA where num_id_medico=@num_id)

GO
/****** Object:  UserDefinedFunction [dbo].[GetConsultasUtente]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetConsultasUtente](@no_utente INT) returns table
	as
	return (SELECT num_consulta, ano, data, num_id_medico, nome as nome_medico from CONSULTA join MEDICO on CONSULTA.num_id_medico=MEDICO.num_id where no_utente=@no_utente);

GO
/****** Object:  UserDefinedFunction [dbo].[getCuidados]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getCuidados]() returns table
	as
	return (SELECT * from CUIDADO);

GO
/****** Object:  UserDefinedFunction [dbo].[GetCuidadosFuncionario]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetCuidadosFuncionario](@num_id INT) returns table
	as
	return (SELECT Presta.tipo_cuidado from PRESTA where num_emp=@num_id);

GO
/****** Object:  UserDefinedFunction [dbo].[getCuidadosUtente]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getCuidadosUtente](@no_utente INT) returns table
	as
	return (SELECT tipo from NECESSITA where no_utente=@no_utente);

GO
/****** Object:  UserDefinedFunction [dbo].[GetDanos]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetDanos]() returns table
	as
	return (SELECT * from DANO);

GO
/****** Object:  UserDefinedFunction [dbo].[GetDanosByApolice]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetDanosByApolice](@apolice_num INT) returns table
	as
	return (SELECT descricao from COBRE where num_apolice=@apolice_num );

GO
/****** Object:  UserDefinedFunction [dbo].[GetEnfermeiroInfo]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetEnfermeiroInfo](@num_id INT) returns table
	as
	return (SELECT ENFERMEIRO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone, num_ordem_enfermeiros from ENFERMEIRO join EMPREGADO on ENFERMEIRO.num_id = EMPREGADO.num_id where ENFERMEIRO.num_id=@num_id);

GO
/****** Object:  UserDefinedFunction [dbo].[GetEnfermeiros]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetEnfermeiros]() returns table
	as
	return (SELECT ENFERMEIRO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone, num_ordem_enfermeiros from ENFERMEIRO join EMPREGADO on ENFERMEIRO.num_id = EMPREGADO.num_id);

GO
/****** Object:  UserDefinedFunction [dbo].[GetFarmacos]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetFarmacos]() returns table
	as
	return (SELECT * from FARMACO);

GO
/****** Object:  UserDefinedFunction [dbo].[GetFarmacosConsulta]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetFarmacosConsulta](@ano int, @no_consulta int) returns table
	as
	return (SELECT nome,  FARMACO.farmaceutica, formula from FARMACO join (
												SELECT nome_farmaco, farmaceutica
												from PRESCRICAO join REFERE on PRESCRICAO.num_prescricao=REFERE.num_prescricao
												where PRESCRICAO.ano=@ano and PRESCRICAO.num_consulta=@no_consulta) as temp
										on FARMACO.nome=temp.nome_farmaco and FARMACO.farmaceutica=temp.farmaceutica);

GO
/****** Object:  UserDefinedFunction [dbo].[GetFarmacosPaciente]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetFarmacosPaciente](@no_utente int) returns table
	as
	return (SELECT nome,  FARMACO.farmaceutica, formula from FARMACO join (
																		SELECT nome_farmaco, farmaceutica from REFERE join(
																						SELECT no_utente, num_prescricao from PRESCRICAO join CONSULTA on PRESCRICAO.num_consulta=CONSULTA.num_consulta and PRESCRICAO.ano=CONSULTA.ano where CONSULTA.no_utente=@no_utente)
																		as temp1 on REFERE.num_prescricao=temp1.num_prescricao)
																as temp2 on temp2.farmaceutica=FARMACO.farmaceutica and temp2.nome_farmaco=FARMACO.nome)


GO
/****** Object:  UserDefinedFunction [dbo].[GetFarmacosPrescricao]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetFarmacosPrescricao](@num_prescricao int) returns table
	as
	return (SELECT nome_farmaco, FARMACO.farmaceutica, formula from REFERE join FARMACO on REFERE.nome_farmaco=FARMACO.nome and REFERE.farmaceutica=FARMACO.farmaceutica
																where REFERE.num_prescricao=@num_prescricao);

GO
/****** Object:  UserDefinedFunction [dbo].[GetFuncionarios]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetFuncionarios]() returns table
	as
	return (SELECT FUNCIONARIO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone from FUNCIONARIO join EMPREGADO on FUNCIONARIO.num_id = EMPREGADO.num_id);

GO
/****** Object:  UserDefinedFunction [dbo].[GetFuncionariosInfo]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetFuncionariosInfo](@num_id INT) returns table
	as
	return (SELECT FUNCIONARIO.num_id, fotografia, nome, nif, data_nasc, sexo, num_telefone from FUNCIONARIO join EMPREGADO on FUNCIONARIO.num_id = EMPREGADO.num_id where FUNCIONARIO.num_id=@num_id);

GO
/****** Object:  UserDefinedFunction [dbo].[GetMedicos]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetMedicos]() returns table
	as
	return (SELECT * from MEDICO);

GO
/****** Object:  UserDefinedFunction [dbo].[GetNumPrescricaoPorFarmaco]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetNumPrescricaoPorFarmaco]() returns table
	as
	return (SELECT nome, FARMACO.farmaceutica, formula, numeroVezes from FARMACO join 
											(SELECT nome_farmaco, farmaceutica, COUNT(*) as numeroVezes 
											from REFERE 
											group by nome_farmaco, farmaceutica) as temp
											on FARMACO.nome=temp.nome_farmaco and FARMACO.farmaceutica=temp.farmaceutica);

GO
/****** Object:  UserDefinedFunction [dbo].[GetPrescricoes]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetPrescricoes]() returns table
	as
	return (SELECT * from PRESCRICAO);

GO
/****** Object:  UserDefinedFunction [dbo].[getQuartos]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getQuartos]() returns table
	as
	return (SELECT numero from QUARTO);

GO
/****** Object:  UserDefinedFunction [dbo].[GetResponsaveis]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetResponsaveis]() returns table
	as
	return (SELECT * from RESPONSAVEL);

GO
/****** Object:  UserDefinedFunction [dbo].[GetUtente]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetUtente](@num INT) returns table
	as
	return (SELECT * from UTENTE where no_utente=@num);

GO
/****** Object:  UserDefinedFunction [dbo].[getUtenteCasa]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getUtenteCasa](@no_utente int) returns table
	as
	return (select id, morada, numero_telefone from utente join casa on id_alojamento = id where no_utente=@no_utente);

GO
/****** Object:  UserDefinedFunction [dbo].[getUtenteQuarto]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[getUtenteQuarto](@no_utente int) returns table
	as
	return (select id, numero, detalhes from utente join quarto on id_alojamento = id where no_utente=@no_utente);

GO
/****** Object:  UserDefinedFunction [dbo].[GetUtenteResponsavel]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetUtenteResponsavel](@no_utente int) returns table
	as
	return (select cartao_cidadao, R.nome as Rnome, morada, tipo, numero_telefone from utente as U join responsavel as R on cc_responsavel = cartao_cidadao where no_utente=@no_utente);

GO
/****** Object:  UserDefinedFunction [dbo].[GetUtentes]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetUtentes]() returns table
	as
	return (SELECT * from UTENTE)

GO
/****** Object:  UserDefinedFunction [dbo].[GetVisitantes]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetVisitantes]() returns table
	as
	return (SELECT * from VISITANTE);

GO
/****** Object:  UserDefinedFunction [dbo].[GetVisitas]    Script Date: 06/06/2019 21:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetVisitas]() returns table
	as
	return (SELECT temp.no_utente, UTENTE.nome as nome_utente, temp.cc_visitante, temp.nome as nome_visitante, data, hora_entrada, hora_saida from UTENTE join 
								(select * from VISITANTE join VISITA on cartao_cidadao=cc_visitante)
								as temp on  UTENTE.no_utente = temp.no_utente );

GO
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (148)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (150)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (172)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (211)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (224)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (300)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (307)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (318)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (347)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (366)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (376)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (397)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (436)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (441)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (449)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (461)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (481)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (525)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (548)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (555)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (628)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (686)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (725)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (772)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (779)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (827)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (875)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (876)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (879)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (942)
INSERT [dbo].[ALOJAMENTO] ([id]) VALUES (985)
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (1121, N'Confiança', N'Confiança Saúde', 6857, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2011-05-21' AS Date), CAST(N'2021-05-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (1560, N'Medi', N'Medi 60+', 9640, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2008-06-20' AS Date), CAST(N'2023-06-30' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (1916, N'Medi', N'Medi 60+', 3856, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2016-07-13' AS Date), CAST(N'2026-07-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (1952, N'Confiança', N'Confiança Saúde', 8836, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2011-10-11' AS Date), CAST(N'2021-10-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (2962, N'Medi', N'Medi 60+', 8052, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2008-12-16' AS Date), CAST(N'2023-12-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (4362, N'Confiança', N'Confiança Saúde', 6853, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2007-02-11' AS Date), CAST(N'2027-02-28' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (4495, N'Confiança', N'Confiança Saúde', 8116, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2015-09-10' AS Date), CAST(N'2025-09-30' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (4507, N'Vida Segura', N'Segura+', 3919, CAST(48500.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2013-11-19' AS Date), CAST(N'2023-11-30' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (4665, N'Confiança', N'Confiança Saúde', 5368, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2018-12-23' AS Date), CAST(N'2028-12-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (4985, N'Confiança', N'Confiança Saúde', 9053, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2010-01-26' AS Date), CAST(N'2020-01-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (5642, N'Confiança', N'Confiança Saúde', 2658, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-02-27' AS Date), CAST(N'2022-02-28' AS Date), N'Trimestral')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (5659, N'Medi', N'Medi 60+', 2903, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-01-16' AS Date), CAST(N'2022-01-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (5860, N'Medi', N'Medi 60+', 6598, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2017-01-03' AS Date), CAST(N'2027-01-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (6193, N'Vida Segura', N'Segura+', 2202, CAST(48500.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-11-29' AS Date), CAST(N'2022-11-30' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (6205, N'Confiança', N'Confiança Saúde', 7504, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-01-08' AS Date), CAST(N'2022-01-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (6440, N'Confiança', N'Confiança Saúde', 4327, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-03-13' AS Date), CAST(N'2022-03-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7224, N'Confiança', N'Confiança Saúde', 2067, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-01-26' AS Date), CAST(N'2022-01-31' AS Date), N'Trimestral')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7307, N'Confiança', N'Confiança Saúde', 2923, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2008-10-20' AS Date), CAST(N'2023-10-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7464, N'Medi', N'Medi 60+', 7057, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2016-05-25' AS Date), CAST(N'2026-05-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7480, N'Vida Segura', N'Segura+', 6442, CAST(48500.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2007-09-04' AS Date), CAST(N'2021-09-30' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7559, N'Vida Segura', N'Segura+', 1111, CAST(48500.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2008-09-03' AS Date), CAST(N'2023-09-30' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7773, N'Confiança', N'Confiança Saúde', 6549, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-12-21' AS Date), CAST(N'2022-12-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (7808, N'Medi', N'Medi 60+', 8629, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2011-08-07' AS Date), CAST(N'2021-08-31' AS Date), N'Trimestral')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (8067, N'Confiança', N'Confiança Saúde', 7322, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-05-30' AS Date), CAST(N'2022-05-31' AS Date), N'Mensal')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (8340, N'Confiança', N'Confiança Saúde', 5517, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2016-04-26' AS Date), CAST(N'2026-04-30' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (9090, N'Confiança', N'Confiança Saúde', 4283, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2008-08-13' AS Date), CAST(N'2023-08-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (9388, N'Medi', N'Medi 60+', 9529, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2014-09-10' AS Date), CAST(N'2024-09-30' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (9523, N'Confiança', N'Confiança Saúde', 9491, CAST(50000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2017-12-27' AS Date), CAST(N'2027-12-31' AS Date), N'Trimestral')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (9633, N'Medi', N'Medi 60+', 6652, CAST(45000.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2011-03-27' AS Date), CAST(N'2021-03-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (9746, N'Vida Segura', N'Segura+', 8224, CAST(48500.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2012-10-09' AS Date), CAST(N'2022-10-31' AS Date), N'Anual')
INSERT [dbo].[APOLICE_SEGURO] ([num], [nome_seguradora], [nome_plano], [num_utente], [preco], [tipo], [data_inicio], [data_expiracao], [modalidade_pagamento]) VALUES (9869, N'Vida Segura', N'Segura+', 7816, CAST(48500.00 AS Decimal(7, 2)), N'Fechada', CAST(N'2015-05-05' AS Date), CAST(N'2020-05-31' AS Date), N'Mensal')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (148, N'Travessa da Fonte dos Amores 3810-115 Aveiro', N'234992884')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (150, N'Travessa da Fonte dos Amores 3810-115 Aveiro', N'234823987')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (172, N'Travessa das Barcas 3810-006 Aveiro', N'234468943')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (224, N'Rua Bombeiros Velhos 3810-006 Aveiro', N'234879057')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (779, N'Travessa da Rua Direita 3810-009 Aveiro', N'234634438')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (876, N'Rua do Carmo 3804-503 Aveiro', N'234253269')
INSERT [dbo].[CASA] ([id], [morada], [numero_telefone]) VALUES (985, N'Avenida do Doutor Lourenço Peixinho 164C 3804-501 Aveiro', N'234834122')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1121, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1560, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1560, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1560, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1560, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1560, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1916, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1916, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1916, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1916, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1916, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (1952, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (2962, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (2962, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (2962, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (2962, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (2962, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4362, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4495, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Internamento')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4507, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4665, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (4985, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5642, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5659, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5659, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5659, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5659, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5659, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5860, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5860, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5860, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5860, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (5860, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Internamento')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6193, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6205, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Hospitalização')
GO
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (6440, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7224, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7307, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7464, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7464, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7464, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7464, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7464, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Internamento')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7480, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Internamento')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7559, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7773, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7808, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7808, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7808, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7808, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (7808, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8067, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (8340, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9090, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9388, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9388, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9388, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9388, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9388, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Consultas médicas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Transporte de Urgência')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9523, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9633, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9633, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9633, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9633, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9633, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Internamento')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9746, N'Transporte gratuito em ambulância')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Ambulatório')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Assistência em caso de doenças graves')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Descontos em consultas de especialidade')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Hospitalização')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Internamento')
INSERT [dbo].[COBRE] ([num_apolice], [descricao]) VALUES (9869, N'Transporte gratuito em ambulância')
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (1, 2017, 6549, CAST(N'2017-01-10' AS Date), 952159)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (1, 2018, 4327, CAST(N'2018-01-05' AS Date), 539100)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (1, 2019, 7504, CAST(N'2019-01-10' AS Date), 167920)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (2, 2017, 5368, CAST(N'2017-01-20' AS Date), 622541)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (2, 2018, 4283, CAST(N'2018-02-25' AS Date), 278032)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (2, 2019, 7322, CAST(N'2019-01-15' AS Date), 327455)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (3, 2017, 8836, CAST(N'2017-01-30' AS Date), 415426)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (3, 2018, 6549, CAST(N'2018-03-27' AS Date), 952159)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (3, 2019, 1111, CAST(N'2019-02-13' AS Date), 810086)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (4, 2017, 9491, CAST(N'2017-02-13' AS Date), 367077)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (4, 2018, 6598, CAST(N'2018-04-16' AS Date), 548092)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (4, 2019, 7504, CAST(N'2019-02-19' AS Date), 167920)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (5, 2017, 2067, CAST(N'2017-02-21' AS Date), 894186)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (5, 2018, 7322, CAST(N'2018-04-25' AS Date), 668174)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (5, 2019, 7057, CAST(N'2019-03-13' AS Date), 278032)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (6, 2017, 1111, CAST(N'2017-02-25' AS Date), 622541)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (6, 2018, 6442, CAST(N'2018-05-12' AS Date), 866730)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (6, 2019, 6549, CAST(N'2019-03-21' AS Date), 167920)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (7, 2017, 6549, CAST(N'2017-03-05' AS Date), 609940)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (7, 2018, 6549, CAST(N'2018-06-16' AS Date), 383257)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (7, 2019, 6598, CAST(N'2019-04-14' AS Date), 327455)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (8, 2017, 6442, CAST(N'2017-03-10' AS Date), 894186)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (8, 2018, 8116, CAST(N'2018-06-25' AS Date), 115544)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (9, 2017, 6853, CAST(N'2017-04-16' AS Date), 215132)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (9, 2018, 1111, CAST(N'2018-07-04' AS Date), 668174)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (10, 2017, 7057, CAST(N'2017-05-23' AS Date), 539100)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (10, 2018, 9053, CAST(N'2018-07-12' AS Date), 548092)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (11, 2017, 6549, CAST(N'2017-06-28' AS Date), 214644)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (11, 2018, 5368, CAST(N'2018-08-10' AS Date), 383257)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (12, 2017, 6598, CAST(N'2017-07-12' AS Date), 609940)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (12, 2018, 2067, CAST(N'2018-08-18' AS Date), 115544)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (13, 2017, 8836, CAST(N'2017-08-16' AS Date), 215132)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (13, 2018, 2923, CAST(N'2018-09-20' AS Date), 385677)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (14, 2017, 5368, CAST(N'2017-09-19' AS Date), 367077)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (14, 2018, 7322, CAST(N'2018-10-03' AS Date), 548092)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (15, 2017, 2067, CAST(N'2017-10-20' AS Date), 214644)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (15, 2018, 5517, CAST(N'2018-10-22' AS Date), 385677)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (16, 2018, 4327, CAST(N'2018-11-19' AS Date), 21812)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (17, 2018, 6549, CAST(N'2018-11-28' AS Date), 810086)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (19, 2018, 9491, CAST(N'2018-12-07' AS Date), 167920)
INSERT [dbo].[CONSULTA] ([num_consulta], [ano], [no_utente], [data], [num_id_medico]) VALUES (20, 2018, 1111, CAST(N'2018-12-16' AS Date), 810086)
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'administração de medicamentos')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'alimentação')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'animação')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'arrumação do espaço do idoso')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'higiene pessoal')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'mobilizacação')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'posicionamento')
INSERT [dbo].[CUIDADO] ([tipo]) VALUES (N'primeiros socorros')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Ambulatório')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Assistência em caso de doenças graves')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Assistência médica e de enfermagem ao domicílio')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Consultas médicas de especialidade')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Descontos em consultas de especialidade')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Hospitalização')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Internamento')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Transporte de Urgência')
INSERT [dbo].[DANO] ([descricao]) VALUES (N'Transporte gratuito em ambulância')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (100, NULL, N'Gabriela Costa', N'200284002', CAST(N'1991-05-09' AS Date), N'F', N'914658732')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (101, NULL, N'Soraia Cavaco', N'252338685', CAST(N'1984-07-21' AS Date), N'F', N'913264855')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (102, NULL, N'Leonardo Monetiro', N'259080896', CAST(N'1991-04-01' AS Date), N'M', N'941628556')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (103, NULL, N'Cristiano Carneiro', N'231199252', CAST(N'1984-07-07' AS Date), N'M', N'943226554')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (104, NULL, N'Marco Simões', N'220176604', CAST(N'1983-09-16' AS Date), N'M', N'943211658')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (105, NULL, N'Alícia Abreu', N'244105383', CAST(N'1983-05-03' AS Date), N'F', N'947756223')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (106, NULL, N'Daniela Batista', N'247502405', CAST(N'1991-07-18' AS Date), N'F', N'984635224')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (107, NULL, N'Clara Moniz', N'275485765', CAST(N'1975-05-13' AS Date), N'F', N'986554477')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (108, NULL, N'Rita Do Rosário', N'279825994', CAST(N'1971-01-06' AS Date), N'F', N'986635289')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (109, NULL, N'Ângelo Caetano', N'268504733', CAST(N'1984-07-26' AS Date), N'M', N'956485231')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (110, NULL, N'Aline Saldanha', N'275464253', CAST(N'1971-07-20' AS Date), N'F', N'954468523')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (111, NULL, N'Pilar Fonseca', N'23087652 ', CAST(N'1976-04-14' AS Date), N'F', N'955014209')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (112, NULL, N'Isabel Aguiar', N'221932720', CAST(N'1991-04-07' AS Date), N'F', N'955546852')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (113, NULL, N'Andreia Pires', N'258221208', CAST(N'1971-05-17' AS Date), N'F', N'944652318')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (114, NULL, N'Manel Castro', N'235585742', CAST(N'1975-07-09' AS Date), N'M', N'911165823')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (115, NULL, N'Bruno Rodrigues', N'241747899', CAST(N'1983-08-20' AS Date), N'M', N'911487555')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (116, NULL, N'Margarida De Freitas', N'228011469', CAST(N'1991-08-25' AS Date), N'F', N'913626266')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (117, NULL, N'Teresa Siqueira', N'299662764', CAST(N'1971-09-20' AS Date), N'F', N'913265488')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (118, NULL, N'Nuno Resende', N'106650092', CAST(N'1984-04-15' AS Date), N'M', N'95649898 ')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (119, NULL, N'Nelson Góes', N'150337809', CAST(N'1975-05-09' AS Date), N'M', N'985652322')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (120, NULL, N'Carlota Gonçalves', N'137223749', CAST(N'1971-12-08' AS Date), N'F', N'932654155')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (121, NULL, N'José Neves', N'110581318', CAST(N'1991-06-08' AS Date), N'M', N'93233658 ')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (122, NULL, N'Raquel Branco', N'129814679', CAST(N'1973-09-23' AS Date), N'F', N'936655884')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (123, NULL, N'Rute Gama', N'124321666', CAST(N'1975-05-25' AS Date), N'F', N'988562315')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (124, NULL, N'Santiago Furtado', N'150328540', CAST(N'1991-02-24' AS Date), N'M', N'988556634')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (125, NULL, N'Amélia Guerra', N'122118324', CAST(N'1983-08-09' AS Date), N'F', N'911323544')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (126, NULL, N'Sara Varejão', N'135773440', CAST(N'1991-02-24' AS Date), N'F', N'91685563 ')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (127, NULL, N'Gabriel Santos', N'130809233', CAST(N'1991-11-08' AS Date), N'M', N'965652387')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (128, NULL, N'Tomás Menezes', N'119677083', CAST(N'1984-02-20' AS Date), N'M', N'968877555')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (129, NULL, N'Hélder Paiva', N'150767544', CAST(N'1973-02-15' AS Date), N'M', N'955564843')
INSERT [dbo].[EMPREGADO] ([num_id], [fotografia], [nome], [nif], [data_nasc], [sexo], [num_telefone]) VALUES (130, NULL, N'Mara Rocha', N'153564067', CAST(N'1991-04-08' AS Date), N'F', N'913265564')
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (128, 14104)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (107, 14539)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (116, 25390)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (124, 37916)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (109, 50111)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (130, 61765)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (101, 62536)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (114, 69817)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (112, 70250)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (122, 70914)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (120, 80744)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (103, 83644)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (118, 85588)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (126, 88248)
INSERT [dbo].[ENFERMEIRO] ([num_id], [num_ordem_enfermeiros]) VALUES (105, 90132)
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Albosan', N'Acino AG', N'omeprazol')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Avandamet', N'SmithKline Beecham plc', N'metformina + rosiglitazona')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Capsozol', N'Angelini Farmacêutica', N'omeprazol')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Captopril', N'Bluefarma', N'captiopril')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Clopidogrel Actavis', N'Actavis Group PTC', N'clopidogrel')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Clopidogrel Pirmesir', N'Lavineli Farmacêutica', N'clopidogrel')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Metformina Generis', N'Generis Farmacêutica', N'metmormina')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Sedoxil', N'Bial', N'mexazolam')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Singulair', N'MercSharp&Dohma', N'montelucaste')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Venlafaxina Mylan', N'Mylan', N'venlafaxina')
INSERT [dbo].[FARMACO] ([nome], [farmaceutica], [formula]) VALUES (N'Victan', N'Sanofi', N'benzodiazepinas')
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (100)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (102)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (104)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (106)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (108)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (110)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (111)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (113)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (115)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (117)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (119)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (121)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (123)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (125)
INSERT [dbo].[FUNCIONARIO] ([num_id]) VALUES (127)
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (21812, N'Vera De Freitas')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (115544, N'Naiara Coimbra')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (167920, N'Dário Vaz')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (214644, N'Laura Passos')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (215132, N'Tomé Baptista')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (278032, N'Filipe Borges')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (327455, N'Vitória Guerra')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (367077, N'Ema Queiros')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (383257, N'Tomás De Lima')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (385677, N'Inês Montenegro')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (415426, N'Ivan Hernandes')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (539100, N'Cristiano Furtado')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (548092, N'Mariana Mata')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (609940, N'Brian Gonçalves')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (622541, N'Dinis Morais')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (668174, N'Rita Macedo')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (810086, N'Carolina Carreira')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (866730, N'Filomena Nascimento')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (894186, N'Melissa Siqueira')
INSERT [dbo].[MEDICO] ([num_id], [nome]) VALUES (952159, N'Mauro Amaral')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (1111, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (1111, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (1111, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (1111, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (1111, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (1111, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2067, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2202, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2202, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2202, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2202, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2202, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2202, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2658, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2658, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2658, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2658, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2658, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2658, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2903, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2903, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2903, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2903, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2903, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2903, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (2923, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3856, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3856, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3856, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3856, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3856, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3856, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (3919, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4283, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4283, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4283, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4283, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4283, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4283, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4327, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4327, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4327, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4327, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4327, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (4327, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5368, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (5517, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6442, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6549, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'posicionamento')
GO
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6598, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6652, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6853, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6853, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6853, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6853, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6853, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6853, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6857, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6857, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6857, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6857, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (6857, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'arrumação do espaço do idoso')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7057, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7322, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7504, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7504, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7504, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7504, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7504, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7504, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7816, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7816, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7816, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7816, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7816, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (7816, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8052, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8052, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8052, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8052, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8052, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8052, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8116, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8116, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8116, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8116, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8116, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8116, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8224, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8629, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8836, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8836, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8836, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8836, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8836, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (8836, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'alimentação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9053, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9491, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9491, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9491, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9491, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9491, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9491, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9529, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9529, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9529, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9529, N'mobilizacação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9529, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9529, N'primeiros socorros')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9640, N'administração de medicamentos')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9640, N'animação')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9640, N'higiene pessoal')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9640, N'mobilizacação')
GO
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9640, N'posicionamento')
INSERT [dbo].[NECESSITA] ([no_utente], [tipo]) VALUES (9640, N'primeiros socorros')
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10001, CAST(N'2017-09-19' AS Date), 14, 2017)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10002, CAST(N'2018-01-05' AS Date), 1, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10003, CAST(N'2018-02-25' AS Date), 2, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10004, CAST(N'2018-04-16' AS Date), 4, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10005, CAST(N'2018-05-12' AS Date), 6, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10006, CAST(N'2018-06-25' AS Date), 8, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10007, CAST(N'2018-07-12' AS Date), 10, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10008, CAST(N'2018-09-20' AS Date), 13, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10009, CAST(N'2018-10-03' AS Date), 14, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10010, CAST(N'2018-10-22' AS Date), 15, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10011, CAST(N'2018-11-19' AS Date), 16, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10012, CAST(N'2018-11-28' AS Date), 17, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10013, CAST(N'2018-12-07' AS Date), 19, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10014, CAST(N'2018-12-16' AS Date), 20, 2018)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10015, CAST(N'2019-01-10' AS Date), 1, 2019)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10016, CAST(N'2019-01-15' AS Date), 2, 2019)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10017, CAST(N'2019-02-13' AS Date), 3, 2019)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10018, CAST(N'2019-02-19' AS Date), 4, 2019)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10019, CAST(N'2019-03-13' AS Date), 5, 2019)
INSERT [dbo].[PRESCRICAO] ([num_prescricao], [data], [num_consulta], [ano]) VALUES (10020, CAST(N'2019-04-14' AS Date), 7, 2019)
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (100, N'alimentação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (100, N'higiene pessoal')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (100, N'mobilizacação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (101, N'administração de medicamentos')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (101, N'arrumação do espaço do idoso')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (101, N'higiene pessoal')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (101, N'mobilizacação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (111, N'alimentação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (111, N'arrumação do espaço do idoso')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (112, N'higiene pessoal')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (113, N'alimentação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (115, N'animação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (115, N'higiene pessoal')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (116, N'mobilizacação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (120, N'administração de medicamentos')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (120, N'animação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (120, N'primeiros socorros')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (123, N'arrumação do espaço do idoso')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (124, N'administração de medicamentos')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (126, N'mobilizacação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (128, N'alimentação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (128, N'mobilizacação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (130, N'administração de medicamentos')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (130, N'alimentação')
INSERT [dbo].[PRESTA] ([num_emp], [tipo_cuidado]) VALUES (130, N'higiene pessoal')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (211, 16, N'1 pessoa; cama articulada, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (300, 8, N'2 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (307, 17, N'2 pessoas; camas articuladas')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (318, 9, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (347, 18, N'3 pessoas; camas articuladas')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (366, 1, N'1 pessoa; cama articulada, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (376, 2, N'2 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (397, 3, N'2 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (436, 19, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (441, 10, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (449, 20, N'2 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (461, 11, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (481, 4, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (525, 21, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (548, 12, N'2 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (555, 13, N'1 pessoa; cama articulada')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (628, 22, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (686, 14, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (725, 23, N'2 pessoas; camas articuladas')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (772, 15, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (827, 5, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (875, 6, N'2 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (879, 24, N'1 pessoa; cama articulada')
INSERT [dbo].[QUARTO] ([id], [numero], [detalhes]) VALUES (942, 7, N'3 pessoas; camas articuladas, casa de banho')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Albosan', N'Acino AG', 10006, CAST(N'2018-07-08' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Albosan', N'Acino AG', 10011, CAST(N'2018-11-30' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Albosan', N'Acino AG', 10013, CAST(N'2018-12-21' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Avandamet', N'SmithKline Beecham plc', 10002, CAST(N'2018-01-25' AS Date), N'3 vezes ao dia')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Capsozol', N'Angelini Farmacêutica', 10010, CAST(N'2018-10-31' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Captopril', N'Bluefarma', 10008, CAST(N'2018-10-10' AS Date), N'após as refeições')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Captopril', N'Bluefarma', 10020, CAST(N'2019-04-30' AS Date), N'após as refeições')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Clopidogrel Actavis', N'Actavis Group PTC', 10014, CAST(N'2019-01-04' AS Date), N'2 vezes ao dia')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Clopidogrel Pirmesir', N'Lavineli Farmacêutica', 10005, CAST(N'2018-05-30' AS Date), N'2 vezes ao dia')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Clopidogrel Pirmesir', N'Lavineli Farmacêutica', 10018, CAST(N'2019-03-10' AS Date), N'2 vezes ao dia')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Metformina Generis', N'Generis Farmacêutica', 10007, CAST(N'2018-07-22' AS Date), N'2 vezes ao dia')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Sedoxil', N'Bial', 10001, CAST(N'2017-10-19' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Sedoxil', N'Bial', 10017, CAST(N'2019-02-27' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Singulair', N'MercSharp&Dohma', 10009, CAST(N'2018-10-15' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Singulair', N'MercSharp&Dohma', 10015, CAST(N'2019-01-24' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Singulair', N'MercSharp&Dohma', 10019, CAST(N'2019-03-27' AS Date), N'diariamente')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Venlafaxina Mylan', N'Mylan', 10003, CAST(N'2018-03-10' AS Date), N'após as refeições')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Venlafaxina Mylan', N'Mylan', 10016, CAST(N'2019-02-03' AS Date), N'após as refeições')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Victan', N'Sanofi', 10004, CAST(N'2018-05-06' AS Date), N'3 vezes ao dia')
INSERT [dbo].[REFERE] ([nome_farmaco], [farmaceutica], [num_prescricao], [data_fim_tratamento], [freq]) VALUES (N'Victan', N'Sanofi', 10012, CAST(N'2018-12-15' AS Date), N'3 vezes ao dia')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'071050812HWZ', N'Lúcia Seabra', N'Rua Dom António Alves Martins 3504-506 Viseu', N'Familiar', N'985291347')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'096649375LQG', N'Enzo Machado', N'Rua das Encruzilhadas 7320-123 Castelo de Vide', N'Familiar', N'977520343')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'110770374ILM', N'Filomena Cardoso', N'Praça Marquês de Pombal 3814-502 Aveiro', N'Amigo', N'922628039')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'124282598T5F', N'Fabiana Mascarenhas', N'Rua José Joaquim Lopes de Lima 3810-101 Aveiro', N'Familiar', N'911299756')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'1288501753IL', N'Mariana Branco', N'Rua Alexandre Herculano Café Lobito 4000-005 Porto', N'Familiar', N'923080708')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'146832574O7T', N'Leonardo Roque', N'Rua da Costa Nova 3830-469 Gafanha da Encarnação', N'Familiar', N'953016895')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'148013368J1D', N'Victória Fernandes', N'Rua de Santiago 3814-506 Aveiro', N'Assistente Social', N'992370262')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'153278447QC0', N'Paulo Fontes', N'Travessa das Beatas 3810-006 Aveiro', N'Familiar', N'990798499')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'160369606OUN', N'Lia Pereira', N'Rua Bernardino Felgueiras 3054-003 Mealhada', N'Familiar', N'919068305')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'177696088EYX', N'Simão Pacheco', N'Avenida Fontes Pereira de Melo 14 1069-107 Lisboa', N'Familiar', N'955899865')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'17917108904M', N'Rafaela Coutinho', N'Rua João de Barros 3500-140 Viseu', N'Assistente Social', N'992313433')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'1836461189T9', N'Brian Pinho', N'Travessa Capitão Ribeiro 4400-007 Vila Nova de Gaia', N'Familiar', N'985191781')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'193231760S7U', N'Luana Moniz', N'Rua de Caminho Velho 4400-006 Vila Nova de Gaia', N'Familiar', N'937891963')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'201977803ATT', N'Sandra Queirós', N'Rua Lagoa Paramos 4504-855 Espinho', N'Familiar', N'930712480')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'264103962WPF', N'Mateus Resendes', N'Rua Henriques Nogueira Antas 4760-003 Vila Nova de Famalicão', N'Familiar', N'988916801')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'283192762G17', N'Aline Passos', N'Rua Fonte da Guia Granja de Baixo 3810-905 Oliveirinha', N'Familiar', N'986263015')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'283938837TOT', N'Áurea Siqueira', N'Rua Semouqueira 3850-131 Albergaria-A-Velha', N'Familiar', N'949658284')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'292019886HCP', N'Flávio De Sá', N'Rua Trás do Outeiro 2460-492 Évora', N'Assistente Social', N'928713392')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'353606474E37', N'Hugo Garcia', N'Rua do Barro São Bernardo 3810-006 Aveiro', N'Familiar', N'916059357')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'357456953KFB', N'Bárbara Lima', N'Rua Engenheiro Duarte Pacheco 3850-004 Albergaria-A-Velha', N'Familiar', N'983660489')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'381668278RR1', N'Tomé Cunha', N'Avenida Comendador Augusto Martins Pereira 3744-002 Sever do Vouga', N'Familiar', N'972531807')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'443089348Y4P', N'Alexandra Saldanha', N'Largo Amigos do Baleal 2520-001 Baleal ', N'Assistente Social', N'913135831')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'487565029JA9', N'Sérgio Serra', N'Avenida 5 de Outubro 160 1069-003 Lisboa', N'Familiar', N'988847262')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'536233353K5O', N'Alice Coimbra', N'Avenida Combatentes do Ultramar 5180-102 Freixo de Espada à Cinta', N'Assistente Social', N'938237857')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'607795030NMS', N'Ivan Araújo', N'Rua Carolino Ramos 2 4904-852 Viana do Castelo', N'Familiar', N'939831351')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'6550742856UN', N'Micael Furtado', N'Avenida Elísio de Moura 155 3034-001 Coimbra', N'Familiar', N'975677458')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'769207467U9D', N'Martim Salgado', N'Rua Araújo Guimarães 2460-002 Alcobaça', N'Assistente Social', N'916684947')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'7949647497NE', N'Violeta Corte-Real', N'Avenida Sidónio Pais 4E 1069-003 Lisboa', N'Familiar', N'950464347')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'874671782YPR', N'Daniel Torres', N'Avenida Saraiva de Carvalho 3084-501 Figueira da Foz', N'Familiar', N'984152772')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'98334854406O', N'Joana Venâncio', N'Rua Cabo do Lugar 5150-002 Almendra', N'Assistente Social', N'925194264')
INSERT [dbo].[RESPONSAVEL] ([cartao_cidadao], [nome], [morada], [tipo], [numero_telefone]) VALUES (N'995049341OZY', N'Alícia Vomlel', N'Rua Sardeiral 6200-801 Vale Formoso', N'Assistente Social', N'978289502')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (1111, N'874671782YPR', 772, N'Martim Torres', NULL, N'Senhor Martim', CAST(N'1934-02-10' AS Date), N'M', N'Viúvo(a)', N'145139083', N'Avenida Saraiva de Carvalho 3084-501 Figueira da Foz', CAST(N'2008-09-03' AS Date), N'554020605', N'66781861472', N'ADM', N'Médio', N'992129183')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (2067, N'1836461189T9', 172, N'Gabriela Pinho', NULL, N'Dona Gabriela', CAST(N'1942-08-03' AS Date), N'F', N'Viúvo(a)', N'502516128', NULL, CAST(N'2012-01-26' AS Date), N'860668765', N'38537831884', N'ADSE', N'Elevado', N'990980711')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (2202, N'177696088EYX', 686, N'Cristiana Freire', NULL, N'Dona Cristiana', CAST(N'1921-04-08' AS Date), N'F', N'Casado(a)', N'859978727', N'Praceta Afonso V 3810-009 Aveiro', CAST(N'2012-11-29' AS Date), N'511937359', N'48464490807', N'ADSE', N'Médio', N'948082770')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (2658, N'357456953KFB', 441, N'Laura Lima', NULL, N'Dona Laura', CAST(N'1940-03-26' AS Date), N'F', N'Casado(a)', N'892846451', N'Avenida Sidónio Pais 4E 1069-003 Lisboa', CAST(N'2012-02-27' AS Date), N'199876644', N'44281781023', N'ADSE', N'Elevado', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (2903, N'264103962WPF', 436, N'Bernardo Couto', NULL, N'Senhor Bernardo', CAST(N'1925-05-04' AS Date), N'M', N'Casado(a)', N'755794043', N'Rua dos Cardadeiros 3830-008 Gafanha da Boavista', CAST(N'2012-01-16' AS Date), N'952668681', N'16677630268', N'SAD-PSP', N'Médio', N'904083817')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (2923, N'995049341OZY', 942, N'Paulo Silvestre', NULL, N'Senhor Paulo', CAST(N'1939-07-30' AS Date), N'M', N'Viúvo(a)', N'300535140', N'Rua João de Deus 160 3701-501 São João da Madeira', CAST(N'2008-10-20' AS Date), N'387768788', N'30446475904', N'ADM', N'Elevado', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (3856, N'146832574O7T', 725, N'Brian Roque', NULL, N'Senhor Brian', CAST(N'1922-10-21' AS Date), N'M', N'Viúvo(a)', N'373466209', N'Rua da Costa Nova 3830-469 Gafanha da Encarnação', CAST(N'2016-07-13' AS Date), N'40391489 ', N'93233568555', N'ADM', N'Médio', N'936981112')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (3919, N'292019886HCP', 876, N'Iara Cordeiro', NULL, N'Dona Iara', CAST(N'1955-05-23' AS Date), N'F', N'Viúvo(a)', N'964862735', NULL, CAST(N'2013-11-19' AS Date), N'431534370', N'97436517175', N'ADSE', N'Baixo', N'933430376')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (4283, N'98334854406O', 397, N'Kevin Sequeira', NULL, N'Senhor Kevin', CAST(N'1956-01-02' AS Date), N'M', N'Solteiro(a)', N'416819899', N'Rua Cerca 5150-003 Almendra', CAST(N'2008-08-13' AS Date), N'860378418', N'78844917878', N'ADSE', N'Médio', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (4327, N'283192762G17', 300, N'Leandro Passos', NULL, N'Senhor Leandro', CAST(N'1952-01-13' AS Date), N'M', N'Viúvo(a)', N'64763902 ', N'Rua Fonte da Guia Granja de Baixo 3810-905 Oliveirinha', CAST(N'2012-03-13' AS Date), N'97080527 ', N'35950893626', N'ADSE', N'Médio', N'949625703')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (5368, N'381668278RR1', 555, N'Francisca Cunha', NULL, N'Dona Francisca', CAST(N'1955-09-12' AS Date), N'F', N'Viúvo(a)', N'509893548', N'Avenida Comendador Augusto Martins Pereira 3744-002 Sever do Vouga', CAST(N'2018-12-23' AS Date), N'644531106', N'8677889683 ', N'ADSE', N'Elevado', N'978454114')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (5517, N'096649375LQG', 827, N'Carolina Machado', NULL, N'Dona Carolina ', CAST(N'1958-01-01' AS Date), N'F', N'Solteiro(a)', N'636982499', N'Rua das Encruzilhadas 7320-123 Castelo de Vide', CAST(N'2016-04-26' AS Date), N'170935378', N'38446159326', N'ADSE', N'Baixo', N'951880537')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (6442, N'769207467U9D', 779, N'Marta Cardoso', NULL, N'Senhora Marta', CAST(N'1946-12-29' AS Date), N'M', N'Viúvo(a)', N'884773028', NULL, CAST(N'2007-09-04' AS Date), N'614068288', N'14702661412', N'ADM', N'Elevado', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (6549, N'1288501753IL', 148, N'Francisco Branco', NULL, N'Senhor Francisco', CAST(N'1943-10-20' AS Date), N'M', N'Casado(a)', N'413599972', NULL, CAST(N'2012-12-21' AS Date), N'252022562', N'69981578653', N'ADM', N'Médio', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (6598, N'17917108904M', 879, N'Rita Saraiva', NULL, N'Dona Rita', CAST(N'1930-11-14' AS Date), N'F', N'Viúvo(a)', N'7889175  ', N'Rua de Luis Cipriano 3810-128 Aveiro', CAST(N'2017-01-03' AS Date), N'195288786', N'36173731062', N'ADSE', N'Elevado', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (6652, N'110770374ILM', 150, N'Mónica Brandão', NULL, N'Senhora Mónica', CAST(N'1954-07-29' AS Date), N'F', N'Solteiro(a)', N'486832453', NULL, CAST(N'2011-03-27' AS Date), N'802832071', N'81748693039', N'ADSE', N'Médio', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (6853, N'153278447QC0', 224, N'Gil Fontes', NULL, N'Senhor Gil', CAST(N'1956-06-28' AS Date), N'M', N'Viúvo(a)', N'463030703', NULL, CAST(N'2007-02-11' AS Date), N'404081403', N'44666650625', N'ADM', N'Médio', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (6857, N'283938837TOT', 461, N'David Siqueira', NULL, N'Senhor David', CAST(N'1955-12-17' AS Date), N'M', N'Viúvo(a)', N'721197588', N'Largo Soutelo 3850-530 Branca', CAST(N'2011-05-21' AS Date), N'454153216', N'7897269258 ', N'ADSE', N'Baixo', N'970535597')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (7057, N'160369606OUN', 985, N'Renata Pereira', NULL, N'Dona Renata', CAST(N'1949-08-30' AS Date), N'F', N'Casado(a)', N'201213355', NULL, CAST(N'2016-05-25' AS Date), N'609966919', N'16728381576', N'ADSE', N'Médio', N'941312571')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (7322, N'607795030NMS', 875, N'Luana Leite', NULL, N'Dona Luana', CAST(N'1951-11-20' AS Date), N'F', N'Casado(a)', N'932524504', N'Rua Santiago da Barra 4904-882 Viana do Castelo', CAST(N'2012-05-30' AS Date), N'672709541', N'26217905706', N'ADSE', N'Elevado', N'966410915')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (7504, N'353606474E37', 366, N'Leonor Garcia', NULL, N'Dona Leonor', CAST(N'1936-04-15' AS Date), N'F', N'Casado(a)', N'587947944', N'Rua do Barro São Bernardo 3810-006 Aveiro', CAST(N'2012-01-08' AS Date), N'461763919', N'60128984614', N'ADSE', N'Médio', N'997567381')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (7816, N'487565029JA9', 211, N'Lucas Serra', NULL, N'Senhor Lucas', CAST(N'1932-03-17' AS Date), N'M', N'Casado(a)', N'969483491', N'Rua Fernando Caldeira 3754-501 Águeda', CAST(N'2015-05-05' AS Date), N'667169120', N'86463610625', N'ADSE', N'Médio', N'998242051')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (8052, N'193231760S7U', 449, N'Ângela Moniz', NULL, N'Dona Ângela', CAST(N'1934-10-18' AS Date), N'F', N'Viúvo(a)', N'251927324', N'Praça da Ermida 3830-102 Ílhavo', CAST(N'2008-12-16' AS Date), N'643410970', N'6300403358 ', N'ADSE', N'Médio', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (8116, N'7949647497NE', 318, N'Eduarda Corte-Real', NULL, N'Senhora Eduarda', CAST(N'1941-11-30' AS Date), N'F', N'Viúvo(a)', N'122484835', N'Rua dos Irmãos Oliveira Lopes 3884-006 Ovar', CAST(N'2015-09-10' AS Date), N'841011976', N'93894464904', N'ADSE', N'Médio', N'967694245')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (8224, N'201977803ATT', 307, N'Mélanie Queirós', NULL, N'Dona Mélanie', CAST(N'1936-08-16' AS Date), N'F', N'Viúvo(a)', N'296664077', N'Rua Lagoa Paramos 4504-855 Espinho', CAST(N'2012-10-09' AS Date), N'268775503', N'33899930023', N'ADSE', N'Elevado', N'929318631')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (8629, N'124282598T5F', 525, N'Noah Mata', NULL, N'Senhora Noah', CAST(N'1957-05-15' AS Date), N'F', N'Viúvo(a)', N'107713956', N'Rua José Joaquim Lopes de Lima 3810-101 Aveiro', CAST(N'2011-08-07' AS Date), N'824971   ', N'85716376685', N'ADSE', N'Elevado', N'913355287')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (8836, N'536233353K5O', 376, N'Henrique Paiva', NULL, N'Senhor Henrique', CAST(N'1932-03-24' AS Date), N'M', N'Viúvo(a)', N'203554176', N'Rua Doutor Mário Sacramento Câmara Municipal de Aveiro 3810-104 Aveiro', CAST(N'2011-10-11' AS Date), N'587554431', N'15098187021', N'SAD-GNR', N'Médio', N'945944368')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (9053, N'443089348Y4P', 481, N'Rúben Florencio', NULL, N'Senhor Rúben', CAST(N'1932-07-23' AS Date), N'M', N'Viúvo(a)', N'551356140', N'Largo do Catrola 2520-105 Ferrel', CAST(N'2010-01-26' AS Date), N'734800192', N'698060381  ', N'ADSE', N'Elevado', N'902691789')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (9491, N'071050812HWZ', 548, N'Fabiana Seabra', NULL, N'Dona Fabiana', CAST(N'1922-02-28' AS Date), N'F', N'Casado(a)', N'700949432', N'Rua Dom António Alves Martins 3504-506 Viseu', CAST(N'2017-12-27' AS Date), N'544756853', N'14751251894', N'ADSE', N'Médio', NULL)
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (9529, N'6550742856UN', 347, N'César Furtado', NULL, N'Senhor César', CAST(N'1939-11-25' AS Date), N'M', N'Viúvo(a)', N'665152335', N'Bairro da Smida 3830-001 Ervosas', CAST(N'2014-09-10' AS Date), N'977131568', N'46508215694', N'ADSE', N'Médio', N'959922376')
INSERT [dbo].[UTENTE] ([no_utente], [cc_responsavel], [id_alojamento], [nome], [fotografia], [alcunha], [data_nasc], [sexo], [estado_civil], [NIF], [morada_anterior], [data_entrada], [sns], [niss], [subsistema_saude], [grau_dependencia], [num_telemovel]) VALUES (9640, N'148013368J1D', 628, N'Ana Bento', NULL, N'Dona Ana', CAST(N'1925-02-21' AS Date), N'F', N'Casado(a)', N'440010415', N'Rua de Santiago 3814-506 Aveiro', CAST(N'2008-06-20' AS Date), N'403679538', N'25099126529', N'ADSE', N'Médio', NULL)
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (1111, N'874671782YPR', CAST(N'2010-06-17' AS Date), CAST(N'17:55:00' AS Time), CAST(N'18:45:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (2202, N'177696088EYX', CAST(N'2013-12-23' AS Date), CAST(N'17:39:00' AS Time), CAST(N'18:34:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (4283, N'98334854406O', CAST(N'2009-04-11' AS Date), CAST(N'10:39:00' AS Time), CAST(N'11:15:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (4327, N'283192762G17', CAST(N'2013-09-15' AS Date), CAST(N'12:13:00' AS Time), CAST(N'13:16:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (4327, N'751632408EPP', CAST(N'2012-12-26' AS Date), CAST(N'18:12:00' AS Time), CAST(N'18:42:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (5368, N'381668278RR1', CAST(N'2019-05-01' AS Date), CAST(N'16:57:00' AS Time), CAST(N'17:21:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (5368, N'786169312OOJ', CAST(N'2019-03-25' AS Date), CAST(N'13:09:00' AS Time), CAST(N'14:42:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (5517, N'096649375LQG', CAST(N'2017-03-01' AS Date), CAST(N'18:05:00' AS Time), CAST(N'18:31:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (7322, N'116565346XS8', CAST(N'2012-12-24' AS Date), CAST(N'18:24:00' AS Time), CAST(N'18:57:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (7504, N'353606474E37', CAST(N'2013-02-21' AS Date), CAST(N'14:33:00' AS Time), CAST(N'15:53:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (7504, N'353606474E37', CAST(N'2014-10-08' AS Date), CAST(N'16:55:00' AS Time), CAST(N'18:02:00' AS Time))
INSERT [dbo].[VISITA] ([no_utente], [cc_visitante], [data], [hora_entrada], [hora_saida]) VALUES (7816, N'487565029JA9', CAST(N'2016-01-05' AS Date), CAST(N'18:06:00' AS Time), CAST(N'18:48:00' AS Time))
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'096649375LQG', N'Enzo Machado')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'116565346XS8', N'Rafaela  Peres')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'177696088EYX', N'Simão Pacheco')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'283192762G17', N'Aline Passos')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'353606474E37', N'Hugo Garcia')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'381668278RR1', N'Tomé Cunha')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'487565029JA9', N'Sérgio Serra')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'751632408EPP', N'Samuel  Passos')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'786169312OOJ', N'Vitória  Seabra')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'874671782YPR', N'Daniel Torres')
INSERT [dbo].[VISITANTE] ([cartao_cidadao], [nome]) VALUES (N'98334854406O', N'Joana Venâncio')
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__EMPREGAD__DF97D0F2FD1D24A1]    Script Date: 06/06/2019 21:55:52 ******/
ALTER TABLE [dbo].[EMPREGADO] ADD UNIQUE NONCLUSTERED 
(
	[nif] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__ENFERMEI__75F812A24B9F9A4F]    Script Date: 06/06/2019 21:55:52 ******/
ALTER TABLE [dbo].[ENFERMEIRO] ADD UNIQUE NONCLUSTERED 
(
	[num_ordem_enfermeiros] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__UTENTE__C7DEC33068984761]    Script Date: 06/06/2019 21:55:52 ******/
ALTER TABLE [dbo].[UTENTE] ADD UNIQUE NONCLUSTERED 
(
	[NIF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APOLICE_SEGURO]  WITH CHECK ADD FOREIGN KEY([num_utente])
REFERENCES [dbo].[UTENTE] ([no_utente])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CASA]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[ALOJAMENTO] ([id])
GO
ALTER TABLE [dbo].[COBRE]  WITH CHECK ADD FOREIGN KEY([descricao])
REFERENCES [dbo].[DANO] ([descricao])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[COBRE]  WITH CHECK ADD FOREIGN KEY([num_apolice])
REFERENCES [dbo].[APOLICE_SEGURO] ([num])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CONSULTA]  WITH CHECK ADD FOREIGN KEY([no_utente])
REFERENCES [dbo].[UTENTE] ([no_utente])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CONSULTA]  WITH CHECK ADD FOREIGN KEY([num_id_medico])
REFERENCES [dbo].[MEDICO] ([num_id])
GO
ALTER TABLE [dbo].[ENFERMEIRO]  WITH CHECK ADD FOREIGN KEY([num_id])
REFERENCES [dbo].[EMPREGADO] ([num_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FUNCIONARIO]  WITH CHECK ADD FOREIGN KEY([num_id])
REFERENCES [dbo].[EMPREGADO] ([num_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NECESSITA]  WITH CHECK ADD FOREIGN KEY([no_utente])
REFERENCES [dbo].[UTENTE] ([no_utente])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NECESSITA]  WITH CHECK ADD FOREIGN KEY([tipo])
REFERENCES [dbo].[CUIDADO] ([tipo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRESCRICAO]  WITH CHECK ADD FOREIGN KEY([num_consulta], [ano])
REFERENCES [dbo].[CONSULTA] ([num_consulta], [ano])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRESTA]  WITH CHECK ADD FOREIGN KEY([num_emp])
REFERENCES [dbo].[EMPREGADO] ([num_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRESTA]  WITH CHECK ADD FOREIGN KEY([tipo_cuidado])
REFERENCES [dbo].[CUIDADO] ([tipo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QUARTO]  WITH CHECK ADD FOREIGN KEY([id])
REFERENCES [dbo].[ALOJAMENTO] ([id])
GO
ALTER TABLE [dbo].[REFERE]  WITH CHECK ADD FOREIGN KEY([num_prescricao])
REFERENCES [dbo].[PRESCRICAO] ([num_prescricao])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[REFERE]  WITH CHECK ADD  CONSTRAINT [fk_farmaco_farmaceutica] FOREIGN KEY([nome_farmaco], [farmaceutica])
REFERENCES [dbo].[FARMACO] ([nome], [farmaceutica])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[REFERE] CHECK CONSTRAINT [fk_farmaco_farmaceutica]
GO
ALTER TABLE [dbo].[UTENTE]  WITH CHECK ADD FOREIGN KEY([cc_responsavel])
REFERENCES [dbo].[RESPONSAVEL] ([cartao_cidadao])
GO
ALTER TABLE [dbo].[UTENTE]  WITH CHECK ADD FOREIGN KEY([id_alojamento])
REFERENCES [dbo].[ALOJAMENTO] ([id])
GO
ALTER TABLE [dbo].[VISITA]  WITH CHECK ADD FOREIGN KEY([cc_visitante])
REFERENCES [dbo].[VISITANTE] ([cartao_cidadao])
GO
ALTER TABLE [dbo].[VISITA]  WITH CHECK ADD FOREIGN KEY([no_utente])
REFERENCES [dbo].[UTENTE] ([no_utente])
ON DELETE CASCADE
GO
/****** Object:  StoredProcedure [dbo].[AddApolice]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddApolice] @nome_seguradora VARCHAR(50), @nome_plano VARCHAR(50), @num_utente INT , @preco DECIMAL(7,2), @tipo VARCHAR(15), @data_inicio DATE, @data_expiracao	DATE, @modalidade_pagamento VARCHAR(15)
	as
	declare @num INT;
	select @num = Max(num)+1 from APOLICE_SEGURO;
	insert into APOLICE_SEGURO values (@num , @nome_seguradora , @nome_plano , @num_utente , @preco , @tipo , @data_inicio , @data_expiracao	, @modalidade_pagamento);

GO
/****** Object:  StoredProcedure [dbo].[AddConsulta]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddConsulta] @no_utente INT, @data DATE, @num_id_medico INT
	as
	declare @ano_max int;
	select @ano_max = MAX(ano) from CONSULTA;
	declare @numero_consulta INT;
	select @numero_consulta = MAX(num_consulta)+1 from CONSULTA where ano=@ano_max;
	insert into CONSULTA values (@numero_consulta, @ano_max, @no_utente, @data, @num_id_medico);

GO
/****** Object:  StoredProcedure [dbo].[AddCuidadoPrestado]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddCuidadoPrestado] @num_emp INT , @tipo_cuidado VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from PRESTA where num_emp=@num_emp and tipo_cuidado=@tipo_cuidado;
	if(@count=0)
	begin
		insert into PRESTA values (@num_emp, @tipo_cuidado);
	end

GO
/****** Object:  StoredProcedure [dbo].[AddDanoToApolice]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddDanoToApolice] @num_apolice INT, @descricao VARCHAR(100)
	as
	declare @count int;
	select @count = count(*) from COBRE where num_apolice=@num_apolice and descricao=@descricao;
	if(@count=0)
	begin
		insert into COBRE values (@num_apolice, @descricao);
	end

GO
/****** Object:  StoredProcedure [dbo].[AddEnfermeiro]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddEnfermeiro] @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9),@num_ordem_enfermeiros INT, @fotografia CHARACTER = null
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

GO
/****** Object:  StoredProcedure [dbo].[AddFarmaco]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddFarmaco] @nome VARCHAR(50), @farmaceutica VARCHAR(50), @formula VARCHAR(30)
	as
	insert into FARMACO values (@nome, @farmaceutica, @formula);

GO
/****** Object:  StoredProcedure [dbo].[AddFuncionario]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddFuncionario] @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9), @fotografia CHARACTER = null
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

GO
/****** Object:  StoredProcedure [dbo].[AddMedico]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddMedico] @num_id INT, @nome VARCHAR(50)
	as
	insert into MEDICO values(@num_id, @nome);

GO
/****** Object:  StoredProcedure [dbo].[AddPrescricao]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddPrescricao] @num_prescricao INT, @data DATE, @num_consulta INT, @ano INT
	as
	insert into PRESCRICAO values (@num_prescricao, @data, @num_consulta, @ano);

GO
/****** Object:  StoredProcedure [dbo].[AddReferencia]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddReferencia] @nome_farmaco VARCHAR(50), @farmaceutica VARCHAR(50), @num_prescricao INT, @data_fim_tratamento DATE, @freq VARCHAR(20)
	as
	insert into REFERE values (@nome_farmaco, @farmaceutica, @num_prescricao, @data_fim_tratamento, @freq);

GO
/****** Object:  StoredProcedure [dbo].[AddResponsavel]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddResponsavel] @cartao_cidadao	CHAR(12),@nome VARCHAR(50),@morada VARCHAR(100),@tipo VARCHAR(50),@numero_telefone CHAR(9)
	as
	insert into RESPONSAVEL values (@cartao_cidadao, @nome, @morada, @tipo,@numero_telefone);

GO
/****** Object:  StoredProcedure [dbo].[AddUtente]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddUtente] @cc_resp CHAR(12), @nome varchar(50), @alcunha varchar(50), @data_nasc DATE, @sexo CHAR,
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

GO
/****** Object:  StoredProcedure [dbo].[AddUtenteCuidado]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddUtenteCuidado] @no_utente INT , @tipo VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from NECESSITA where no_utente=@no_utente and tipo=@tipo;
	if(@count=0)
	begin
		insert into NECESSITA values (@no_utente, @tipo);
	end

GO
/****** Object:  StoredProcedure [dbo].[AddVisita]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddVisita] @no_utente INT, @cc_visitante CHAR(12),@data DATE , @hora_entrada TIME(0) = '14:00',@hora_saida TIME(0) = '19:30'
	as
	insert into VISITA values (@no_utente, @cc_visitante, @data ,@hora_entrada, @hora_saida);

GO
/****** Object:  StoredProcedure [dbo].[AddVisitante]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddVisitante] @cartao_cidadao CHAR(12),@nome VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from VISITANTE where cartao_cidadao=@cartao_cidadao;
	if(@count=0)
	begin
		insert into VISITANTE values (@cartao_cidadao, @nome);
	end

GO
/****** Object:  StoredProcedure [dbo].[AlterApolice]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AlterApolice]  @num INT ,@nome_seguradora VARCHAR(50), @nome_plano VARCHAR(50), @num_utente INT , @preco DECIMAL(7,2), @tipo VARCHAR(15), @data_inicio DATE, @data_expiracao	DATE, @modalidade_pagamento VARCHAR(15)
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

GO
/****** Object:  StoredProcedure [dbo].[AlterEnfermeiro]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AlterEnfermeiro] @num_id INT, @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9),@num_ordem_enfermeiros INT, @fotografia CHARACTER = null
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

GO
/****** Object:  StoredProcedure [dbo].[AlterFuncionario]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AlterFuncionario] @num_id INT, @nome VARCHAR(50),@nif CHAR(9),@data_nasc DATE,@sexo CHAR,@num_telefone CHAR(9), @fotografia CHARACTER = null
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

GO
/****** Object:  StoredProcedure [dbo].[AlterMedico]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AlterMedico] @num_id INT, @nome VARCHAR(50)
	as
	UPDATE MEDICO SET nome= @nome WHERE num_id=@num_id;

GO
/****** Object:  StoredProcedure [dbo].[AlterResponsavel]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AlterResponsavel] @cartao_cidadao CHAR(12),@nome VARCHAR(50),@morada VARCHAR(100),@tipo VARCHAR(50),@numero_telefone CHAR(9)
	as

	UPDATE RESPONSAVEL SET nome = @nome WHERE @cartao_cidadao=@cartao_cidadao;
	UPDATE RESPONSAVEL SET morada = @morada WHERE @cartao_cidadao=@cartao_cidadao;
	UPDATE RESPONSAVEL SET tipo = @tipo WHERE @cartao_cidadao=@cartao_cidadao;
	UPDATE RESPONSAVEL SET numero_telefone= @numero_telefone WHERE @cartao_cidadao=@cartao_cidadao;

GO
/****** Object:  StoredProcedure [dbo].[AlterUtente]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[AlterUtente] @no_utente INT, @cc_resp CHAR(12), @nome varchar(50), @alcunha varchar(50), @data_nasc DATE, @sexo CHAR,
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

GO
/****** Object:  StoredProcedure [dbo].[RemoveApolice]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveApolice] @num int
	as
	delete from COBRE where COBRE.num_apolice=@num;
	delete from APOLICE_SEGURO where num=@num;

GO
/****** Object:  StoredProcedure [dbo].[RemoveCuidadoPrestado]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveCuidadoPrestado] @num_emp INT , @tipo_cuidado VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from PRESTA where num_emp=@num_emp and tipo_cuidado=@tipo_cuidado;
	if(@count=1)
	begin
		delete from PRESTA where num_emp=@num_emp and tipo_cuidado=@tipo_cuidado;
	end

GO
/****** Object:  StoredProcedure [dbo].[RemoveDanoToApolice]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveDanoToApolice] @num_apolice INT, @descricao VARCHAR(100)
	as
	declare @count int;
	select @count = count(*) from COBRE where num_apolice=@num_apolice and descricao=@descricao;
	if(@count=1)
	begin
		delete from COBRE where num_apolice=@num_apolice and descricao=@descricao;
	end

GO
/****** Object:  StoredProcedure [dbo].[RemoveEmpregado]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveEmpregado] @num_id int
	as
	delete from EMPREGADO where num_id=@num_id;

GO
/****** Object:  StoredProcedure [dbo].[RemoveUtente]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveUtente] @no_utente INT
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

GO
/****** Object:  StoredProcedure [dbo].[RemoveUtenteCuidado]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[RemoveUtenteCuidado] @no_utente INT , @tipo VARCHAR(50)
	as
	declare @count int;
	select @count = count(*) from NECESSITA where no_utente=@no_utente and tipo=@tipo;
	if(@count=1)
	begin
		delete from NECESSITA where no_utente=@no_utente and tipo=@tipo;
	end

GO
/****** Object:  Trigger [dbo].[check_responsavel]    Script Date: 06/06/2019 21:55:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[check_responsavel] on [dbo].[UTENTE]
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

GO
USE [master]
GO
ALTER DATABASE [p5g1] SET  READ_WRITE 
GO
