- [Question and Solution](#question-and-solution)
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
  
