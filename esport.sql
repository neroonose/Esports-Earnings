/*
ESPORT EARNINGS, DATASET GOTTEN FROM KAGGLE
SKILLS USED: CREATE, JOINS, AGGREGATION, GROUP BY, ORDER BY, SUB QUERIES, COUNT, WITH
*/

CREATE TABLE country_and_continent_codes_list (continent_name TEXT,
										  continent_code CHAR(2),
										  country_name TEXT,
										  two_letter_country_code CHAR(2),
										  three_letter_country_code CHAR(3),
										  country_num INT);
										  
CREATE TABLE highest_earning_players (player_id INT,
									 first_name TEXT,
									 last_name TEXT,
									 current_name VARCHAR(30),
									 country_code CHAR(2),
									 total_usd_prize NUMERIC,
									 game TEXT,
									 genre TEXT);
									 
CREATE TABLE highest_earning_teams(team_id INT,
								  team_name TEXT,
								  total_usd_prize NUMERIC,
								  total_tournaments INT,
								  game TEXT, 
								  genre TEXT);							 



-- VALUES TO BE INSERTED WAS DONE BY CSV IMPORTATION IN PGADMIN

-- VIEW DATASET

SELECT *
  FROM country_and_continent_codes_list;

SELECT *
  FROM highest_earning_players;

SELECT *
  FROM highest_earning_teams;

-- SELECT TOP 10 PLAYERS ACCORDING TO THEIR EARNINGS 

SELECT *
  FROM highest_earning_players 
 ORDER BY total_usd_prize DESC
 LIMIT 10;

--COUNTRIES WITH THE MOST PLAYERS

SELECT country_name, COUNT(country_name) no_of_players
  FROM highest_earning_players AS hep
  JOIN country_and_continent_codes_list cac
    ON hep.country_code = LOWER(cac.two_letter_country_code)
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 10;

--TOP 10 PLAYERS IN ASIA ACCORDING TO EARNINGS

SELECT first_name, last_name, game, continent_name, total_usd_prize
  FROM highest_earning_players hep
  JOIN country_and_continent_codes_list cac
    ON hep.country_code = LOWER(cac.two_letter_country_code)
 WHERE continent_name = 'Asia'
 ORDER BY 3 DESC
 LIMIT 10;


-- TOP RANKING PLAYERS IN EACH GAME ACCORDING TO EARNINGS

WITH t1 AS
    (SELECT first_name, total_usd_prize, game
	   FROM highest_earning_players
	  ),
	 t2 AS  
	 (SELECT MAX(total_usd_prize) total_prize, t1.game
	    FROM t1
	   GROUP BY 2) 
SELECT t1.first_name, t1.game, t2.total_prize
  FROM t1
  JOIN t2
    ON t1.total_usd_prize = t2.total_prize;
	

-- TOP RANKING TEAMS BY TOURNAMENTS PLAYED

SELECT team_name, total_tournaments, game
  FROM highest_earning_teams
 ORDER BY 2 DESC
 LIMIT 10;
 
-- NO OF TOURNAMENTS HOSTED IN EACH GAME

SELECT DISTINCT game, SUM(total_tournaments) total_sum 
  FROM highest_earning_teams
 GROUP BY 1
 ORDER BY 2 DESC;
 
-- NO OF TEAMS THAT PLAY EACH GAME

SELECT  game, COUNT(team_name) no_of_teams
  FROM highest_earning_teams
 GROUP BY 1
 ORDER BY 2 DESC;
 
 
 
 
