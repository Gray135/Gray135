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
- Use **JOIN** to combine movie table with the finance table with finance_id are from both table.
- Use **JOIN** to combine movie table with the person table with person_id are from both table.
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
SELECT DISTINCT p.director, p.actor, m.title. f.budget, f.revenue, f.revenue/f.budget as Ratio
FROM person p
JOIN finance f
ON m.finance_id = f.finance_id
ORDER BY Ratio DESC
LIMIT 10;
````
### Steps: 
- Use DISTINCT to remove duplicates from our results
- Use JOIN to combine the person and finance tables
- Use ORDER BY to filter Ratio largest to smallest

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
- Use COUNT function to count genre in the movie table
- Use SUM function to find the SUM of budget in the financial table.
- Use SUM function to find the sum of the revenue in the financial table.
- Divide the SUM of revenue by the COUNT of genre. Wrap this in a ROUND function.
- Divide the SUM of budget by the COUNT of genre. Wrap this in a ROUND function.
- FULL JOIN the finance and movie tables ON m.finance_id = f.finance_id
- Use GROUP BY to group results my genre and ORDER BY total_revenue DESC
- LIMIT 10

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

4. 
