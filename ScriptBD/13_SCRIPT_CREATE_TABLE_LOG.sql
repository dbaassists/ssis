USE [LOG_SSIS]
GO

/****** 
DATA: 
DESENVOLVEDOR: GABRIEL QUINTELLA
PROJETO: BLOG DBAASSISTS - SÉRIE NÃO MEXA NOS MEUS COMPONENTES
OBJETIVO: SCRIPT USADO PARA CRIAÇÃO DO BANCO DE DADOS [DBDBAASSISTS]  
******/

/****** Object:  Table [dbo].[TB_Carga]    Script Date: 23/12/2021 20:30:06 ******/
IF EXISTS (SELECT 1 FROM SYS.tables T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'TB_Carga' AND S.NAME = 'dbo')
DROP TABLE [dbo].[TB_Carga]
GO

/****** Object:  Table [dbo].[TB_Carga]    Script Date: 23/12/2021 20:30:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT 1 FROM SYS.tables T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'TB_Carga' AND S.NAME = 'dbo')
CREATE TABLE [dbo].[TB_Carga](
	[IdCarga] [bigint] IDENTITY(1,1) NOT NULL,
	[AbrGrupo] [varchar](3) NOT NULL,
	[CodRef] [bigint] NOT NULL,
	[IdPacote] [varchar](50) NOT NULL,
	[NomPacote] [varchar](70) NOT NULL,
	[DthInicio] [datetime] NULL,
	[TpoExecucao] [varchar](1) NOT NULL,
	[DthFim] [datetime] NULL,
 CONSTRAINT [PK_IdCarga] PRIMARY KEY NONCLUSTERED 
(
	[IdCarga] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[TB_CargaDetalhe]    Script Date: 23/12/2021 20:29:28 ******/
IF EXISTS (SELECT 1 FROM SYS.tables T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'TB_CargaDetalhe' AND S.NAME = 'dbo')
DROP TABLE [dbo].[TB_CargaDetalhe]
GO


IF NOT EXISTS (SELECT 1 FROM SYS.tables T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'TB_CargaDetalhe' AND S.NAME = 'dbo')
CREATE TABLE [dbo].[TB_CargaDetalhe](
	[IdCargaDetalhe] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCarga] [bigint] NOT NULL,
	[IdTarefa] [varchar](50) NOT NULL,
	[NomTarefa] [varchar](70) NOT NULL,
	[Descricao] [varchar](200) NOT NULL,
	[QtdLinhasInseridas] [bigint] NOT NULL,
	[QtdLinhasAtualizadas] [bigint] NOT NULL,
	[TpoExecucao] [varchar](1) NOT NULL,
	[DthInicio] [datetime] NULL,
	[DthFim] [datetime] NULL,
 CONSTRAINT [PK_IdCargaDetalhe] PRIMARY KEY NONCLUSTERED 
(
	[IdCargaDetalhe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TB_CargaDetalhe] ADD  DEFAULT ('') FOR [Descricao]
GO

ALTER TABLE [dbo].[TB_CargaDetalhe]  WITH CHECK ADD  CONSTRAINT [FK_TBCargaDetalhe_TBCarga_01] FOREIGN KEY([IdCarga])
REFERENCES [dbo].[TB_Carga] ([IdCarga])
GO

ALTER TABLE [dbo].[TB_CargaDetalhe] CHECK CONSTRAINT [FK_TBCargaDetalhe_TBCarga_01]
GO


/****** Object:  Table [dbo].[TB_CargaErro]    Script Date: 23/12/2021 22:58:44 ******/
IF EXISTS (SELECT 1 FROM SYS.tables T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'TB_CargaErro' AND S.NAME = 'dbo')
DROP TABLE [dbo].[TB_CargaErro]
GO

/****** Object:  Table [dbo].[TB_CargaErro]    Script Date: 23/12/2021 22:58:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT 1 FROM SYS.tables T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'TB_CargaErro' AND S.NAME = 'dbo')
CREATE TABLE [dbo].[TB_CargaErro](
	[IdCargaErro] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCargaDetalhe] [bigint] NULL,
	[NomTarefa] [varchar](70) NOT NULL,
	[NumErro] [int] NOT NULL,
	[DscErro] [varchar](8000) NULL,
	[LinhaRegistro] [varchar](max) NOT NULL,
	[DthErro] [datetime] NOT NULL,
 CONSTRAINT [Pk_IdCargaErro] PRIMARY KEY NONCLUSTERED 
(
	[IdCargaErro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[TB_CargaErro] ADD  DEFAULT ((2147483647)) FOR [NumErro]
GO

ALTER TABLE [dbo].[TB_CargaErro] ADD  DEFAULT ('') FOR [LinhaRegistro]
GO

ALTER TABLE [dbo].[TB_CargaErro]  WITH CHECK ADD  CONSTRAINT [FK_TBCargaErro_TBCargaDetalhe_01] FOREIGN KEY([IdCargaDetalhe])
REFERENCES [dbo].[TB_CargaDetalhe] ([IdCargaDetalhe])
GO

ALTER TABLE [dbo].[TB_CargaErro] CHECK CONSTRAINT [FK_TBCargaErro_TBCargaDetalhe_01]
GO