## Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

***
## Business Task
Movie Executives want to use data from highest performing movies to identify insights to potentially replicate the success. 

***

## Entity Relationship Diagram

***

## Question and Solution
1. What are the top 10 top performing movies? Of those 10 movies who is are the actor and director? Are there any repeats?
 
   ````sql
   SELECT m.title, f.revenue, f.budget, p.director, p.lead_actor
   FROM movie m
   JOIN finance f
   ON m.finance_id = f.finance_id
   JOIN person p
   ON p.person_id = m.person_id
   ORDER BY revenue DESC, budget ASC
   LIMIT 10;
   ````
### Steps:
- **SELECT** the colunms to pull from each table
- Use **JOIN** to combine movie table with the finance table. 
- Use **JOIN** to combine movie table with the person table.
- Use **ORDER BY** to order revenue **DESC** and budget **ASC**

### Answer:
| Title | Revenue | Budget | Director | Lead Actor |
| ------| --------|--------|----------|-------|
| Avatar| 2787965087| 237000000 | James Cameron | Sam Worthington |
| Titanic | 1845034188 | 200000000 | James Cameron | Kate Winslet |
| The Avengers | 1519557910 | 220000000 | Joss Whedon | Robert Downey |
| Jurassic World | 1513528810 | 150000000 | Colin Trevorrow | Chris Pratt |
| Furious 7 | 1506249360 | 190000000 | James Wan | Vin Diesel |
| Avengers: Age of Ultron | 1405403694 | 280000000 | Joss Whedon | Robert Downey |
| Frozen | 1274219009 | 150000000 | Chris Buck | Kristen Bell |
| Iron Man 3 | 1215439994 | 200000000 | Shane Black | Robert Downey |
| Minions | 1156730962 | 74000000 | Kyle Balda | Sandra Bullock |
| Captain America: Civil War | 1153304495 | 250000000 | Anthony Russo | Chris Evans |

- James Cameron is the top performing director and holds the top two spot.
- Robert Downey is the on top performing actor and holds 3 spots.
- Joss Whedon is the only other repeat director on this list.
  
***

2. Let's look at the ratio of budget to revenue. What top ten movies had the largest ratio of budget to revenue? Additionally who are the actors and directors?

````sql
SELECT DISTINCT p.director, p.actor, m.title, f.budget, f.revenue, f.revenue/f.budget as Ratio
FROM finance f
JOIN movie m
ON m.finance_id = f.finance_id
JOIN person p
ON p.person_id = m.person_id
ORDER BY Ratio DESC
LIMIT 10;
````
### Steps: 
- **SELECT** the colunmns to list from all tables.
- Use **DISTINCT** after **SELECT** to remove duplicates from our results
- Use **JOIN** to combine the finance and movie tables
- Use **JOIN** to combine the movie and person tables
- Use **ORDER BY** to filter Ratio largest to smallest

### Answer: 
| Director | Lead Actor | Title | Budget | Revenue | Ratio |
|----------|------------|-------|--------|---------|-------|
| Oren Peli | Katie Featherston| Paranormal Activity | 15000 | 193355800 | 12890 |
| Daniel Myrick | Michael C. | The Blair Witch Project | 60000 | 248000000 | 4133 |
| David Lynch | Jack Nance | Eraserhead | 10000 | 7000000 | 700 |
| John Waters | Divine David | Pink Flamingos | 12000 | 6000000 | 500 |
| Morgan Spurlock | Morgan Spurlock | Super Size Me | 65000 | 28575078 | 439 |
| Travis Cliff | Cassidy Giffod | The Gallows | 100000| 42664410 | 426|
| Chris Kentis | Blanchard Ryan | Open Water | 130000| 546667954| 420 |
| Tobe Hopper | Marilyn Burns | The Texas Chainsaw Massacre| 85000 | 30859000 | 363 | 
| David Hand | Donnie Dunagan | Bambi | 858000 | 267447150 | 311 |
| George A. Romero | Duane Jones | Night of Living Dead | 114000 | 30000000 |263 |

***

3. Let's look at movie generes/ What is the average budget and revenue for each genre? Also what is the overall budget and revenue for each genre?
   
````sql
SELECT m.genre, COUNT(m.genre) AS genre_count, SUM(f.revenue) AS total_revenue, SUM(f.budget) as total_budget, ROUND(SUM(f.revenue)/COUNT(m.genre)) AS avg_genre_revenue, ROUND(SUM(f.budget)?COUNT(m.genre)) AS avg_genre_budget
FROM movie m FULL JOIN finance f ON m.finance_id = f. finance_id
GROUP BY m.genre
ORDER BY total_revenue DESC
LIMIT 10;
````
### Steps: 
- Use **COUNT** function to count genre in the movie table
- Use **SUM** function to find the sum of budget in the financial table.
- Use **SUM** function to find the sum of the revenue in the financial table.
- Divide the **SUM** of revenue by the **COUNT** of genre. Wrap this in a **ROUND** function.
- Divide the **SUM** of budget by the **COUNT** of genre. Wrap this in a **ROUND** function.
- **FULL JOIN** the finance and movie tables ON m.finance_id = f.finance_id
- Use **GROUP BY** to group results my genre and ORDER BY total_revenue DESC
- Use **LIMIT** 10 to limit to ten rows.

