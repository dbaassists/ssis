USE [DBDBAASSISTS]
GO

/****** Object:  Table [dbo].[consulta_vagas_nao_carregadas]    Script Date: 01/12/2021 21:20:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[consulta_vagas_nao_carregadas](
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


