-- unikalne imiona
SELECT DISTINCT first_name from employees;
-- ; kończy wyrażenie - tak bezpiecznie
SELECT * FROM employees WHERE first_name = "Linda";
-- wieksze mniejsze
SELECT * FROM jobs WHERE min_salary >=6000;
-- laczenie warunków 
SELECT * FROM employees WHERE job_id = 1 AND hire_date >= "2020-01-01";
-- w sql nie ma matcha , if tylko where 
SELECT * FROM employees WHERE first_name = "Alice" OR job_id = 3;
-- uproszczony OR - stosuje sie IN !! zaprzeczenie NOT IN
SELECT * FROM employees WHERE job_id NOT IN (1,2,3,4) ORDER BY department_id ;
-- NOT moze być też przed where
-- BETWEEN - wartości pomiędzy
SELECT * FROM jobs WHERE min_salary BETWEEN 5000 AND 10000;
-- ZADANKA
-- 1. Wyświetl wszystkie adresy email pracowników.
SELECT DISTINCT email FROM employees;
-- 2. Wyświetl numer id, imię oraz nazwisko wszystkich pracowników.
SELECT id, first_name, last_name FROM employees;
-- 3. Wyświetl numer id oraz adres email wszystkich pracowników. Kolumnie id nadaj alias employee_id natomiast kolumnie email nadaj alias private_email.
SELECT id AS employee_id, email AS private_email FROM employees;
-- 4. Wyświetl imiona pracowników. Imiona nie mogą się powtarzać.
SELECT DISTINCT first_name FROM employees;
-- 5. Pokaż wszystkich pracowników z imieniem Tom
SELECT * FROM employees WHERE first_name = "TOM";
-- 6. Pokaż ilu jest pracowników z unikatowymi (bez powtórzeń) imionami oraz zmień nazwę kolumny na number_of_employees.
SELECT DISTINCT first_name AS number_of_employees FROM employees;
-- metoda liczenia  
SELECT COUNT(DISTINCT first_name) AS number_of_employees FROM employees;
-- 7. Pokaż wszystkich pracowników, którzy zostali zatrudnieni od 1 stycznia  2019r.
SELECT * FROM employees WHERE hire_date > "2019-01-01";
-- 8. Pokaż wszystkie stanowiska pracy, gdzie płaca minimalna jest mniejsza niż 5000.
SELECT * FROM jobs WHERE min_salary < 5000;
-- 9. Pokaż wszystkich pracowników z imieniem Adam oraz nazwiskiem Irwin.
SELECT * FROM employees WHERE first_name = "Adam" AND last_name = "Spencer";
-- 10. Pokaż wszystkich pracowników z imieniem Tom lub John.
SELECT * FROM employees WHERE first_name IN ("Tom", "John");
-- 11.Wyświetl wszystkich pracowników, którzy posiadają nazwisko Martinez oraz urodzili się po 1 stycznia 1988.
SELECT * FROM employees WHERE last_name = "Martinez" AND birth_date > "1998-01-01";
-- 12.Wyświetl wszystkich pracowników, którzy nie pracują w dziale o id 3
SELECT * FROM employees  WHERE NOT department_id =3;
-- dodatkowe 
SELECT MAX(birth_date) AS max_val FROM employees;
-- SELECT * FROM employees WHERE MIN(birth_date); -- zle trzeba przez group by
-- łączenie rekordów
SELECT CONCAT(first_name, " ", last_name) AS person FROM employees;
SELECT * FROM employees LIMIT 5; -- wysyla pięć odpowiedzi, najświeższe
-- order by, group by 
SELECT * FROM employees ORDER BY hire_date DESC LIMIT 1; -- najnowsza osoba 
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 1; -- najstarsza osoba 
-- LIKE - czyli takie jak % symbolizuje dowolne znaki, _ - oznacza jeden znak (litera, cyfra)
 -- znajdz rekordy któych first_name kończy się na "a"
SELECT * FROM employees WHERE first_name LIKE "%a";
SELECT * FROM employees WHERE email LIKE "%gmail%";
 -- trzecia litera do r
SELECT * FROM employees WHERE last_name LIKE "__r%";
-- Engine DB MySQL - różnice - czym one się różnią?? - poczytać
-- TRIGERRY jak coś w bazie się zmieni to idzie jakas akcja
INSERT INTO jobs(title,min_salary,max_salary)-- dodawanie rekordu do bazy
VALUES("CEO",12000,20000);
SELECT * FROM jobs;
CREATE DATABASE weather_db; -- zalozenie bazy jeśli nie istnieje, trzeba odswiezac przeglarke
USE weather_db; -- przejscie do aktywnej bazy
CREATE TABLE records(
	id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    temp FLOAT NOT NULL,
    temp_feels_like FLOAT NOT NULL,
    pressure INT NOT NULL,
    weather_desc VARCHAR(255),
    clouds INT NOT NULL,
    place VARCHAR(255) NOT NULL,
    wind FLOAT NOT NULL,
    created TIMESTAMP
);
INSERT INTO records (
    temp,
    temp_feels_like,
    pressure,
    weather_desc,
    clouds,
    place,
    wind,
    created
) VALUES (
    18.4,
    17.2,
    1015,
    'broken clouds',
    60,
    'Gdansk',
    5.3,
    NOW()
);
INSERT INTO records (
    temp,
    temp_feels_like,
    pressure,
    weather_desc,
    clouds,
    place,
    wind,
    created
) VALUES (
    99.4,
    99.2,
    9999,
    'broken sun',
    60,
    'Bełchatów',
    5.3,
    NOW()
);
SELECT* FROM jobs;
SELECT* FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;
-- DROP table - usuwanie tabeli 

-- widoki łączą tabele po joinie

-- zapytanie z aliasami 
SELECT e.last_name, e.email, j.title 
FROM employees AS e
INNER JOIN jobs AS j
ON e.job_id = j.id;

SELECT e.email, d.department_name 
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.id;

SELECT d.department_name, l.postal_code, l.city
FROM departments AS d
INNER JOIN locations AS l
ON d.location_id = l.id;

-- natural joina nie urzywać , bo automatycznie szuka powiazania i nie zawsze znajduje

SELECT e.email, j.title, d.department_name
FROM employees AS e -- ta tabela ma klucze obce ktore łączą inne główne 
INNER JOIN jobs AS j
ON e.job_id = j.id
INNER JOIN departments AS dcities
ON e.department_id = d.id
WHERE j.title LIKE "%Jun%"
ORDER BY e.email DESC
LIMIT 3;

----------------- COUNTRIEs DB
SELECT * FROM countries;
SELECT * FROM states;
SELECT * FROM cities;
INSERT INTO states (name, country_id)
VALUES ("małopolskie", 1); -- błąd bo najpierw trzeba kraj
INSERT INTO countries (name, population, short)
VALUES ("Polska", "36000000", "Supcio kraj");
INSERT INTO cities (name, state, country_id, state_id, code)
VALUES ("Katowice", "niepotrzebne", 1, 2, "43300");
INSERT INTO cities (name, state, country_id, state_id, code)
VALUES ("BłądMiasto", "niepotrzebne", 1, 5, "50999"); -- nie wchodzi bo nie ma takiego state`a

SELECT ci.name, co.name, s.name 
FROM cities AS ci
INNER JOIN countries AS co
ON ci.country_id = co.id
INNER JOIN states AS s
ON ci.state_id = s.id; -- git VALUES

-- teraz bedzie scraping!!! troche na nielegalu



