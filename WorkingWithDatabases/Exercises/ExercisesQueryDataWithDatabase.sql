USE `quanlysinhvien`;

SELECT * FROM `student` WHERE StudentName LIKE 'h%';

SELECT * FROM `class` WHERE  MONTH(StartDate) = 12;

SELECT * FROM `subject` WHERE Credit BETWEEN 3 AND 5;

USE `quanlysinhvien`;
UPDATE `student` SET ClassId = 2 WHERE StudentName = 'Hung';

#Chua sap xep theo tên tăng dần
SELECT S.StudentName, Sub.SubName, M.Mark
FROM (Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId) 
ORDER BY Mark DESC; 
