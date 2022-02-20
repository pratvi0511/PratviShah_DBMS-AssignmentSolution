#Creating the database
CREATE DATABASE TravelOnTheGo;

#Using the database
USE TravelOnTheGo;

#Passenger Table
CREATE TABLE IF NOT EXISTS `Passenger`(
 `Passenger_name` VARCHAR(20) NULL DEFAULT NULL,
 `Category` VARCHAR(30),
 `Gender` CHAR,
 `Boarding_City` VARCHAR(30),
 `Destination_City` VARCHAR(30),
 `Distance` INT NOT NULL,
 `Bus_Type` VARCHAR(30));
  
INSERT INTO `Passenger` VALUES("Sejal","AC",'F',"Bengaluru","Chennai",350,"Sleeper");
INSERT INTO `Passenger` VALUES("Anmol","Non-AC",'M',"Mumbai","Hyderabad",700,"Sitting");
INSERT INTO `Passenger` VALUES("Pallavi","AC",'F',"Panaji","Bengaluru",600,"Sleeper");
INSERT INTO `Passenger` VALUES("Khusboo","AC",'F',"Chennai","Mumbai",1500,"Sleeper");
INSERT INTO `Passenger` VALUES("Udit","Non-AC",'M',"Trivandrum","panaji",1000,"Sleeper");
INSERT INTO `Passenger` VALUES("Ankur","AC",'M',"Nagpur","Hyderabad",500,"Sitting");
INSERT INTO `Passenger` VALUES("Hemant","Non-AC",'M',"panaji","Mumbai",700,"Sleeper");
INSERT INTO `Passenger` VALUES("Manish","Non-AC",'M',"Hyderabad","Bengaluru",500,"Sitting");
INSERT INTO `Passenger` VALUES("Piyush","AC",'M',"Pune","Nagpur",700,"Sitting");
#SELECT * FROM Passenger;

#Price Table
CREATE TABLE IF NOT EXISTS `Price`(
`Bus_Type` VARCHAR(20),
`Distance` INT NOT NULL,
`Price` INT NOT NULL);

INSERT INTO `Price` VALUES("Sleeper",350,770);
INSERT INTO `Price` VALUES("Sleeper",500,1100);
INSERT INTO `Price` VALUES("Sleeper",600,1320);
INSERT INTO `Price` VALUES("Sleeper",700,1540);
INSERT INTO `Price` VALUES("Sleeper",1000,2200);
INSERT INTO `Price` VALUES("Sleeper",1200,2640);
INSERT INTO `Price` VALUES("Sleeper",1500,2700);
INSERT INTO `Price` VALUES("Sitting",500,620);
INSERT INTO `Price` VALUES("Sitting",600,744);
INSERT INTO `Price` VALUES("Sitting",700,868);
INSERT INTO `Price` VALUES("Sitting",1000,1240);
INSERT INTO `Price` VALUES("Sitting",1200,1488);
INSERT INTO `Price` VALUES("Sitting",1500,1860);
#SELECT * FROM `Price`;

#Query 3: How many females and how many male passengers travelled for a minimum distance of 600 KMs?
SELECT `Passenger`.Gender, COUNT(`Passenger`.Gender) AS Quantity
FROM `Passenger`,`Price`
WHERE `Passenger`.Distance >= 600
AND  `Passenger`.Distance = `Price`.Distance
GROUP BY Gender;

#Query 4: Find the minimum ticket price for Sleeper Bus.
SELECT Bus_Type, MIN(Price)
FROM `Price`
WHERE Bus_Type = "Sleeper";

#Query 5:  Select passenger names whose names start with character 'S'.
SELECT Passenger_name
FROM `Passenger`
WHERE Passenger_name LIKE 'S%';

#Query 6: Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output.
SELECT `Passenger`.Passenger_name, `Passenger`.Boarding_City, `Passenger`.Destination_City, `Price`.Bus_Type, `Price`.Price
FROM `Passenger`, `Price`
WHERE `Passenger`.Bus_Type = `Price`.Bus_Type
AND `Passenger`.Distance = `Price`.Distance;

#Query 7: What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KMs? 
SELECT `Passenger`.Passenger_name, `Price`.Price
FROM `Passenger`, `Price`
WHERE `Passenger`.Bus_Type = `Price`.Bus_Type
AND `Passenger`.Distance = `Price`.Distance
AND `Passenger`.Bus_Type = "Sitting"
AND `Passenger`.Distance = 1000;

#Query 8: What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT `Passenger`.Passenger_name, `Passenger`.Boarding_City, `Passenger`.Destination_City, `Price`.Bus_Type, `Price`.Price
FROM `Passenger`, `Price`
WHERE `Passenger`.Passenger_name = "Pallavi"
AND `Passenger`.Distance = `Price`.Distance;

#Query 9: List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
SELECT DISTINCT Distance
FROM `Passenger`
ORDER BY Distance DESC;

#Query 10: Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables.
SELECT Passenger_name, (Distance * 100.0) / (SELECT SUM(Distance) FROM `Passenger`) AS Percentage
FROM `Passenger`;

#Query 11: Display the distance, price in three categories in table Price
#a) Expensive if the cost is more than 1000
#b) Average Cost if the cost is less than 1000 and greater than 500
#c) Cheap otherwise
SELECT Distance, Price,
 CASE
   WHEN Price > 1000 THEN 'Expensive'
   WHEN Price > 500  AND Price < 1000 THEN 'Average Cost'
   ELSE 'Cheap'
 END AS Description 
FROM `Price`;