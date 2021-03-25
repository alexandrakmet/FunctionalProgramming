DROP TABLE IF EXISTS software;
CREATE TABLE software
(
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(20)   NOT NULL,
    annotation     VARCHAR(20)   NOT NULL,
    version        VARCHAR(2000) NOT NULL,
    start_of_usage DATETIME      NOT NULL,
    author_id      INT REFERENCES author (id),
    type_id        INT REFERENCES type (id)
);

DROP TABLE IF EXISTS type;
CREATE TABLE type
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);

DROP TABLE IF EXISTS author;
CREATE TABLE author
(
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(20) NOT NULL,
    surname VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id                SERIAL PRIMARY KEY,
    name              VARCHAR(20) NOT NULL,
    login             VARCHAR(20) NOT NULL,
    registration_date DATETIME    NOT NULL
);

DROP TABLE IF EXISTS use_term;
CREATE TABLE use_term
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(20)   NOT NULL,
    description VARCHAR(2000) NOT NULL
);

DROP TABLE IF EXISTS software_use_terms;
CREATE TABLE software_use_terms
(
    software_id INT REFERENCES software (id),
    use_term_id INT REFERENCES author (id)
);

DROP TABLE IF EXISTS software_usage_statistic;
CREATE TABLE software_usage_statistic
(
    software_id INT REFERENCES software (id),
    user_id     INT REFERENCES users (id),
    logon_count INT NOT NULL DEFAULT 0
);


INSERT INTO type (name)
VALUES ('type1');
INSERT INTO type (name)
VALUES ('type2');
INSERT INTO type (name)
VALUES ('type3');

INSERT INTO author (name, surname)
VALUES ('name1', 'surname1');
INSERT INTO author (name, surname)
VALUES ('name2', 'surname2');
INSERT INTO author (name, surname)
VALUES ('name3', 'surname3');

INSERT INTO software (name, annotation, version, start_of_usage, author_id, type_id)
VALUES ('name1', 'annotation1', '1.0', '2020-01-01', 1, 1);
INSERT INTO software (name, annotation, version, start_of_usage, author_id, type_id)
VALUES ('name2', 'annotation2', '2.0', '2020-02-02', 2, 2);
INSERT INTO software (name, annotation, version, start_of_usage, author_id, type_id)
VALUES ('name3', 'annotation1', '3.0', '2020-03-03', 3, 3);

INSERT INTO users (name, login, registration_date)
VALUES ('name1', 'login1', now());
INSERT INTO users (name, login, registration_date)
VALUES ('name2', 'login2', now() - INTERVAL 1 DAY);

INSERT INTO use_term (name, description)
VALUES ('term1', 'description1');
INSERT INTO use_term (name, description)
VALUES ('term2', 'description2');
INSERT INTO use_term (name, description)
VALUES ('term3', 'description3');
INSERT INTO use_term (name, description)
VALUES ('term4', 'description4');
INSERT INTO use_term (name, description)
VALUES ('term5', 'description5');

INSERT INTO software_usage_statistic (software_id, user_id, logon_count)
VALUES (1, 1, 1);
INSERT INTO software_usage_statistic (software_id, user_id, logon_count)
VALUES (1, 2, 12);
INSERT INTO software_usage_statistic (software_id, user_id, logon_count)
VALUES (2, 1, 21);
INSERT INTO software_usage_statistic (software_id, user_id, logon_count)
VALUES (2, 2, 22);
INSERT INTO software_usage_statistic (software_id, user_id, logon_count)
VALUES (3, 1, 31);

INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (1, 1);
INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (1, 2);
INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (1, 5);
INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (2, 3);
INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (2, 4);
INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (3, 1);
INSERT INTO software_use_terms (software_id, use_term_id)
VALUES (3, 3);

COMMIT;

