


IF EXISTS (SELECT 1 FROM SYS.TABLES T, SYS.SCHEMAS S WHERE T.schema_id = S.schema_id AND T.name = 'VENDAS_MES' AND S.name = 'dbo')
DROP TABLE [dbo].[VENDAS_MES]
GO

CREATE TABLE [dbo].[VENDAS_MES](
	[NOME_LOJA] [varchar](100) NULL,
	[JANEIRO] [decimal](23, 3) NULL,
	[FEVEREIRO] [decimal](23, 3) NULL,
	[MARCO] [decimal](23, 3) NULL,
	[ABRIL] [decimal](23, 3) NULL,
	[MAIO] [decimal](23, 3) NULL,
	[JUNHO] [decimal](23, 3) NULL,
	[JULHO] [decimal](23, 3) NULL,
	[AGOSTO] [decimal](23, 3) NULL,
	[SETEMBRO] [decimal](23, 3) NULL,
	[OUTUBRO] [decimal](23, 3) NULL,
	[NOVEMBRO] [decimal](23, 3) NULL,
	[DEZEMBRO] [decimal](23, 3) NULL
)
GO