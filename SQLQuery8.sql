create view 
gold.vm_dashboard_stock_performanc as 
select 
[Date],
[Open],
[High],
[Low],
[Close],
[Volume],
avg([Close]) over (order by [Date] rows between 59 preceding and current row) as [moving avg 60 days],
([High] - [Low]) as [daily volatility],
year([date]) as [stock year],
month([date]) as [stock month]
from silver.Stock_Data 

create view 
gold.vm_dashboard_financial_summary as
select
year([date]) as [revenue year],
[region],
[product_line],
sum([revenue_millions]) as [total revenue],
cast (sum([revenue_millions]) *100.0 / sum (sum([revenue_millions]))
over (partition by year([date])) as decimal (5,2)) as [region_contribution_pct]
from silver.Revenue
group by year([date]), [region] ,
[Product_Line];

go

create view 
gold.vm_dashboard_strategic_insights as
select
s.[date],
s.[close] as [stock price],
coalesce(r.[revenue_millions],0) as revenue,
s.[event],
case when year(s.[date]) <= 2006 then '1. domination era (market leader)'
when year(s.[date]) between 2007 and 2010 then '2. the iphone shock(intial decline)'
when year(s.[date]) between 2011 and 2013 then '3. the windows phone bet'
when year(s.[date]) > 2013 then 'transformation (infrastructue & 5G)' 
else 'other' 
end as [strategy phase]
from silver.stock_data s 
left join silver.revenue r on s.[date] = r.[date]