### Answer:
| genre | genre _count | total_revenue | total_budget | avg_genre_revenue | avg_genre_budget |
|-------|--------------|---------------|--------------|-------------------|------------------|
| Action | 582 | 91410093341| 34182772285 | 157062016 | 58733286|
| Adventure | 285 | 70825965880 | 21670338087 | 248512161 | 76036274 |
| Drama | 727 | 54071812901 | 19654899101 | 74376634 | 27035625 |
| Comedy | 620 | 52949486321 | 17295174517 | 85402397 | 27895443 |
| Animation | 98 | 29592651289| 8166432353 | 301965829 | 83330942 |
| Fantasy | 91 | 17057191752 | 5905438823 | 187441668 | 64894932 |
| Science Fiction | 79 | 16176309703 | 4631307003 | 204763414 | 58624139| 
| Horror | 196 | 13242095127 | 3216536235 | 67561710 | 16410899 |
| Thriller | 116 | 11687045798 | 4504020000 | 100750395 | 388277759 |
| Crime | 141 | 9408596694 | 3886096953 | 66727636 | 27560971 |

***

4. Calculate the average genre revenue and budget to compare to the movie buget in the genre. We've limited it to the first 10 entries in our table. 
   
````sql
WITH avg_genre AS (
    SELECT 
        m.genre, 
        ROUND(SUM(f.revenue) / COUNT(m.genre)) AS avg_genre_revenue,
        ROUND(SUM(f.budget) / COUNT(m.genre)) AS avg_genre_budget
    FROM movie m 
    FULL JOIN finance f ON m.finance_id = f.finance_id
    GROUP BY m.genre
)

SELECT 
    m.movie_id, 
    m.title, 
    m.genre, 
    f.budget, 
    f.revenue, 
    ag.avg_genre_revenue, 
    ag.avg_genre_budget
FROM avg_genre ag
JOIN movie m ON ag.genre = m.genre
JOIN finance f ON f.finance_id = m.finance_id
LIMIT 10;
````
### Steps: 
- Create a **CTE*** named avg_genre that uses aggregate functions **SUM**(), **COUNT**(), and **ROUND**().
- Calculate avg_genre_revenue by taking **SUM**(f.revenue) and dividing it by **COUNT**(m.genre).
- Wrap it in **ROUND**() to make it easier to read.
- Calculate avg_genre_budget by taking **SUM**(f.budget) divided by **COUNT**(m.genre), also wrapped in **ROUND**().
- Use a **FULL JOIN** to connect the movie and finance tables using m.finance_id = f.finance_id.
- Group the results by m.genre to ensure averages are calculated per genre.
- Write the main **SELECT** statement to pull relevant columns:
- From the movie table: movie_id, title, genre
- From the finance table: budget, revenue
- From the **CTE**: ag.avg_genre_revenue, ag.avg_genre_budget
- **JOIN** the **CTE** avg_genre with the movie table on genre.
- **JOIN** the finance table using m.finance_id = f.finance_id.
- **LIMIT** the output using LIMIT 10 to preview the results.

### Answer:
| movie_id | title | genre | budget | revenue | avg_genre_revene | avg_budget_revenue |
|----------|-------|-------|--------|---------|------------------|--------------------|
| 1 | Avatar | Action| 237000000 | 2787965087 | 157062016 | 58733286 |
| 2 | Pirates of the Caribbean: At World's End | Adventure | 3000000000 | 961000000 | 248512161 | 76036274 |
| 3 | Spectre | Action | 245000000 | 880674609 | 157062016 | 58733286 |
| 4 | The Dark Knight Rises | Action | 2500000000 | 1084939099 | 157062016 | 58733286 |
| 5 | John Carter | Action | 260000000 | 284139100 | 157062016 | 58733286 |
| 6 | Spider-Man 3 | Fantasy | 258000000 | 890871626 | 187441668 | 64894932 |
| 7 | Tangled | Animation | 260000000 | 591794936 | 301965829 | 83330943 |
| 8 | Avengers: Age of Ultron | Action | 280000000 | 1405403694 | 157062016 | 58733286 |
| 9 | Harry Potter and the Half-Blood Prince | Adventure | 250000000 | 933959197 | 248512161 | 76036274 |
| 10 | Batman v Superman: Dawn of Justice | Action | 250000000 | 873260194 | 157062016 | 58733286 |

***

5. For the top 10 performing films what production companies finances the films? Is there a production company who financed multiple films in the top 10?
````sql
SELECT production_id, production_company, production_country, title, genre, budget, revenue
FROM proudction
JOIN movie ON production.movie_id = movie.movie_id
JOIN finance ON finance.finance_id = movie.finance_id
ORDER BY revenue DESC
LIMIT 10;
````
### Steps: 
- Start with the **SELECT** Statement and decide what columns to return.
- Undwe **FROM** **JOIN** related tables based on shared keys.
- Add an **ORDER BY** and sort the results so the most successful movies appear first:
  First by revenue **DESC** (highest grossing)
  Then by budget **ASC** (lowest cost to break ties)
