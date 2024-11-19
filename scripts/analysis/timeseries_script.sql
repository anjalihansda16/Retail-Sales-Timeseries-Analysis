select *
from clothing_business_sales.unadjusted;

/* Checking basic data information */  
select 
	COLUMN_NAME,
	IS_NULLABLE,
	DATA_TYPE
	DATA_TYPE
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'clothing_business_sales'
	and TABLE_NAME = 'unadjusted'

/* Data Overview */
select 
	distinct kind_of_business,
	count(*) as record_count
from clothing_business_sales.unadjusted
group by kind_of_business;

select *
from clothing_business_sales.unadjusted
where sales is null

select 
	min(sales_month),
	max(sales_month)
from clothing_business_sales.unadjusted
where kind_of_business = 'Women''s clothing stores'

select 
	min(sales_month),
	max(sales_month)
from clothing_business_sales.unadjusted
where kind_of_business = 'Men''s clothing stores'

/* Index the sales_month column */
create CLUSTERED INDEX IX_IndexName
ON clothing_business_sales.unadjusted(sales_month)

/* Data Profiling */

-- Monthly retail sales for clothing retail sales
select 
	sales_month, 
    sum(sales) as total_sales
from clothing_business_sales.unadjusted
group by sales_month
order by 1;

-- Yearly retail sales for clothing business to see trend without noise  
select 
	 year(sales_month) as sales_year, 
    sum(sales) as sales
from clothing_business_sales.unadjusted
group by year(sales_month)
order by 1;

/* Trend Analysis */
-- Yearly retail aggregate sales to see trend for mens and womens clothing separately without the nosie 
select 
	 year(sales_month) as sales_year, 
     kind_of_business, 
    sum(sales) as sales
from clothing_business_sales.unadjusted
group by year(sales_month), kind_of_business
order by 1;

/* Comparitive Analysis Between Segments  */
-- Calculating the gap between men's and women's clothing: Percentage difference between sales at womens to mens retail clothing stores 
select
	sales_year,
    (womens_sales/mens_sales - 1)*100 as womenes_pct_of_mens
from 
(
select 
	 year(sales_month) as sales_year, 
     sum(case when kind_of_business = 'Men''s clothing stores' then sales end) as mens_sales,
     sum(case when kind_of_business = 'Women''s clothing stores' then sales end) as womens_sales
from clothing_business_sales.unadjusted
group by year(sales_month)
) as a
order by 1;

/* Market Share */

-- Monthly Market Share
select 
	sales_month, 
    kind_of_business,
    sales, 
    sum(sales) over(partition by sales_month) as total_sales,
    sales*100/sum(sales) over(partition by sales_month) as pct_total
from clothing_business_sales.unadjusted;

-- Yearly Market Share
select 
    c1.sales_year,
    c1.kind_of_business,
    c1.yearly_sales * 100.0 / c2.total_sales as pct_of_yearly_sales
from 
    (select 
        year(sales_month) as sales_year,
        kind_of_business,
        sum(sales) as yearly_sales 
    from clothing_business_sales.unadjusted
    group by year(sales_month), kind_of_business) as c1
join 
    (select 
        year(sales_month) as sales_year,
        sum(sales) as total_sales
    from clothing_business_sales.unadjusted
    group by year(sales_month)) as c2
on c1.sales_year = c2.sales_year;

/* Economic Impact Analysis */

-- Indexed Analysis
select 
	sales_year,
	kind_of_business,
	sales,
	(sales/first_value(sales) over(partition by kind_of_business order by sales_year) -1)*100 as pct_from_sales
from
	(
	select 
		year(sales_month) as sales_year,                          
		kind_of_business,
		sum(sales) as sales
	from clothing_business_sales.unadjusted
	group by year(sales_month), kind_of_business
	) as a;
    
-- Rolling time window YTD Moving averages for the monthly reatail sales without seasonality 
select
	s.sales_month,
	s.sales,
	avg(m.sales) as moving_avg,
	count(m.sales) as records_count
