-- create tables
CREATE TABLE IF NOT EXISTS time(
	timeid int not null identity(0,1),
	DateTime char(16),
	year smallint,
	month smallint,
	day smallint,
	hour smallint,
	minute smallint);

CREATE TABLE IF NOT EXISTS title(
	titleid int not null identity(0,1),
	title varchar(200));

CREATE TABLE IF NOT EXISTS site(
	siteid int not null identity(0,1),
	site varchar(200));

CREATE TABLE IF NOT EXISTS platform(
	platformid int not null identity(0,1),
	platform varchar(50));

CREATE TABLE IF NOT EXISTS staging(
	factid int not null identity(0,1),
	DateTime char(16) not null,
	title varchar(200) not null,
	site varchar(200) not null,
	platform varchar(50) not null);

CREATE TABLE IF NOT EXISTS fact(
	factid int not null identity(0,1),
	timeid int not null,
	titleid int not null,
	siteid int not null,
	platformid int not null);


-- COPY command to load data
COPY time ("DateTime", "year", "month", "day", "hour", "minute")
FROM 's3://jr-demo/processed/dim_time.csv'
credentials 'aws_iam_role=<arn>' 
CSV
IGNOREHEADER 1;

COPY site ("site")
FROM 's3://jr-demo/processed/dim_site.csv'
credentials 'aws_iam_role=<arn>' 
CSV
IGNOREHEADER 1;

COPY title ("title")
FROM 's3://jr-demo/processed/dim_title.csv'
credentials 'aws_iam_role=<arn>' 
CSV
IGNOREHEADER 1;

COPY platform ("platform")
FROM 's3://jr-demo/processed/dim_platform.csv'
credentials 'aws_iam_role=<arn>' 
CSV
IGNOREHEADER 1;

COPY staging ("DateTime", "title", "platform", "site")
FROM 's3://jr-demo/processed/fact.csv'
credentials 'aws_iam_role=<arn>' 
CSV
IGNOREHEADER 1;

-- remove duplicate in dimension table if appending new batch of data
delete from time where timeid > (select min(timeid) from time a where time.datetime = a.datetime);
delete from site where siteid > (select min(siteid) from site a where site.site = a.site);
delete from title where titleid > (select min(titleid) from title a where title.title = a.title);
delete from platform where platformid > (select min(platformid) from platform a where platform.platform = a.platform);

-- load fact from staging table to fact table
insert into fact (timeid, titleid, siteid, platformid)
select a.timeid, b.titleid, c.siteid, d.platformid
from staging e
left join time a 
on e.DateTime = a.DateTime
left join title b 
on e.title = b.title
left join site c 
on e.site = e.site
left join platform d 
on e.platform = d.platform;

TRUNCATE staging;
