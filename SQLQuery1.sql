USE MAR15;

SELECT * FROM digital_marketing;

/*Average Rates*/
SELECT 
round(avg(PagesPerVisit), 0) as AveragePagesPerVisit, 
round(avg(TimeOnSite), 4) as AverageTimeOnSite, 
avg(WebsiteVisits) as AverageWebsiteVisits
FROM digital_marketing;


/*Conversion rate by campaign channel*/
SELECT
CampaignChannel, ROUND(SUM(CAST(Conversion AS INT))*100 / (SELECT SUM( CAST(Conversion AS INT) ) AS TOTAL_CONVERSION FROM digital_marketing), 4)
as AverageConversionRate
FROM digital_marketing 
GROUP BY CampaignChannel;

/*SELECT CampaignType, SUM(CONVERSION)*100.00 / 
(SELECT SUM(CONVERSION) AS TOTALCONV FROM MARKETING) AS CONVERSIONRATE
FROM digital_marketing
GROUP BY CampaignType
ORDER BY CONVERSIONRATE DESC;*/

SELECT
CampaignType, SUM(CAST(Conversion AS INT))*100 / (SELECT SUM( CAST(Conversion AS INT) ) AS TOTAL_CONVERSION FROM digital_marketing)
as AverageConversionRate
FROM digital_marketing 
GROUP BY CampaignType;

/*Altering table to agegroup*/
ALTER TABLE digital_marketing
DROP COLUMN AgeGroup;

ALTER TABLE digital_marketing
ADD AgeGroup varchar(20);

SELECT 
CASE
	WHEN AGE>=18 AND AGE<=35 THEN 'YOUNG'
	WHEN AGE>35 AND AGE<=55 THEN 'MIDDLE-AGED'
	WHEN AGE>55 THEN 'SENIOR'
	ELSE 'UNKNOWN'
END AS AgeGroup
FROM digital_marketing;

   /*Updating age group*/
   UPDATE digital_marketing
   SET AgeGroup = 
   CASE
	 WHEN AGE>=18 AND AGE<=35 THEN 'YOUNG'
	 WHEN AGE>35 AND AGE<=55 THEN 'MIDDLE-AGED'
	 WHEN AGE>55 THEN 'SENIOR'
	 ELSE 'UNKNOWN'
   END
   FROM digital_marketing;

   /*Coversion by age group*/
   SELECT AgeGroup, SUM(CAST(Conversion AS INT)) AS Count FROM digital_marketing GROUP BY AgeGroup;

   SELECT
   AgeGroup, Gender, SUM(CAST(Conversion AS INT))*100 / (SELECT SUM( CAST(Conversion AS INT) ) AS TOTAL_CONVERSION FROM digital_marketing)
   as AverageConversionRate
   FROM digital_marketing 
   GROUP BY AgeGroup, Gender;

/*Altering Table Income Group*/
 
 SELECT AVG(Income) AS average_income, MIN(Income) as Min_Income, MAX(Income) as Max_income 
 FROM digital_marketing;

 ALTER TABLE digital_marketing
 ADD IncomeGroup VARCHAR(20);

 UPDATE digital_marketing
 SET IncomeGroup = CASE
	WHEN Income>=0 AND Income<=50000 THEN 'LOW INCOME'
	WHEN Income>50000 AND Income<=100000 THEN 'MIDDLE INCOME'
	WHEN Income>100000 THEN 'HIGH INCOME'
	ELSE 'UNKNOWN'
	END
 FROM digital_marketing;

/*conversion by income group*/
SELECT IncomeGroup, SUM(CAST(Conversion AS INT)) AS Count FROM digital_marketing GROUP BY IncomeGroup;

SELECT
IncomeGroup, Gender, 
SUM(CAST(Conversion AS INT))*100 / (SELECT SUM( CAST(Conversion AS INT) ) AS TOTAL_CONVERSION FROM digital_marketing)
as AverageConversionRate
FROM digital_marketing 
GROUP BY IncomeGroup, Gender;