from clothing_business_sales.unadjusted as s
join clothing_business_sales.unadjusted as m                                                             
on s.kind_of_business = m.kind_of_business
and m.sales_month between dateadd(month, -11, s.sales_month) and s.sales_month
and m.kind_of_business = 'Women''s clothing stores'
where s.kind_of_business = 'Women''s clothing stores'  
and s.sales_month >= '1993-01-01' 
group by s.sales_month, s.sales
order by s.sales_month; 

select
	s.sales_month,
	s.sales,
	avg(m.sales) as moving_avg,
	count(m.sales) as records_count
from clothing_business_sales.unadjusted as s
join clothing_business_sales.unadjusted as m                                                            
on s.kind_of_business = m.kind_of_business
and m.sales_month between dateadd(month, -11, s.sales_month) and s.sales_month
and m.kind_of_business = 'Men''s clothing stores'
where s.kind_of_business = 'Men''s clothing stores'  
and s.sales_month >= '1993-01-01' 
group by s.sales_month, s.sales
order by s.sales_month;

/* Performance: Period-over-Period comparisons*/

/* /* MoM */*/
select 
	kind_of_business, 
    sales_month, 
    sales, 
    (sales/lag(sales) over(partition by kind_of_business order by sales_month) - 1) * 100 as pct_growth_from_prev_month
from clothing_business_sales.unadjusted;

/*/* YoY */*/
select 
	kind_of_business,
	sales_year,
    yearly_sales,
    lag(yearly_sales) over(partition by kind_of_business order by sales_year) as prev_year_sales,
    (yearly_sales / lag(yearly_sales) over(partition by kind_of_business order by sales_year) - 1) * 100 as pct_growth_from_prev_year
from
(
select 
	kind_of_business,
	year(sales_month) as sales_year,
    sum(sales) as yearly_sales
from clothing_business_sales.unadjusted
group by kind_of_business, year(sales_month)
) as b
order by sales_year;

/*Period-over-Period comparisons */
/* Absolute difference and percentage difference of YoY sales for same month for previous year for women and mens separately */
select
	sales_month, 
    sales,
    sales - lag(sales) over(partition by month(sales_month) order by sales_month) as abs_diff, 
    (sales / lag(sales) over(partition by month(sales_month) order by sales_month) - 1) * 100 as pct_diff
from clothing_business_sales.unadjusted
where kind_of_business = 'Women''s clothing stores';


select
	sales_month, 
    sales,
    sales - lag(sales) over(partition by month(sales_month) order by sales_month) as abs_diff, 
    (sales / lag(sales) over(partition by month(sales_month) order by sales_month) - 1) * 100 as pct_diff
from clothing_business_sales.unadjusted
where kind_of_business = 'Men''s clothing stores';

/* Growth: Sale last few years, result set for visualization purpose */
select
	month(sales_month) as month_number,
    format(sales_month, 'MMMM') as month_name,
    max(case when year(sales_month) = 2016 then sales end) as sales_2016,
    max(case when year(sales_month) = 2017 then sales end) as sales_2017,
    max(case when year(sales_month) = 2018 then sales end) as sales_2018,
    max(case when year(sales_month) = 2019 then sales end) as sales_2019,
    max(case when year(sales_month) = 2020 then sales end) as sales_2020
from clothing_business_sales.unadjusted
where kind_of_business = 'Men''s clothing stores'
and year(sales_month) between 2015 and 2020
group by month(sales_month), format(sales_month, 'MMMM')
order by month_number;
	
select
	month(sales_month) as month_number,
    format(sales_month, 'MMMM') as month_name,
    max(case when year(sales_month) = 2015 then sales end) as sales_2015,
    max(case when year(sales_month) = 2016 then sales end) as sales_2016,
    max(case when year(sales_month) = 2017 then sales end) as sales_2017,
    max(case when year(sales_month) = 2018 then sales end) as sales_2018,
    max(case when year(sales_month) = 2019 then sales end) as sales_2019,
    max(case when year(sales_month) = 2020 then sales end) as sales_2020
from clothing_business_sales.unadjusted 
where kind_of_business = 'Women''s clothing stores'
and year(sales_month) between 2015 and 2020
group by month(sales_month), format(sales_month, 'MMMM');

