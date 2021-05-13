-- delete the table if it exists
DROP TABLE nba;

-- create the nba table

CREATE TABLE nba (
	player varchar(50),
	salary integer,
	season char(7),
	season_end integer,
	season_start integer,
	team varchar(50)
);

-- load table

\copy nba FROM '/Users/macmain/CS500/A4/nba.csv' DELIMITER ',' CSV HEADER;
