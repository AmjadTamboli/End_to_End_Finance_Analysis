
use accountingdb;
select * from gl;
select * from chart_of_accounts;
select * from calendar;
select * from territory;
select * from cashflow_st;
select * from soce_st;

rollback;
alter table gl 
change ï»¿EntryNo  EntryNo text;
alter table gl 
modify Date date;
alter table gl modify amount int;
set sql_safe_updates = 0;
update gl
set date = str_to_date(date,'%d-%m-%Y');
set sql_safe_updates = 1;
set sql_safe_updates = 0;
update gl
set amount = replace(amount,',','');

-- chart of account


































