-**LIMT** the output. 

### Answer: 
| production_id | production_company | production_country | title | genre | budget | revenue |
|---------------|--------------------|--------------------|-------|-------|--------|---------|
| 1 | 9511 | Ingenious Film Partners | United Statets of America | Avatar | Action | 237000000 | 2787965087 |
| 2 | 9536 | Paramount Pictures | United States of America | Titanic | Drama | 200000000 | 1845034188 |
| 3 | 9527 | Paramount Pictures | United States of America | The Avengers | Science Fiction | 220000000 | 1519557910 |
| 4 | 9539 | Universal Studios | United States of America | Jurassic World | Action | 150000000 | 1513528810 |
| 5 | 9555 | Universal Studios | Japan | Furious 7 | Action | 190000000 | 1506249360 |
| 6 | 9518 | Marvel Studios | United States of America | Avengers: Age of Ultron | Action | 280000000 | 1405403694 |
| 7 | 9634 | Walt Disney Studios | United States of America | Frozen | Animation | 150000000 | 1274219009 |
| 8 | 9542 | Marvel Studios | China | Iron Man 3 | Action | 200000000 | 1215439994 |
| 9 | 10036 | Universal Pictures | United States of America | Minions | Family | 740000000 | 1156730962 |
| 10 | 9537 | Marvel Studios | United States of America | Captain America: Civil War | Adventure | 250000000 | 1153304495 |

***

6.  For the top ten peforming films compare the budget, revenue, runtime with the averageg budget, revenue, and runtime.
````sql
WITH average as (
SELECT
ROUND(AVG(runtime)) as avg_runtime,
ROUND(AVG(budget)) as avg_budget,
ROUND(AVG (revenue)) as avg_revenue 
FROM movie m FULL JOIN finance f on m.finance_id = f.finance_id)

SELECT m.title, f.budget, m.genre, f.revenue, m.runtime, 
a.avg_runtime, a.avg_budget, a.avg_revenue
FROM movie m 
JOIN finance f ON m.finance_id = f.finance_id 
CROSS JOIN average a 
ORDER BY revenue DESC
LIMIT 10;
````
### Steps: 
- Create a **CTE** (**WITH** average **AS**) to calculate overall averages:
- Use **AVG()** to calculate average runtime, budget, and revenue
- Wrap each in **ROUND()** for easier readability
- Use **AS** to create readable alias names: avg_runtime, avg_budget, and avg_revenue
- **JOIN** movie and finance tables on shared keys
- **SELECT** title, budget, genre, revenue, and runtime from the movie and finance tables
- Include the three average values from the **CTE** (avg_runtime, avg_budget, avg_revenue)
- Use **JOIN** to combine movie and finance on `finance_id
- Use a **CROSS JOIN** to attach the one-row `average` CTE to every result row
- Use **ORDER** BY f.revenue DESC` to show the top-grossing films first
- Use **LIMIT 10** to display only the top 10 movies
  
### Answer:
| title | budget | genre | revenue | runtime | avg_runtime | avg_budget | avg_revenue |
|-------|--------|-------|---------|---------|-------------|------------|-------------|
| Avatar | 237000000 | Action | 2787965087 | 162 | 111| 41317104 | 123414291 |
| Titanic | 200000000 | Drama | 1845034188 | 194 | 111 | 41317104 | 123414291 |
| Avengers | 220000000 | Science Fiction | 1519557910 | 143 | 111 | 41317104 | 123414291 |
| Jurassic World | 150000000 | Action | 1513528810 | 143 | 111 | 41317104 | 123414291 |
| Furious 7 | 190000000 | Action | 1506249360 | 137 | 111 | 41317104 | 123414291 |
| Avengers: Age of Ultron | 280000000 | Action | 1405403694 | 141 | 111 | 41317104 | 123414291 |
| Frozen | 150000000 | Animation | 1274219009 | 102 | 111 | 41317104 | 123414291 |
| Iron Man 3 | 200000000 | Action | 1215439994 | 130 | 111 | 41317104 | 123414291 |
| Minions | 74000000 | Family | 1156730962 | 91 | 111 | 41317104 | 123414291 |
| Captain America: Civil War | 250000000 | Adventure | 1153304495 | 111 | 41317104 | 123414291 |

***

7.  What is the the runtime, release_year, and run_time of the top ten grossing films?
````sql
SELECT m.title, m.release_year, f.revenue, m.genre, p.production_company, p.production_country
FROM movie m
JOIN finance f
ON m.finance_id = f.finance_id
JOIN production p
ON p.movie_id = m.movie_id
ORDER BY f.revenue DESC
LIMIT 10;
````
### Steps: 
### Answer:
