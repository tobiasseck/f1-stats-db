# Step 1	Download the F1 folder from One Drive at
#			https://datasmartpoint-my.sharepoint.com/:f:/p/tobias_seck-student/EnmhC0Ja6UpOpo2hTLYR6XIBa7SLzwQExASCZNdLDsiLsg?e=gO7Scs
# Step 2	Unpack and move the F1 folder to a location of your choice on your PC/Mac or network
# Step 3	Use the Find & Replace function in MySQL Workbench
#			(Strg + F / Ctrl + F / Cmd + F --> a search bar pops up above the SQL editor featuring a drop down menu on the left --> chose Find & Replace)
# Step 4	Insert "Z:/DataSmart Point/SQL" into the find field and the location where you moved the F1 folder to on your PC into the replace field e.g. "C:/Users/User/Documents"
# Step 5	Click "Replace All"
# Step 6 	Run the full SQL script to install the F1 database, create all tables, and import their datasets
# Step 7	Have fun with exploring SQL queries!

create database if not exists f1;

-- Strecken
drop table f1.circuits;
create table if not exists f1.circuits (
	circuit_id smallint unsigned primary key auto_increment,
    circuit_ref varchar(50),
    circuit_name varchar(255),
    circuit_location varchar(255),
    circuit_country varchar(50),
    circuit_lat decimal(12,5),
    circuit_lng decimal(12,5),
    circuit_alt smallint,
    circuit_url varchar(255)
);

set global local_infile = 1;

load data local infile 'Z:/DataSmart Point/SQL/F1/circuits.csv'
into table f1.circuits
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(circuit_id, circuit_ref, circuit_name, circuit_location, circuit_country, circuit_lat, circuit_lng, circuit_alt, circuit_url);

