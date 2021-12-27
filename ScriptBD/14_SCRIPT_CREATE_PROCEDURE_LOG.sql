USE [LOG_SSIS]
GO

/****** Object:  StoredProcedure [dbo].[STP_SIU_CarregaLog]    Script Date: 23/12/2021 21:01:02 ******/
IF EXISTS (SELECT 1 FROM SYS.procedures T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'STP_SIU_CarregaLog' AND S.NAME = 'dbo')
DROP PROCEDURE [dbo].[STP_SIU_CarregaLog]
GO

/****** Object:  StoredProcedure [dbo].[STP_SIU_CarregaLog]    Script Date: 23/12/2021 21:01:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF NOT EXISTS (SELECT 1 FROM SYS.procedures T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'STP_SIU_CarregaLog' AND S.NAME = 'dbo')
CREATE procedure [dbo].[STP_SIU_CarregaLog]
	@Grupo char(3) -- ETL
	,@IdPacote varchar(50) = ''
	,@NomePacote varchar(70) = ''
	,@IdTarefa varchar(50) = ''
	,@NomeTarefa varchar(70) = ''
	,@Descricao varchar(200) = ''
	,@QtdLinhasInseridas bigint = 0
	,@QtdLinhasAtualizadas bigint = 0
	,@TipoExecucao char(1) --I-iniciado / F-finalizado / E-erro
as
begin
	SET NOCOUNT ON;
	
	declare @IdCarga bigint = 0
	declare @IdCargaDetalhe bigint = 0
		    
	declare @IdPacote_c varchar(50)
	declare @IdTarefa_c varchar(50)
	declare @CodRef bigint
	declare @DataAtual datetime = GETDATE()
	
	
	-- FORMATA VALORES DAS VARIAVEIS INFORMADAS
	set @IdPacote_c = REPLACE(REPLACE(@IdPacote, '{', ''), '}', '')
	set @IdTarefa_c = REPLACE(REPLACE(@IdTarefa, '{', ''), '}', '')
	set @CodRef  = CONVERT(VARCHAR(8), @DataAtual, 112) + REPLACE(CONVERT(VARCHAR(5), @DataAtual, 114), ':', '')
			
	-- BUSCA O MAIOR ID RELACIONADO AO PACOTE INFORMADO (UTILIZADO APENAS NA INSERÇÃO E ATUALIZAÇÃO DO DETALHE DO LOG CARGA).
	select @IdCarga = MAX(IdCarga)
	from DBO.TB_Carga cg
	where cg.IdPacote = @IdPacote_c
	
	-- BUSCA O MAIOR ID RELACIONADO A TAREFA INFORMADA PARA O PACOTE EM EXECUÇÃO (
	select 
		@IdCargaDetalhe = MAX(CD1.IdCargaDetalhe)
	from [DBO].[TB_CargaDetalhe] CD1
	where CD1.IdTarefa = @IdTarefa_c
	and CD1.IdCarga = @IdCarga	
		    
	If (@TipoExecucao = 'I')
	begin
		-- VERIFICA SE AS INFORMAÇÕES SÃO NO NIVEL DE PACOTE OU TAREFA
		IF (@IdPacote = @IdTarefa) --PACOTE
		BEGIN 
			INSERT INTO [DBO].[TB_Carga]
			(
			   [AbrGrupo],[CodRef],[IdPacote],[NomPacote],[DthInicio],[TpoExecucao],[DthFim]
			)
			VALUES
			(
				@Grupo,@CodRef,@IdPacote_c,@NomePacote,@DataAtual,@TipoExecucao,null
			)
		END
		ELSE --TAREFA
		BEGIN
			INSERT INTO [DBO].[TB_CargaDetalhe]
			(
				[IdCarga],[IdTarefa],[NomTarefa],[Descricao],[QtdLinhasInseridas],[QtdLinhasAtualizadas],[TpoExecucao],[DthInicio],[DthFim]
			)
			VALUES
			(
			   @IdCarga,@IdTarefa_c,@NomeTarefa,@Descricao,@QtdLinhasInseridas,@QtdLinhasAtualizadas,@TipoExecucao,@DataAtual,null
			)
		END
	end
	else
	begin
		-- VERIFICA SE AS INFORMAÇÕES SÃO NO NIVEL DE PACOTE OU TAREFA
		IF (@IdPacote = @IdTarefa) --PACOTE
		BEGIN 
			UPDATE [DBO].[TB_Carga]
			   SET 
				  [TpoExecucao] = case when [TpoExecucao] = 'E' then [TpoExecucao] else @TipoExecucao end
				  ,[DthFim] = @DataAtual
			 WHERE IdCarga = (
							select MAX(IdCarga) from DBO.TB_Carga cg where cg.IdPacote = @IdPacote_c
							)
		END
		ELSE --TAREFA
		BEGIN
			UPDATE [DBO].[TB_CargaDetalhe]
				SET 
				  [Descricao] = case when isnull(@Descricao, '') != '' then @Descricao else [Descricao] end
				  ,[QtdLinhasInseridas] = case when @QtdLinhasInseridas > 0 then @QtdLinhasInseridas else [QtdLinhasInseridas] end
				  ,[QtdLinhasAtualizadas] = case when @QtdLinhasAtualizadas > 0 then @QtdLinhasAtualizadas else [QtdLinhasAtualizadas] end
				  ,[TpoExecucao] = case when [TpoExecucao] = 'E' then [TpoExecucao] else @TipoExecucao end
				  ,[DthFim] = @DataAtual
			WHERE IdCargaDetalhe = @IdCargaDetalhe
		END
	end

end


GO


/****** Object:  StoredProcedure [dbo].[STP_SIU_CarregaLogErro]    Script Date: 23/12/2021 22:57:49 ******/
IF EXISTS (SELECT 1 FROM SYS.procedures T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'STP_SIU_CarregaLogErro' AND S.NAME = 'dbo')
DROP PROCEDURE [dbo].[STP_SIU_CarregaLogErro]
GO

