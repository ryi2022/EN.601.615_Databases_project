-- Creates stored procedures for getting the answers for the queries.
DELIMITER //
DROP PROCEDURE IF EXISTS ShowPopulations //
CREATE PROCEDURE ShowPopulations(IN country_input VARCHAR(512))
BEGIN
    DECLARE existInDB INT;
    SET existInDB = (SELECT EXISTS( 
        SELECT Country
        FROM Populations_Calculation
        WHERE Populations_Calculation.Country = country_input));
    IF existInDB THEN
        SELECT * FROM Populations_Calculation
        WHERE Country = country_input;
    ELSE
        SELECT "Country does not exist in database." AS Message;
    END IF;
END //



DELIMITER //
DROP PROCEDURE IF EXISTS Get1 //
CREATE PROCEDURE Get1()
BEGIN
    SELECT CD.Country
    FROM CountryDevelopment CD
    JOIN DataWithLoco DL ON CD.Country = DL.Country
    WHERE `Urban_population` / `Population` > 0.8
    AND atLeastBasicSanitationServices < (SELECT AVG(`First Tooltip`) FROM BasicSanitationPopulation)
    GROUP BY CD.Country;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS Get2 //
CREATE PROCEDURE Get2()
BEGIN
    SELECT CD.Country, CHV.period, CHV.adolescentBirthRate
    FROM CountryDevelopment CD
    JOIN comprehensive_health_view CHV ON CD.Country = CHV.Country
    WHERE CHV.period BETWEEN 2010 AND 2019
    AND CD.Country IN (SELECT Country FROM AdolescenceTable)
    ORDER BY CD.Country, CHV.period;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS Get3 //
CREATE PROCEDURE Get3()
BEGIN
    SELECT DISTINCT TaxTable.Country
    FROM TaxTable
    JOIN SuicideRates SR ON SR.Location = TaxTable.Country
    WHERE SR.Dim1 = 'Female' AND SR.`First Tooltip` > (
        SELECT `First Tooltip`
        FROM SuicideRates
        WHERE Dim1 = 'Male' AND Location = SR.Location AND Period = SR.Period
    );
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS Get4 //
CREATE PROCEDURE Get4()
BEGIN
    SELECT DISTINCT CD.Country, CD.`Birth Rate`, CD.`Urban_population` / CD.`Population` AS UrbanizationRate, CD.`Out of pocket health expenditure`
    FROM CountryDevelopment CD
    JOIN TobaccoAged15 TA ON CD.Country = TA.Location
    WHERE TA.Dim1 = 'Female' AND TA.`First Tooltip` > (
        SELECT `First Tooltip`
        FROM TobaccoAged15
        WHERE Dim1 = 'Male' AND Location = TA.Location AND Period = TA.Period
    );
END //
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS Get5 //
CREATE PROCEDURE Get5()
BEGIN
    SELECT DL.Country
    FROM DataWithLoco DL
    JOIN comprehensive_health_view CHV ON DL.Country = CHV.Country
    WHERE DL.period = 2017
    AND basicHandWashing < (SELECT AVG(basicHandWashing) FROM DataWithLoco WHERE period = 2017)
    AND incidenceOfMalaria  < (SELECT AVG(incidenceOfMalaria) FROM comprehensive_health_view WHERE period = 2017)
    GROUP BY DL.Country;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS Get6 //
CREATE PROCEDURE Get6()
BEGIN
    SELECT DISTINCT GS.Location, GS.Period, GS.AvgValue
    FROM GenderSuicide GS
    JOIN CountryHappiness CH ON GS.Location = CH.`Country name`
    WHERE CH.`Log GDP per capita` < (SELECT AVG(`Log GDP per capita`) FROM CountryHappiness)
    AND CH.`Life Ladder` > (SELECT AVG(`Life Ladder`) FROM CountryHappiness)
    ORDER BY GS.Location, GS.Period;
END //
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS Get7 //
CREATE PROCEDURE Get7()
BEGIN
    SELECT CD.Country, CD.`GDP(*10^9)`, CD.`Minimum wage`, CD.`Total tax rate`
    FROM CountryDevelopment CD
    JOIN CountryHappiness CH ON CD.Country = CH.`Country name`
    JOIN SuicideRates_Avg SR ON CD.Country = SR.Location
    WHERE CH.`Perceptions of corruption` > 0.5
    ORDER BY SR.AvgValue DESC
    LIMIT 1;
END //
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS Get8 //
CREATE PROCEDURE Get8()
BEGIN
    SELECT NS.Location, CD.`Infant mortality`
    FROM Nursing_Yearly_Avg NS
    JOIN CountryDevelopment CD ON CD.Country = NS.Location
    ORDER BY NS.AvgValue ASC
    LIMIT 5;
END //
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS Get9 //
CREATE PROCEDURE Get9()
BEGIN
    SELECT TT.Location, CD.`Co2-Emissions`, CD.`Gasoline Price`
    FROM TuberculosisTable TT
    JOIN CountryDevelopment CD ON TT.Location = CD.Country
    ORDER BY TT.AvgValue DESC
    LIMIT 5;
END //
DELIMITER ;



DELIMITER //
DROP PROCEDURE IF EXISTS Get10 //
CREATE PROCEDURE Get10()
BEGIN
    SELECT CD.Country, Avg(CH.`Life Ladder`) AS Happiness, NS.AvgValue As Nursing
    FROM CountryDevelopment CD
    JOIN Nursing_Yearly_Avg NS ON CD.Country = NS.Location
    JOIN CountryHappiness CH ON CD.Country = CH.`Country name`
    WHERE CD.`Population: Labor force participation (%)` > 0.7
    AND CD.`Unemployment rate` < 0.05
    GROUP BY CD.Country, NS.AvgValue;
END //
DELIMITER ;



DELIMITER ;