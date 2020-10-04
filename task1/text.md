---
name: Vsevolod Suschevskiy 
date: 04-10-2020
---

# Seminar 1

## Task 1: Proect and create

> Спроектируйте базу данных по требованиям, описанным ниже. Нарисуйте диаграмму спроектированной базы и напишите SQL скрипт, который создаст эту базу данных. Диаграмма должны быть представлена в удобочитаемом формате. При создании скрипта необходимо для всех таблиц определить первичные ключи, и необходимые внешние ключи.

### ER diagram 

>Представить реляционную модель базы для хранения информации об административной структуре компании. База содержит следующую информацию: 1. Список отделов и их специализацию (например, бухгалтерия, логистический и т.д.). Отделы имеют иерархическую структуру, т.е. отдел может быть частью какого-то другого отдела (Например, есть два офиса - в Москве и в Петербурге, в каждом офисе есть бухгалтерия и IT отдел; в Москве IT отдел состоит из двух подотделов). 2. Список сотрудников. Для каждого сотрудника необходимо хранить: ФИО, дата рождения, должность, зарплата, отдел в котором он работает, и его непосредственного руководителя. Для одинаковых должностей зарплата одинаковая.

![ER](https://github.com/vvseva/SQLite_course/blob/main/task1/task_1%20ER.jpg?raw=true)

### SQLite code


    -- Write code 

    CREATE TABLE IF NOT EXISTS Staff(
        full_name TEXT    PRIMARY KEY    NOT NULL,
        bday     TEXT    NOT NULL,
        position     TEXT    NOT NULL,
        department     TEXT    NOT NULL,
        supervisor  TEXT    NOT NULL,
        FOREIGN KEY (position)
            REFERENCES Position (pos_name),
        FOREIGN KEY (department)
            REFERENCES Department (dep_name),
    );

    CREATE TABLE IF NOT EXISTS Position(
        pos_name TEXT  PRIMARY KEY   NOT NULL,
        salary INT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Department(
        dep_name TEXT  PRIMARY KEY    NOT NULL,
        specialization TEXT NOT NULL,
        head TEXT, 
        tail
    );
   
## Task 2: 
