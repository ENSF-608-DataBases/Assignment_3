USE Competition;
#Question 1
SELECT C.FName AS Student_First_Name , C.LName AS Student_Last_Name, S.Name AS Studio_Name
FROM competitor AS C, teacher AS T, studio AS S
WHERE T.StudioName = S.Name AND C.TeacherID=T.TeacherID;

#Question 2
SELECT S.Name,COUNT(*)
FROM competitor AS C, teacher AS T, studio AS S
WHERE T.StudioName = S.Name AND C.TeacherID=T.TeacherID
GROUP BY S.Name ;

#Question 3
SELECT S.Name,COUNT(*)
FROM teacher AS T, studio AS S
WHERE T.StudioName = S.Name 
GROUP BY S.Name ;

#Question 4
SELECT T.TeacherID,T.LName
FROM teacher AS T, competitor as C
WHERE T.TeacherID=C.TeacherID
GROUP BY T.TeacherID
HAVING COUNT(*)>1;

#Question 5

DROP VIEW if EXISTS GENRE_TABLE ;
CREATE VIEW GENRE_TABLE(CompetitorID,MusicID,Composer,Title,Genre)
AS (SELECT P.CompetitorID,C.MusicID,C.Composer,C.Title,C.Genre
	FROM Performance AS P,Composition AS C
    WHERE P.MusicID=C.MusicID
   );
    
SELECT  C.FName,C.LName,G.Title
FROM competitor AS C, GENRE_TABLE AS G
WHERE C.CompetitorID=G.CompetitorID AND G.Genre='Romantic';

#Question 6
SELECT C.MusicID,C.Composer,C.Genre,G.CompetitorID AS PerformedBY
FROM composition AS C
LEFT OUTER JOIN GENRE_TABLE AS G ON G.MusicID=C.MusicID;

#Question 7
DROP VIEW IF EXISTS SCORE_ANALYSIS;
CREATE VIEW SCORE_ANALYSIS (FName,LName,Age,Score) AS
(SELECT C.FName,C.LName,C.Age, P.Score 
FROM Competitor AS C , Performance AS P
WHERE C.CompetitorID=P.CompetitorID);

#Question 8
SELECT * FROM SCORE_ANALYSIS
ORDER BY Score desc;

#Question 9
SELECT MAX(Score),MIN(Score),avg(Score)
FROM SCORE_ANALYSIS;

#Question 10
ALTER table Composition
ADD Copyright varchar(25) default 'SOCAN';
SELECT * FROM Composition;

#Question 11
SELECT * 
FROM Competitor AS c
WHERE NOT EXISTS( SELECT * FROM  Performance As P, Category as cat 
WHERE P.CategoryID=cat.CategoryID AND C.CompetitorID=P.CompetitorID
AND C.Age <= cat.AgeMax AND C.Age >= cat.AgeMin);

#Question 12
ALTER table Competitor ADD CONSTRAINT age_requirement CHECK(Age>=5 AND Age<=18);

#Question 13
UPDATE  Studio SET Name= 'Harmony Studio'
WHERE Name='Harmony Inc.';
# Since there is a constrain on the foreign key in Teacher table then when
# Studio table is updated the foreign key is updated as well. All other tables remain the same since only Teacher
# table is referencing the Studio table

#Question 14
#Performace table references the Composition table MusicID; so we can't delete the parent before the child tables
#So you will get an ERROR if you try to delete tuple from Composition first



#Question 15
# This code will not allow any future updates for any tuple in TEACHER table
# and if an update happens then it will display a message that says:
#Proof of certification must be provided to the main office


