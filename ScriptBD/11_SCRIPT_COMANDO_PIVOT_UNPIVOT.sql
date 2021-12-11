-------------------------------------------------------------------------
-- COMANDO UNPIVOT
-------------------------------------------------------------------------


SELECT  
[NOME_LOJA]
,[MES]
,[VALOR]
 
FROM
(
 
SELECT DISTINCT 
 
[NOME_LOJA]
, [JANEIRO]
, [FEVEREIRO]
, [MARCO]
, [ABRIL]
, [MAIO]
, [JUNHO]
, [JULHO]
, [AGOSTO]
, [SETEMBRO]
, [OUTUBRO]
, [NOVEMBRO]
, [DEZEMBRO]
 
FROM [dbo].[VENDAS_MES]
 
) src
 
UNPIVOT
(
[MES] FOR VALOR IN ([JANEIRO]
, [FEVEREIRO]
, [MARCO]
, [ABRIL]
, [MAIO]
, [JUNHO]
, [JULHO]
, [AGOSTO]
, [SETEMBRO]
, [OUTUBRO]
, [NOVEMBRO]
, [DEZEMBRO])
) upvt
				

-------------------------------------------------------------------------
-- COMANDO PIVOT
-------------------------------------------------------------------------


SELECT  
[NOME_LOJA]
, [JANEIRO]
, [FEVEREIRO]
, [MARÇO]
, [ABRIL]
, [MAIO]
, [JUNHO]
, [JULHO]
, [AGOSTO]
, [SETEMBRO]
, [OUTUBRO]
, [NOVEMBRO]
, [DEZEMBRO]
 
FROM
(
 
SELECT DISTINCT 
 
[NOME_LOJA]
,[MES]
,[VALOR]
 
FROM [dbo].[VENDAS]
 
) src
 
PIVOT
(
SUM([VALOR]) FOR [MES] IN ([JANEIRO]
, [FEVEREIRO]
, [MARÇO]
, [ABRIL]
, [MAIO]
, [JUNHO]
, [JULHO]
, [AGOSTO]
, [SETEMBRO]
, [OUTUBRO]
, [NOVEMBRO]
, [DEZEMBRO])
) pvt
				
ORDER BY [NOME_LOJA]