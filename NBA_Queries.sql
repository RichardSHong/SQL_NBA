-- Richard Hong

-- Q1
-- Find how many teams there were in the NBA at the start of the 2017-2018 season
Select count(distinct team)
From nba
Where season_start = '2017';



-- Q2
-- Find the highest paid player ever. Show the player’s name and salary.
Select player, salary
from nba 
where salary in (select MAX(salary) from nba);



-- Q3
-- Find the player with the lowest salary ever. Show the player’s name, salary, team and season;

Select player, salary, team, season
from nba 
where salary in (select MIN(salary) from nba);



-- Q4
-- Find the names of players who played for the “Philadelphia 76ers” for more than 5 seasons. Show the name of the player and the number of years he played for the team. Order the results showing the max years first.
Select player, count(distinct season) as the_number_of_years_he_played
from nba
where team = 'Philadelphia 76ers'
group by player
having count(distinct season) > 5
order by the_number_of_years_he_played desc;



-- Q5
-- Find the salary of ‘Allen Iverson’ over his entire career. Show the player’s name, the team, the salary and the season. Sort by the year.
Select player, team, salary, season
from nba
where player = 'Allen Iverson'
order by season;



-- Q6
-- Find the players who played over 20 years in the NBA. Show the player’s name, how many years they played in the league and the year of their first season.

Select player, count(distinct season) as the_number_of_years_they_played, min(season_start) as the_year_of_their_first_season
from nba
group by player
having count(distinct season) > 20
order by the_number_of_years_they_played desc; 



-- Q7
-- For each team, list the first year the team started playing in the league (first), the last year the team played in the league (last) , and the total number of years the team played in the league (no_years). Order the results by team name.

select team, min(season_start) as _first_, max(season_end) as _last_, count(distinct season) as no_years
from nba
group by team
order by team;



-- 8 
-- Find the “youngest” team. Show the team name and the year the team began playing.

select team, min(season_start) as the_year_the_team_began_playing
from nba
group by team
having min(season_start) in (select max(A.min_year) from (select team, min(season_start) as min_year
from nba
group by team) A);



-- Q9
-- Find the team that had the most players that played in it over the years. Show the name of the team and the number of players.

select N.team, count(distinct N.player) as the_number_of_players
from nba N
group by N.team
having count(distinct N.player) in (select max(A.N_players) from (select Q.team, count(distinct Q.player) as N_players
from nba Q group by Q.team) A);



-- Q10
--Find the players who played for the most teams over the years. Show the name of the player and the number of teams he played for.

select N.player, count(distinct N.team) as the_number_of_teams_he_played_for
from nba N
group by N.player
having count(distinct N.team) in (select max(A.N_team) from (select Q.player, count(distinct Q.team) as N_team
from nba Q group by Q.player) A);


-- Q11
-- Retrieve details for the nba table. Show the table name, the attribute name, the ordinal position of the attribute within the table, the attribute type and the attribute type length (-1 as length is ok for varchar type) order by the ordinal position of the attribute within the table.
select C.relname as table_name, A.attname, A.attnum as the_ordinal_position, format_type(A.atttypid, A.atttypmod), A.attlen
from pg_class C, pg_attribute A
where C.oid = A.attrelid and C.relname='nba' and A.attnum>0
ORDER BY A.attnum;




-- Q12
-- Add a (minimal) primary key to the ‘nba’ table. Show the SQL command used.
ALTER TABLE nba
ADD CONSTRAINT PK_nba_id primary key(player, season, team);






-- Q13
-- Write a SQL command to retrieve from pg_indexes all indexes for the ‘nba’ table. Show the table name, the index name and the index definition.
select tablename as table_name, indexname as index_name, indexdef as index_definition
from pg_indexes 
where tablename= 'nba';






-- Q14
-- Show all indexes for the table 'nba'. Show the table's name (nba), the access method of the index (e.g, btree), the number of index attributes (3), the index key, whether the index is unique, whether the index is primary, whether the index is clustered.
select C1.relname as table_name, AM.amname as the_access_method_of_the_index, I.indnatts as the_number_of_index_attributes, I.indkey as the_index_key, I.indisunique as Unique, I.indisprimary as Primary, I.indisclustered as Clustered
from pg_class C1, pg_class C2, pg_index I, pg_am AM 
where C1.oid = I.indrelid and C2.oid= I.indexrelid and C2.relam = AM.oid and C1.relname = 'nba';




-- Q15
-- Show all indexes for table "nba" and for each index, show the column names that make up the index.
select C1.relname as table_name, C2.relname as index_name, A.attname as column_name
from pg_class C1, pg_class C2, pg_index I, pg_attribute A
where C1.oid = I.indrelid and C2.oid = I.indexrelid and A.attrelid = C1.oid and A.attnum = ANY(I.indkey) and C1.relkind = 'r' and C1.relname = 'nba';

