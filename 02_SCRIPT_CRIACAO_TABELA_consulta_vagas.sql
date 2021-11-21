USE [DBDBAASSISTS]
GO

-- VERIFICA SE A TABELA EXISTE ANTES DA SUA CRIAÇÃO
-- CASO EXISTA, ELA É EXCLUÍDA
IF EXISTS (SELECT 1 FROM SYS.tables T , SYS.SCHEMAS S WHERE T.schema_id = S.schema_id AND T.NAME =  'consulta_vagas')
DROP TABLE [dbo].[consulta_vagas]
GO

-- CRIAÇÃO DA TABELA 
CREATE TABLE [dbo].[consulta_vagas](
	[DT_GERACAO] [varchar](200) NULL,
	[HH_GERACAO] [varchar](200) NULL,
	[ANO_ELEICAO] [varchar](200) NULL,
	[CD_TIPO_ELEICAO] [varchar](200) NULL,
	[NM_TIPO_ELEICAO] [varchar](200) NULL,
	[CD_ELEICAO] [varchar](200) NULL,
	[DS_ELEICAO] [varchar](200) NULL,
	[DT_ELEICAO] [varchar](200) NULL,
	[DT_POSSE] [varchar](200) NULL,
	[SG_UF] [varchar](200) NULL,
	[SG_UE] [varchar](200) NULL,
	[NM_UE] [varchar](200) NULL,
	[CD_CARGO] [varchar](200) NULL,
	[DS_CARGO] [varchar](200) NULL,
	[QT_VAGAS] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


