-- Create views needed for both answering the queries and speed up the execution.

CREATE VIEW DataWithSex AS
SELECT 
    sr.Location AS Country,
    sr.Period AS period,
    sr.Dim1 AS gender,
    sr.`First Tooltip` AS SuicideRate,
    ta.`First Tooltip` AS tobaccoAge15,
    u5m.`First Tooltip` AS under5MortalityRate
FROM 
    SuicideRates AS sr
INNER JOIN 
    TobaccoAged15 AS ta ON sr.Location = ta.Location AND sr.Period = ta.Period AND sr.Dim1 = ta.Dim1
INNER JOIN 
    Under5MortalityRate AS u5m ON sr.Location = u5m.Location AND sr.Period = u5m.Period AND sr.Dim1 = u5m.Dim1;



CREATE VIEW DataWithLoco AS
SELECT 
    bsp.Location AS Country,
    bsp.Period AS period,
    bsp.Dim1 AS location,
    bsp.`First Tooltip` AS atLeastBasicSanitationServices,
    bhw.`First Tooltip` AS basicHandWashing
FROM 
    BasicSanitationPopulation AS bsp
INNER JOIN 
    BasicHandWashing AS bhw ON bsp.Location = bhw.Location AND bsp.Period = bhw.Period AND bsp.Dim1 = bhw.Dim1;



CREATE VIEW comprehensive_health_view AS
SELECT 
    abr.Location AS Country,
    abr.Period AS period,
    abr.`First Tooltip` AS adolescentBirthRate,
    mi.`First Tooltip` AS incidenceOfMalaria,
    ti.`First Tooltip` AS incidenceOfTuberculosis,
    md.`First Tooltip` AS medicalDoctors,
    nm.`First Tooltip` AS nursingAndMidwife
FROM 
    AdolescentBirthRate AS abr
LEFT OUTER JOIN 
    MalariaIncidence AS mi ON abr.Location = mi.Location AND abr.Period = mi.Period
LEFT OUTER JOIN 
    TuberculosisIncidence AS ti ON abr.Location = ti.Location AND abr.Period = ti.Period
LEFT OUTER JOIN 
    MedicalDoctors AS md ON abr.Location = md.Location AND abr.Period = md.Period
LEFT OUTER JOIN 
    NursingMidwife AS nm ON abr.Location = nm.Location AND abr.Period = nm.Period;



CREATE VIEW Nursing_Yearly_Avg AS
SELECT 
    Location, Indicator,
    AVG(`First Tooltip`) AS AvgValue
FROM NursingMidwife
GROUP BY Location;


CREATE VIEW MedicalDoctors_Yearly_Avg AS
SELECT 
    Location, Indicator
    AVG(`First Tooltip`) AS AvgValue
FROM MedicalDoctors
GROUP BY Location;


CREATE VIEW BasicHandWashing_Yearly_Avg AS
SELECT 
    Location, Indicator,  Dim1,
    AVG(`First Tooltip`) AS AvgValue
FROM BasicHandWashing
GROUP BY Location, Dim1;


CREATE VIEW BasicSanitationPopulation_Yearly_Avg AS
SELECT 
    Location, Indicator, Dim1,
    AVG(`First Tooltip`) AS AvgValue
FROM  BasicSanitationPopulation
GROUP BY Location, Dim1;


DROP VIEW IF EXISTS Populations_Calculation;
CREATE VIEW Populations_Calculation AS
SELECT 
    cd.Country as Country,
    (cd.`Density(P/Km2)` * cd.`Land Area(Km2)`) as Total_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * md.AvgValue / 10000) as Doctor_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * ns.AvgValue / 10000) as Nursing_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * bhw1.AvgValue / 100) as Washing_rural_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * bhw2.AvgValue / 100) as Washing_urban_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * bhw3.AvgValue / 100) as Washing_total_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * bsp1.AvgValue / 100) as Sanitary_rural_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * bsp2.AvgValue / 100) as Sanitary_urban_Population,
    FLOOR(cd.`Density(P/Km2)` * cd.`Land Area(Km2)` * bsp3.AvgValue / 100) as Sanitary_total_Population
FROM 
    CountryDevelopment as cd
LEFT JOIN 
    MedicalDoctors_Yearly_Avg as md ON cd.Country = md.Location
LEFT JOIN 
    Nursing_Yearly_Avg as ns ON cd.Country = ns.Location
LEFT JOIN 
    BasicHandWashing_Yearly_Avg as bhw1 ON cd.Country = bhw1.Location AND bhw1.Dim1 = 'Rural'
LEFT JOIN 
    BasicHandWashing_Yearly_Avg as bhw2 ON cd.Country = bhw2.Location AND bhw2.Dim1 = 'Urban'
LEFT JOIN 
    BasicHandWashing_Yearly_Avg as bhw3 ON cd.Country = bhw3.Location AND bhw3.Dim1 = 'Total'
LEFT JOIN 
    BasicSanitationPopulation_Yearly_Avg as bsp1 ON cd.Country = bsp1.Location AND bsp1.Dim1 = 'Rural'
LEFT JOIN 
    BasicSanitationPopulation_Yearly_Avg as bsp2 ON cd.Country = bsp2.Location AND bsp2.Dim1 = 'Urban'
LEFT JOIN 
    BasicSanitationPopulation_Yearly_Avg as bsp3 ON cd.Country = bsp3.Location AND bsp3.Dim1 = 'Total';


CREATE VIEW AdolescenceTable AS
SELECT Country
FROM CountryDevelopment
ORDER BY `Gross primary education enrollment (%)` DESC
LIMIT 10;

DROP VIEW IF EXISTS TaxTable;
CREATE VIEW TaxTable AS
SELECT Country
FROM CountryDevelopment
ORDER BY `Tax revenue (%)` DESC
LIMIT 10;

CREATE VIEW GenderSuicide AS
SELECT 
    Location, Indicator, Period,
    AVG(`First Tooltip`) AS AvgValue
FROM SuicideRates
WHERE Period BETWEEN 2010 AND 2020
GROUP BY Location, Period;


CREATE VIEW SuicideRates_Avg AS
SELECT 
    Location, Indicator,
    AVG(`First Tooltip`) AS AvgValue
FROM SuicideRates
GROUP BY Location, Period, Dim1;


CREATE VIEW GenderTobacco AS
SELECT 
    Location, Indicator, Dim1,
    AVG(`First Tooltip`) AS AvgValue
FROM TobaccoAged15
GROUP BY Location;

CREATE VIEW TuberculosisTable AS
SELECT 
    Location, Indicator,
    AVG(`First Tooltip`) AS AvgValue
FROM TuberculosisIncidence
GROUP BY Location;
