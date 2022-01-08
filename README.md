# ForestQuery
Report for ForestQuery into Global Deforestation, 1990 to 2016 
ForestQuery is on a mission to combat deforestation around the world and to raise awareness about this topic and its impact on the environment. The data analysis team at ForestQuery has obtained data from the World Bank that includes forest area and total land area by country and year from 1990 to 2016, as well as a table of countries and the regions to which they belong.

The data analysis team has used SQL to bring these tables together and to query them in an effort to find areas of concern as well as areas that present an opportunity to learn from successes.

1. GLOBAL SITUATION
According to the World Bank, the total forest area of the world was ___41282694.9 sqkm_______________ in 1990. As of 2016, the most recent year for which data was available, that number had fallen to _____39958245.9 sqkm_____________, a loss of _____1324449 sqkm_____________, or __-3.20824258980244________________%.

The forest area lost over this time period is slightly more than the entire land area of _________Australia_________ listed for the year 2016 (which is ___1250590 sqkm_______________).

2. REGIONAL OUTLOOK
In 2016, the percent of the total land area of the world designated as forest was _______31.3755709643095___________. The region with the highest relative forestation was____Latin America & Caribbean______________, with _______46.16___________%, and the region with the lowest relative forestation was __Middle East & North Africa________________, with ____2.07______________% forestation.

In 1990, the percent of the total land area of the world designated as forest was ________32.4222035575689__________. The region with the highest relative forestation was________Latin America & Caribbean__________, with ____51.03______________%, and the region with the lowest relative forestation was ______Middle East & North Africa____________, with __________1.78________% forestation.







Table 2.1: Percent Forest Area by Region, 1990 & 2016:

Region	1990 Forest Percentage	2016 Forest Percentage
Latin America & Caribbean	51.03	46.16
Middle East & North Africa	1.78	2.07
Sub-Saharan Africa	30.6741454610006	28.7881883550464


The only regions of the world that decreased in percent forest area from 1990 to 2016 were ________Latin America & Caribbean__________ (dropped from _______ 51.0299798667514 ___________% to ________ 46.1620721996047 __________%) and _____Sub-Saharan Africa_____________ (______30.6741454610006 ____________% to __________ 28.7881883550464 ________%). All other regions actually increased in forest area over this time period. However, the drop in forest area in the two afore mentioned regions was so large, the percent forest area of the world decreased over this time period from __________ 32.4222035575689 ________% to ______ 31.3755709643095 ____________%. 

3. COUNTRY-LEVEL DETAIL
A.	SUCCESS STORIES
There is one particularly bright spot in the data at the country level, _____ China _____________. This country actually increased in forest area from 1990 to 2016 by ________ 527229.062 sqkm__________. It would be interesting to study what has changed in this country over this time to drive this figure in the data higher. The country with the next largest increase in forest area from 1990 to 2016 was the_____ United States_____________, but it only saw an increase of _______ 79200  sqkm___________, much lower than the figure for ________China__________.

________China__________ and _______United States___________ are of course very large countries in total land area, so when we look at the largest percent change in forest area from 1990 to 2016, we aren’t surprised to find a much smaller country listed at the top. ______ Iceland ____________ increased in forest area by _______ 213.664588870028 ___________% from 1990 to 2016. 

B.	LARGEST CONCERNS
Which countries are seeing deforestation to the largest degree? We can answer this question in two ways. First, we can look at the absolute square kilometer decrease in forest area from 1990 to 2016. The following 3 countries had the largest decrease in forest area over the time period under consideration:

Table 3.1: Top 5 Amount Decrease in Forest Area by Country, 1990 & 2016:

Country	Region	Absolute Forest Area Change
Brazil	Latin America & Caribbean		541510
Indonesia	East Asia & Pacific		282193.9844
Myanmar	East Asia & Pacific		107234.0039
Nigeria	Sub-Saharan Africa	106506.00098
Tanzania	Sub-Saharan Africa	102320


The second way to consider which countries are of concern is to analyze the data by percent decrease.

Table 3.2: Top 5 Percent Decrease in Forest Area by Country, 1990 & 2016:

Country	Region	Pct Forest Area Change
Togo	Sub-Saharan Africa		-75.45
Nigeria	Sub-Saharan Africa		-61.80
Uganda	Sub-Saharan Africa		-59.13
Mauritania	Sub-Saharan Africa	-46.75
Honduras	Latin America & Caribbean	-45.03


When we consider countries that decreased in forest area the most between 1990 and 2016, we find that four of the top 5 countries on the list are in the region of _____Sub-Saharan Africa_____________. The countries are ___Togo_______________, ______Nigeria____________, _______Uganda___________, and _____Mauritania_____________. The 5th country on the list is ____Honduras______________, which is in the ______ Latin America & Caribbean ____________ region. 

From the above analysis, we see that ______Nigeria____________ is the only country that ranks in the top 5 both in terms of absolute square kilometer decrease in forest as well as percent decrease in forest area from 1990 to 2016. Therefore, this country has a significant opportunity ahead to stop the decline and hopefully spearhead remedial efforts.

C.	QUARTILES




Table 3.3: Count of Countries Grouped by Forestation Percent Quartiles, 2016:

Quartile	Number of Countries
1	85
2	73
3	38
4	9

The largest number of countries in 2016 were found in the ____1______________ quartile.

There were ______9____________ countries in the top quartile in 2016. These are countries with a very high percentage of their land area designated as forest. The following is a list of countries and their respective forest land, denoted as a percentage.

Table 3.4: Top Quartile Countries, 2016:
 
Country	Region	Pct Designated as Forest
Suriname	Latin America & Caribbean	98.2576939676578
Micronesia, Fed. Sts.	East Asia & Pacific	91.8572390715248
Gabon	Sub-Saharan Africa	90.0376418700565

