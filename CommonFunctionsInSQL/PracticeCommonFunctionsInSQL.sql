USE quanlysinhvien;

SELECT * FROM `subject` WHERE Credit = (SELECT MAX(Credit) FROM `subject`);

#SELECT * FROM `subject` WHERE Credit = (SELECT MAX(Credit) FROM `subject`);
SELECT sb.SubId, sb.SubName, sb.Credit, sb.`Status` FROM `mark` AS mr 
INNER JOIN `subject` AS sb ON sb.SubId = mr.SubId WHERE mr.Mark = (SELECT MAX(`mark`.Mark) FROM `mark`);

SELECT * FROM mark;

SELECT * FROM student;

SELECT st.StudentId, st.StudentName, st.Address, st.Phone, st.`Status`, st.ClassId,  AVG(mark) AS `Medium Mark` 
FROM student AS st INNER JOIN `mark` as mr ON st.StudentId = mr.StudentId GROUP BY st.StudentId;