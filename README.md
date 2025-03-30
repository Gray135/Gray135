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
   LIMIT 10
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
LIMIT 10
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


