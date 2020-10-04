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
