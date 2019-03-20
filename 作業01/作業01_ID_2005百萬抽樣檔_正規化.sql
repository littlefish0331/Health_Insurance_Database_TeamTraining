--ノCONVERT篈锣传
--SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
--FROM [dbo].[UID2003]
--GROUP BY AGE, ID_SEX
--ORDER BY CONVERT(int, AGE), ID_SEX

--ノCAST篈锣传
--SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
--FROM [dbo].[UID2003]
--GROUP BY AGE, ID_SEX
--ORDER BY CAST(AGE AS int), ID_SEX


--ㄏノ癹伴琩高–
--﹚竡癹伴把计
DECLARE  
@TotalNum INT, --磅︽Ω计
@Num INT       --ヘ玡Ω计

--砞﹚癹伴把计
SET @TotalNum = 2013 --磅︽Ω计
SET @Num =2002        --ヘ玡Ω计 

--磅︽WHILE癹伴
WHILE @Num <= @TotalNum  --讽ヘ玡Ω计单磅︽Ω计
BEGIN
	
	EXEC('
	SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS ['+@Num+'_COUNTS]
	FROM [dbo].[UID'+@Num+']
	GROUP BY AGE, ID_SEX
	ORDER BY CAST(AGE AS int), ID_SEX
	')

    --砞﹚ヘ玡Ω计+1
    SET @Num = @Num + 1
END

