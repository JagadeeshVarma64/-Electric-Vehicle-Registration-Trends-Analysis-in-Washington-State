SELECT * FROM FinalProject.finalds;



SELECT County, Date AS Registration_Date, SUM(`Electric_Vehicle_(EV)_Total`) AS Total_EV_Registrations
FROM finalproject.finalds
GROUP BY County, Registration_Date
ORDER BY County, Registration_Date
LIMIT 0, 1000;


SELECT County, Date AS Registration_Date, SUM(`Percent Electric Vehicles`) AS EV_Percent
FROM finalproject.finalds
GROUP BY County, Registration_Date
ORDER BY County, Registration_Date
LIMIT 0, 1000;