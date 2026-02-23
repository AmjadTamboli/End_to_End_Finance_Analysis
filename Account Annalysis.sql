-- total subAccounts
select distinct SubAccount from chart_of_accounts;

-- check all Ledger Account
select g.*,c.SubAccount from gl as g
left join chart_of_accounts as c on g.account_key = c.account_key;


-- calculation Revenue
select ca.year As Year,sum(g.amount)as revenue  from gl as g
inner join chart_of_accounts as c on g.account_key = c.account_key
inner join calendar as ca on g.date = ca.date
where c.subaccount in ('sales','sales return') group by ca.year;

-- Gross Profit territoryWise
select t.Country,sum(g.amount)as 'Gross Profit' from GL as g
inner join chart_of_accounts as c on g.account_key = c.account_key
inner join calendar as ca on g.date = ca.date inner join territory as t on t.Territory_key= g.territory_key
where c.subaccount in ('sales','sales return','Cost of Sales') and year(g.date)=2022 group by t.Country order by 'Gross Profit' desc;

-- Gross Profit
select year(g.date),sum(g.amount)as revenue from GL as g
inner join chart_of_accounts as c on g.account_key = c.account_key
inner join calendar as ca on g.date = ca.date
where c.subaccount in ('sales','sales return','Cost of Sales') group by year (g.date);


-- Year On Year Growth
with Year_sale as
(Select year(g.date) as year,sum(g.amount) as Revenue from gl as g
inner join chart_of_accounts as c on g.account_key = c.account_key
where c.subaccount in ('sales','sales return') 
group by year)
select year , revenue,
lag(revenue,1) over (order by year) as Privious_year_Revenue,
round((revenue-lag(revenue,1) over (order by year)) 
/(lag(revenue,1) over (order by year))*100,2) as Growth_rate
from year_sale;

-- Month over Month Growth rate
select Year ,month,revenue,lag(revenue,1)over (order by year,month) as Privious_Month_Revenue,
round((revenue-lag(revenue,1)over (order by year,month))/lag(revenue,1)over (order by year,month)*100,2) as 'Monthly Growth Rate' from
(Select year(g.date) as Year,Month(g.date) as Month,sum(g.amount) as Revenue from gl as g
inner join chart_of_accounts as c on g.account_key = c.account_key
where c.subaccount in ('sales','sales return') 
group by Month,year(g.date))t;

-- Calculation  EBITADA
select year(date) as Year,sum(g.amount) as EBITADA from gl as g
left join chart_of_accounts as c on g.account_key = c.account_key
where c.class in('Trading account') or c.subclass in ('Operating Expenses')
group by year(date);


-- calculation of Ebit
select year(date) as Year,sum(g.amount) as Net_oprating_Income from gl as g
left join chart_of_accounts as c on g.account_key = c.account_key
where c.class in('Trading account','Operating account')
group by year(date);

-- calculation of net profit 
select year(g.date),sum(g.amount)as Net_profit from gl as g
left join chart_of_accounts as c on g.account_key = c.account_key
where report = 'Profit and Loss'
group by year(g.date)










































































