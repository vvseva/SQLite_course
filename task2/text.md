---
name: Vsevolod Suschevskiy 
date: 18-10-2020
---

## Task 1

> Написать запрос, возвращающий преподавателей у которых есть кураторы. Результат должен содержать одно поле teacher_name, в котором содержится Фамилия и Имя преподавателя через пробел.

-- Code1:

    SELECT (first_name || ' ' || last_name) AS teacher_name
    FROM Teachers
    WHERE curator_id IS NOT NULL;
    

## Task 2

> 2. Выбрать преподавателей, которые читают лекции больше чем на одном факультете.

-- Code2:

    SELECT DISTINCT (first_name || ' ' || last_name) AS teacher_name
    FROM Teachers AS t
        INNER JOIN Teacher_Course_Faculty AS tf
        ON tf.teacher_id = t.teacher_id
    GROUP BY tf.teacher_id
    HAVING COUNT (faculty_id) >1;


## Task 3

> 3. Написать запрос, который возвращает фамилию студента, название курсов, которые читаются на его факультете и оценку студента по курсу, если он его сдавал. Если студент не сдавал курс, то вместо оценки вывести null. Следует учитывать, что студент может сдавать экзамен по курсу, который не читается на его факультете, а также, один курс на факультете может читаться различными преподавателями.

-- Code3:

    SELECT last_name, course_name, mark
    From Students as s
  	LEFT join Students_marks as m
    ON	m.student_id=s.student_id
    left JOIN Courses as c
    ON c.course_id=m.course_id;
    INNER JOIN Teacher_Course_Faculty as tf
    ON tf.course_id=c.course_id;
  

## Task 4

> 4. Написать запрос, который возвращает фамилию студента, его имя и средний бал, по результатам сданных экзаменов, для студентов, средний бал которых больше или равен 4. Результат отсортировать по убыванию среднего балла и по фамилии студента.

-- Code4:

    SELECT last_name, first_name, AVG(mark) as mark_avg
    From Students as s
        LEFT join Students_marks as m
        ON	m.student_id=s.student_id
    Group By s.student_id
    HAVING mark_avg >= 4
    ORDER BY mark_avg DESC, last_name DESc;

## Task 5

> 5.  Вывести список факультетов и для каждого факультета название курса, который имеет наименьшую продолжительность.

-- Code5:

    SELECT faculty_name, course_name
    FROM Faculties as f
    INNER JOIN Teacher_Course_Faculty as tcf
        ON tcf.faculty_id=f.faculty_id
    INNER JOin Courses as c
        ON c.course_id=tcf.course_id
    GROUP BY faculty_name
    HAVING duration = MIN(duration);

## Task 6

> 6. Выбрать фамилии студентов, которые сдали экзамен по алгебре лучше, чем экзамен по
геометрии.

-- Code6:

    CREATE TEMP TABLE IF NOT EXISTS tbl_a AS
        SELECT s.student_id, last_name, mark as mark_a
        From Students as s
        INNER JOIN Students_marks as m
        ON m.student_id=s.student_id
        Inner JOIN Courses as c
        ON c.course_id=m.course_id
        WHERE course_name = 'Алгебра';
        
    CREATE TEMP TABLE IF NOT EXISTS tbl_g AS
        SELECT s.student_id, last_name, mark as mark_g
        From Students as s
        INNER JOIN Students_marks as m
        ON m.student_id=s.student_id
        Inner JOIN Courses as c
        ON c.course_id=m.course_id
        WHERE course_name = 'Геометрия';
        
    SELECT last_name
        FROM tbl_a
        INNER JOIN tbl_g
        ON tbl_g.student_id=tbl_a.student_id
        WHERE mark_a>mark_g;

не самое элегантное решение, возможно стоило сгруппировать по предмету и оставить Алгебру и Геометрию через условие

## Task 7

> Написать запрос, который вернет название курса и название факультета, для курсов, которые читаются только на одном факультете и не читаются на других факультетах.

-- Code7:

    SELECT course_name, faculty_name
    FROM (
        SELECT course_name, faculty_name, COUNT(*)
        FROM Courses as c
        INNER JOIN Teacher_Course_Faculty as tcf
            ON tcf.course_id=c.course_id
        Inner Join Faculties as f
            ON f.faculty_id=tcf.faculty_id
        GROUP BY course_name, faculty_name
        HAVING COUNT(*) =1
    ) as tmp
    Group BY course_name
    HAVING COUNT(*) = 1;

а вот этот прям нормально получился