-- Fahrerverzeichnis
create table if not exists f1.drivers (
	driver_id int unsigned primary key auto_increment,
    driver_ref varchar(50),
    driver_number tinyint unsigned default null,
    driver_code varchar(3) default null,
    driver_firstname varchar(50),
    driver_lastname varchar(50),
    driver_dob date,
    driver_nationality varchar(50),
    driver_url varchar(255)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/drivers.csv'
into table f1.drivers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(driver_id, driver_ref, driver_number, driver_code, driver_firstname, driver_lastname, driver_dob, driver_nationality, driver_url);

update f1.drivers set driver_number = null where driver_id in (
	select t.driver_id from (select driver_id from f1.drivers where driver_number = 0) as t);

update f1.drivers set driver_code = null where driver_id in (
	select t.driver_id from (select driver_id from f1.drivers where driver_code = '') as t);

-- Konstrukteurverzeichnis
create table if not exists f1.constructors (
	con_id int unsigned primary key auto_increment,
    con_ref varchar (20),
    con_name varchar(255),
    con_nationality varchar(50),
    con_url varchar(255)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/constructors.csv'
into table f1.constructors
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(con_id, con_ref, con_name, con_nationality, con_url);

-- Seasonverzeichnis
create table if not exists f1.seasons (
	season_year year unique,
    season_url varchar(255),
    primary key (season_year)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/seasons.csv'
into table f1.seasons
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(season_year, season_url);

-- Verzeichnis der Rennen
create table if not exists f1.races (
	race_id int unsigned primary key auto_increment,
    race_year year,
    race_round tinyint unsigned,
    circuit_id smallint unsigned,
    race_name varchar(255),
    race_date date,
    race_time time,
    race_url varchar(255),
    race_fp1date date,
    race_fp1time time,
    race_fp2date date,
    race_fp2time time,
    race_fp3date date,
    race_fp3time time,
    race_qualidate date,
    race_qualitime time,
    race_sprintdate date,
    race_sprinttime time,
    foreign key(circuit_id) references f1.circuits(circuit_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/races.csv'
into table f1.races
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(race_id, race_year, race_round, circuit_id, race_name, race_date, race_time, race_url, race_fp1date, race_fp1time, race_fp2date, race_fp2time, race_fp3date,
 race_fp3time, race_qualidate, race_qualitime, race_sprintdate, race_sprinttime);

-- Konstrukteursergebnisse
create table if not exists f1.conresults (
	conres_id int unsigned primary key auto_increment,
    race_id int unsigned,
    con_id int unsigned,
    conres_points smallint unsigned,
    conres_status varchar(2),
    foreign key(race_id) references f1.races(race_id),
    foreign key(con_id) references f1.constructors(con_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/constructor_results.csv'
into table f1.conresults
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(conres_id, race_id, con_id, conres_points, conres_status);

-- Status Verzeichnis
create table if not exists f1.status (
	status_id int primary key auto_increment,
    status_value varchar(255)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/status.csv'
into table f1.status
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(status_id, status_value);

-- Rennergebnis Verzeichnis
create table if not exists f1.raceresults (
	rres_id int primary key auto_increment,
    race_id int unsigned,
    driver_id int unsigned,
    con_id int unsigned,
    rres_number tinyint,
    rres_grid tinyint,
    rres_poition tinyint,
    rres_positiontext varchar(10),
    rres_positionorder tinyint,
    rres_points tinyint,
    rres_laps tinyint,
    rres_time varchar(20),
    rres_milliseconds int,
    rres_fastestlap tinyint,
    rres_rank tinyint,
    rres_fastestlaptime varchar(20),
    rres_fastestlapspeed decimal(6,3),
    status_id int,
    foreign key(race_id) references f1.races(race_id),
    foreign key(driver_id) references f1.drivers(driver_id),
    foreign key(con_id) references f1.constructors(con_id),
    foreign key(status_id) references f1.status(status_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/results.csv'
into table f1.raceresults
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(rres_id, race_id, driver_id, con_id, rres_number, rres_grid, rres_poition, rres_positiontext, rres_positionorder,
rres_points, rres_laps, rres_time, rres_milliseconds, rres_fastestlap, rres_rank, rres_fastestlaptime, rres_fastestlapspeed, status_id);

update f1.raceresults set rres_milliseconds = null where rres_id in (
select t.rres_id from (select rres_id from f1.raceresults where rres_milliseconds = 0) as t);

update f1.raceresults set rres_fastestlapspeed = null where rres_id in (
select t.rres_id from (select rres_id from f1.raceresults where rres_fastestlapspeed = 0) as t);

-- Sprintergebnis Verzeichnis
create table if not exists f1.sprintresults (
	sprint_id int primary key auto_increment,
    race_id int unsigned,
    driver_id int unsigned,
    con_id int unsigned,
    sprint_number smallint,
    sprint_grid tinyint,
    sprint_position tinyint,
    sprint_positionText varchar(10),
    sprint_positionorder tinyint,
    sprint_points tinyint,
    sprint_laps tinyint,
    sprint_time varchar(20),
    sprint_milliseconds int,
    sprint_fastestlap tinyint,
    sprint_fastestlaptime varchar(20),
    status_id int,
    foreign key(race_id) references f1.races(race_id),
    foreign key(driver_id) references f1.drivers(driver_id),
    foreign key(con_id) references f1.constructors(con_id),
    foreign key(status_id) references f1.status(status_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/sprint_results.csv'
into table f1.sprintresults
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(sprint_id, race_id, driver_id, con_id, sprint_number, sprint_grid, sprint_position, sprint_positionText, sprint_positionorder, sprint_points,
sprint_laps, sprint_time, sprint_milliseconds, sprint_fastestlap, sprint_fastestlaptime, status_id);

-- Konstrukteurswertung Verzeichnis
create table if not exists f1.constandings (
	const_id int primary key auto_increment,
    race_id int unsigned,
    con_id int unsigned,
    const_points smallint,
    const_position tinyint,
    const_positiontext varchar(20),
    const_wins tinyint,
    foreign key(race_id) references f1.races(race_id),
    foreign key(con_id) references f1.constructors(con_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/constructor_standings.csv'
into table f1.constandings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(const_id, race_id, con_id, const_points,const_position, const_positiontext, const_wins);

-- Fahrerwertung Verzeichnis
create table if not exists f1.driverstandings (
	dvrst_id int primary key auto_increment,
    race_id int unsigned,
    driver_id int unsigned,
    dvrst_points smallint,
    dvrst_position tinyint,
    dvrst_positiontext varchar(20),
    dvrst_wins tinyint,
    foreign key(race_id) references f1.races(race_id),
    foreign key(driver_id) references f1.drivers(driver_id)
);


load data local infile 'Z:/DataSmart Point/SQL/F1/driver_standings.csv'
into table f1.driverstandings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(dvrst_id, race_id, driver_id, dvrst_points, dvrst_position, dvrst_positiontext, dvrst_wins);

-- Qualifying Verzeichnis
create table if not exists f1.qualifying (
	q_id int primary key auto_increment,
    race_id int unsigned,
    driver_id int unsigned,
    con_id int unsigned,
    q_number tinyint,
    q_position tinyint,
    q_q1 varchar(20),
    q_q2 varchar(20),
    q_q3 varchar(20),
    foreign key(race_id) references f1.races(race_id),
    foreign key(driver_id) references f1.drivers(driver_id),
    foreign key(con_id) references f1.constructors(con_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/qualifying.csv'
into table f1.qualifying
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(q_id, race_id, driver_id, con_id, q_number, q_position, q_q1, q_q2, q_q3);

-- Pitstop Verzeichnis
create table if not exists f1.pitstops (
	race_id int unsigned,
    driver_id int unsigned,
    pit_stop tinyint unsigned,
    pit_lap tinyint unsigned,
    pit_time time,
    pit_duration varchar(20),
    pit_milliseconds int,
    foreign key(race_id) references f1.races(race_id),
    foreign key(driver_id) references f1.drivers(driver_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/pit_stops.csv'
into table f1.pitstops
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(race_id, driver_id, pit_stop, pit_lap, pit_time, pit_duration, pit_milliseconds);

-- Rundenzeiten Verzeichnis

create table if not exists f1.laptimes (
	race_id int unsigned,
    driver_id int unsigned,
    lap_lap tinyint unsigned,
    lap_position tinyint,
    lap_time time,
    lap_milliseconds int,
	foreign key(race_id) references f1.races(race_id),
    foreign key(driver_id) references f1.drivers(driver_id)
);

load data local infile 'Z:/DataSmart Point/SQL/F1/lap_times.csv'
into table f1.laptimes
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(race_id, driver_id, lap_lap, lap_position, lap_time, lap_milliseconds);