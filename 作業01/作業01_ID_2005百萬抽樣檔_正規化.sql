--��CONVERT�@���A�ഫ
--SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
--FROM [dbo].[UID2003]
--GROUP BY AGE, ID_SEX
--ORDER BY CONVERT(int, AGE), ID_SEX

--��CAST�@���A�ഫ
--SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
--FROM [dbo].[UID2003]
--GROUP BY AGE, ID_SEX
--ORDER BY CAST(AGE AS int), ID_SEX


--�ϥΰj��d�ߨC�Ӫ�
--�w�q�j��Ѽ�
DECLARE  
@TotalNum INT, --���榸��
@Num INT       --�ثe����

--�]�w�j��Ѽ�
SET @TotalNum = 2013 --���榸��
SET @Num =2002        --�ثe���� 

--����WHILE�j��
WHILE @Num <= @TotalNum  --��ثe���Ƥp�󵥩���榸��
BEGIN
	
	EXEC('
	SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS ['+@Num+'_COUNTS]
	FROM [dbo].[UID'+@Num+']
	GROUP BY AGE, ID_SEX
	ORDER BY CAST(AGE AS int), ID_SEX
	')

    --�]�w�ثe����+1
    SET @Num = @Num + 1
END

