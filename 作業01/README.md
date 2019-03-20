# 健保資料庫作業01說明
資料庫 = ID_2005百萬抽樣檔_正規化
資料表 = UID2005, ..., UID2013

[TOC]

# 步驟流程
1. 用SQL計算 [AGE, SEX][人數]
2. 用R/Python/EXCEL整理數據 
3. 視覺化ggplot, plotly/shiny

---
# 範例程式碼ver01
最簡單的範例就是下面的程式碼，資料表的部分再做替換就好
記得把左上角的資料庫位置，選到ID_2005百萬抽樣檔_正規化
```{SQL}
SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
FROM [dbo].[UID2002]
GROUP BY AGE, ID_SEX
```

---
# 可以改進的地方
- 一個一個資料表很麻煩，可不可以寫迴圈
- 查詢出來之後，再額外用程式(EXCEL/R/Python)做排序很麻煩，可不可以在SQL查詢的時候結果就先排好

## 新增迴圈
```{SQL}
--使用迴圈查詢每個表
--定義迴圈參數
DECLARE  
@TotalNum INT, --執行次數
@Num INT       --目前次數

--設定迴圈參數
SET @TotalNum = 2005 --執行次數
SET @Num =2002        --目前次數 

--執行WHILE迴圈
WHILE @Num <= @TotalNum  --當目前次數小於等於執行次數
BEGIN
	
	EXEC('
	SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS ['+@Num+'_COUNTS]
	FROM [dbo].[UID'+@Num+']
	GROUP BY AGE, ID_SEX
	ORDER BY CAST(AGE AS int), ID_SEX
	')

    --設定目前次數+1
    SET @Num = @Num + 1
END
```

## AGE, ID_SEX排序
- 注意到因為原本的AGE欄位型態為 nvarchar，所以排序前要先做型態轉換
> 不知道當初是不是因為AGE有缺失值(AGE從BIRTHDATE計算出來，所以可能BIRTHDATE有缺失?)，所以才選型態為nvarchar

```{SQL}
--利用CAST型態轉換
SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
FROM [dbo].[UID2002]
GROUP BY AGE, ID_SEX
ORDER BY CAST(AGE AS int), ID_SEX
```

```{SQL}
--利用CONVERT型態轉換
SELECT AGE, ID_SEX, COUNT(DISTINCT ID) AS COUNTS
FROM [dbo].[UID2003]
GROUP BY AGE, ID_SEX
ORDER BY CONVERT(int, AGE), ID_SEX
```


---
# 參考資料
- [型態轉換01](http://pclevinblog.pixnet.net/blog/post/314563516-%5Bmysql%5D%E6%8A%8A%E5%AD%97%E4%B8%B2%E8%BD%89%E6%95%B8%E5%AD%97%E6%8E%92%E5%BA%8F%EF%BC%8C%E4%BD%BF%E7%94%A8cast%28%29%E5%87%BD%E5%BC%8F)
- [型態轉換02](http://fecbob.pixnet.net/blog/post/38993453-sql-server-2012-%E8%BD%89%E6%8F%9B%E5%87%BD%E6%95%B8%E7%9A%84%E6%AF%94%E8%BC%83%28cast%E3%80%81convert-%E5%92%8C-par)
- [迴圈教學01](https://dotblogs.com.tw/berrynote/2016/08/06/120741)
- [迴圈教學02](http://goodlucky.pixnet.net/blog/post/47907288-%5Bms-sql%5D-while-%E8%BF%B4%E5%9C%88)
- [更深入的迴圈講解](https://ithelp.ithome.com.tw/articles/10203998)

<font color = "red">**拜託要看學長姊的精華: Google雲端/文件資料庫/2.教學文件/SQL相關**</font>


---
# 附註
我還不會把查詢出來的結果
順便新增一欄YEAR，並填入該年數值
如果可以這樣的話，之後再程式處理階段會方便許多
