- [Questions and Solutions](#questions-and-solutions)
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


