# Napoleon-Russia-Campaign

## Motivations
Practice graphics techniques discussed to implement a general visualization (not directly supported by off-the-shelf tools).

## Objective
Recreate Minard's visualization of Napoleon's Russian Campaign using graphical programming.

The visualization must show:
1. position of cities and path of army through them
2. survivors in the army along the path
3. temperature during retreat

## Further Reading
Read more about this famous chart here: https://tinyurl.com/aboutminard

## Minard Data Set
This is provided as an excel sheet, modified from dataset available as the HistData package for R.

Essentially consists of 3 seperate tables.
- Columns 1-3 are longitude, latitude and names of cities.
- Columns 4-8: longitude, temperature, dates (udiring the march home only)
- Columns 9-14: longitude, latitude, number of surviviors, direction of travel (A = towards the attack / R = return journey), division of army