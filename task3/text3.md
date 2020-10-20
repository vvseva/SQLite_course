---
name: Vsevolod Suschevskiy 
date: 20-10-2020
---

## Practice 3

### Task 1

>   Увеличить продолжительность курсов по «Теории вероятностей» в 1,5 раза.

-- Code1:

    UPDATE Teacher_Course_Faculty
    SET duration = (
        SELECT duration * 1.5 as duration
        FROM Teacher_Course_Faculty as tcf
        INNER JOIN Courses as c
        ON c.course_id=tcf.course_id
        WHERE course_name = "Теория вероятностей")
    WHERE EXISTS (
        SELECT duration * 1.5 as duration
        FROM Teacher_Course_Faculty as tcf
        INNER JOIN Courses as c
        ON c.course_id=tcf.course_id
        WHERE course_name = "Теория вероятностей")
    )

### Task 2

> Удалить из базы данных информацию о преподавателе с фамилией Никитин (необходимо удалить информацию из всех таблиц, которые ссылаются на запись, содержащую информацию о преподавателе).

-- Code2:

    SELECT 'DELETE FROM ' || name || ' WHERE teacher_id="' ||
        SELECT teacher_id from Teachers WHERE last_name = "Никитин" 
        || '";'
    FROM sqlite_master
    WHERE type = 'table';

### Task3

> Добавить в базу данных информацию, что Голубева Полина сдала экзамен по истории на 5.

-- Code3:
    INSERT INTO Students_marks 
    (student_id, course_id, mark)
        VALUES (
            SELECT student_id, course_id, 5 AS mark 
    (
    SELECT student_id, 1 as tmp_id, last_name, first_name
        FROM Students AS temp_Students
    INNER JOIN(
        SELECT course_id, 1 AS tmp_id 
        FROM Courses 
        WHERE course_name = "История"
        ) AS temp_Courses
        ON temp_Courses.tmp_id= temp_Students.tmp_id
    WHERE last_name="Голубева" AND first_name="Полина"
    )
        );

### Task 4

> Создайте представление (view), которое будет выбирать список преподавателей и список курсов, которые читает преподаватель.

-- Code4:

    CREATE VIEW IF NOT EXISTS v1 AS
        SELECT last_name, first_name, course_name FROM Teachers as t
        INNER JOIN Teacher_Course_Faculty as tcf
            ON tcf.teacher_id=t.teacher_id
        INNER JOIN Courses as c
            ON c.course_id=tcf.course_id;

### Task 5

> Напишите хранимую процедуру, которая будет добавлять или редактировать оценку студента за экзамен. Входящими параметрами будут: student_id – идентификатор студента, course_id – идентификатор курса, mark – оценка за экзамен. Если данный студент уже сдавал экзамен по данному курсу, то процедура должна отредактировать оценку. Если студент не сдавал экзамен, то добавить оценку.

Как я понял в SQL нельзя создать функцию, поэтому попробую сделать на общем языке SQL

-- Code5:

    CREATE PROCEDURE AddorEditMark 
        @student_id int(), 
        @course_id int(), 
        @mark int()
    AS
    IF EXISTS (SELECT student_id, course_id, mark
        FROM Students_marks
        WHERE student_id = @student_id AND course_id = @course_id)
    BEGIN 
        -- if already passed
        UPDATE Students_marks
        SET mark = @mark
        WHERE student_id = @student_id AND course_id = @course_id 
    END    
    ELSE
        -- Create new row
    BEGIN
        INSERT INTO Students_marks
        VALUE (@student_id, @course_id, @mark)
    END
