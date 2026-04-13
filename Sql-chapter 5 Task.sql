create database college;
create table student ( std_no int , name varchar(20), course_id int Primary key );
Insert  into student ( std_no,name ,course_id) values (4,"tom",504),(5,"akbar",505),(6,"kiran",506);
CREATE TABLE course (
    course_id INT,
    FOREIGN KEY (course_id)
        REFERENCES college.student (course_id),
    courseName VARCHAR(20)
);
insert into course ( courseName,course_id ) values ("Datascience",501),("Ai",502),("Oi",503);
select * from course;
create table books ( bookid int primary key , bookname varchar(20) );
insert into books ( bookid,bookname) values ( 201,"money"),(202,"mindset"),(203,"habits"),(204,"power"),(205,"people");
select * from books;

# ---------- Task 1 creating my database completed -----------------------

SELECT 
    s.course_id, c.courseName
FROM
    student as s
        JOIN
    course as c ON s.course_id = c.course_id;
 # ---------above we performs the inner join ------------------------
 SELECT 
    s.course_id, c.courseName
FROM
    student as s
       left JOIN
    course as c ON s.course_id = c.course_id;
 # ----------- after inner join now we have compled the left join -------------
 SELECT 
    s.course_id, c.courseName
FROM
    student as s
        right JOIN
    course as c ON s.course_id = c.course_id;
# ------------ after left join now we compled this right join --------------------
 SELECT 
    s.course_id, c.courseName
FROM
    student as s
       left JOIN
    course as c ON s.course_id = c.course_id  
    
    union
   
   SELECT 
    s.course_id, c.courseName
FROM
    student as s
        right JOIN
    course as c ON s.course_id = c.course_id;
# ----- now we compled the full join using union because in mysql we cant apply fulljoin directly ---------------

SELECT 
    s.course_id, s.name
FROM
    student s
        LEFT JOIN
    student c ON s.course_id = c.course_id;
    
# ------------ now we compled this self join ---------------------

select s.course_id,c.courseName from student s cross join course c;

# THE END at last we did the cross join - All the 6 joins completed successfully

select * from student;
select * from course;