/****** Object:  StoredProcedure [dbo].[STP_SIU_CarregaLogErro]    Script Date: 23/12/2021 22:57:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



IF NOT EXISTS (SELECT 1 FROM SYS.procedures T, sys.schemas S WHERE T.SCHEMA_ID = S.SCHEMA_ID AND T.NAME = 'STP_SIU_CarregaLogErro' AND S.NAME = 'dbo')
create procedure [dbo].[STP_SIU_CarregaLogErro]
	@IdPacote varchar(50)
	,@IdTarefa varchar(50)
	,@NomeTarefa varchar(60)
	,@NumeroErro int = 0
	,@DescricaoErro varchar(8000) = ''
	,@LinhaRegistro varchar(max) = ''
as
begin
	SET NOCOUNT ON;
	
	declare @IdCarga bigint = 0
	declare @IdCargaDetalhe bigint = 0
	declare @DataHoraErro datetime = getdate()
	
	declare @IdPacote_c varchar(50)
	declare @IdTarefa_c varchar(50)
	
	-- FORMATA VALORES DAS VARIAVEIS INFORMADAS
	set @IdPacote_c = REPLACE(REPLACE(@IdPacote, '{', ''), '}', '')
	set @IdTarefa_c = REPLACE(REPLACE(@IdTarefa, '{', ''), '}', '')
	
	
	select @IdCarga = MAX(IdCarga)
	from dbo.TB_Carga cg
	where cg.IdPacote = @IdPacote_c
	
	select 
		@IdCargaDetalhe = MAX(CD1.IdCargaDetalhe)
	from [dbo].[TB_CargaDetalhe] CD1
	where CD1.IdTarefa = @IdTarefa_c
	and CD1.IdCarga = @IdCarga
		
	--Insere o erro na tabela de log de erros
	INSERT INTO [SGBLOG].[dbo].[TB_CargaErro]
           ([IdCargaDetalhe]
           ,[NomTarefa]
           ,[NumErro]
           ,[DscErro]
           ,[LinhaRegistro]
           ,[DthErro])
     VALUES
           (@IdCargaDetalhe
           ,@NomeTarefa
           ,@NumeroErro
           ,@DescricaoErro
           ,@LinhaRegistro
           ,@DataHoraErro)
          
    --Atualiza a situação da etapa que ocorreu o erro para "E" na tabela de carga
    update a set 
		a.TpoExecucao = 'E'
		,a.DthFim = @DataHoraErro
	from dbo.TB_CargaDetalhe a
	where a.IdCargaDetalhe = @IdCargaDetalhe     
               
    --Atualiza a situação da etapa que ocorreu o erro para "E" na tabela de carga detalhe
    update a set 
		a.TpoExecucao = 'E'
		,a.DthFim = @DataHoraErro
	from dbo.TB_Carga a
	where a.IdCarga = @IdCarga

end


GO


