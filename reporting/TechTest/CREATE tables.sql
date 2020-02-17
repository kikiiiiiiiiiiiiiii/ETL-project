CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL,
	[FullDate] [date] NOT NULL,
	[DayNameAbrev] [nvarchar](50) NOT NULL,
	[WeekMonSun] [nvarchar](50) NOT NULL,
	[WeekMonSunNumber] [tinyint] NOT NULL,
	[WeekMonSunDate] [date] NOT NULL,
	[WeekSunSat] [nvarchar](50) NULL,
	[WeekSunSatNumber] [tinyint] NULL,
	[WeekSunSatDate] [date] NULL,
	[CalendarMonth] [nvarchar](50) NOT NULL,
	[CalendarMonthNumber] [tinyint] NOT NULL,
	[CalendarQuarter] [nvarchar](50) NOT NULL,
	[CalendarQuarterNumber] [tinyint] NOT NULL,
	[CalendarYear] [nvarchar](50) NOT NULL,
	[CalendarYearNumber] [smallint] NOT NULL,
	[FiscalMonth] [nvarchar](50) NOT NULL,
	[FiscalMonthNumber] [tinyint] NOT NULL,
	[FiscalQuarter] [nvarchar](50) NOT NULL,
	[FiscalQuarterNumber] [tinyint] NOT NULL,
	[FiscalYear] [nvarchar](50) NOT NULL,
	[FiscalYearNumber] [smallint] NOT NULL,
	[IsLastDayOfMonth] [bit] NOT NULL,
	[IsWorkDay] [bit] NOT NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[DimDevice](
	[DeviceKey] [int] IDENTITY(1,1) NOT NULL,
	[DeviceID] [nvarchar](200) NOT NULL,
	[DeviceName] [nvarchar](100) NOT NULL,
	[DeviceType] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[DimLedger](
	[LedgerKey] [int] NOT NULL,
	[LedgerName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[DimProduct](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [nvarchar](500) NOT NULL,
	[ProductName] [nvarchar](500) NOT NULL,
	[EditorialLevel1] [nvarchar](200) NOT NULL,
	[EditorialLevel2] [nvarchar](200) NOT NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[FactPagePerformance](
	[DateKey] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
	[DeviceKey] [int] NOT NULL,
	[LedgerKey] [int] NOT NULL,
	[PageViews] [int] NOT NULL,
	[Visits] [int] NOT NULL,
	[UniqueVisitors] [int] NOT NULL
) ON [PRIMARY]

