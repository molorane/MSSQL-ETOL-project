USE [master]
GO
/****** Object:  Database [CSIS3714_FINAL]    Script Date: 5/18/17 5:35:58 PM ******/
CREATE DATABASE [CSIS3714_FINAL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CSIS3714_FINAL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CSIS3714_FINAL.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CSIS3714_FINAL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CSIS3714_FINAL_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CSIS3714_FINAL] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CSIS3714_FINAL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CSIS3714_FINAL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET ARITHABORT OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CSIS3714_FINAL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CSIS3714_FINAL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CSIS3714_FINAL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CSIS3714_FINAL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET RECOVERY FULL 
GO
ALTER DATABASE [CSIS3714_FINAL] SET  MULTI_USER 
GO
ALTER DATABASE [CSIS3714_FINAL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CSIS3714_FINAL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CSIS3714_FINAL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CSIS3714_FINAL] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CSIS3714_FINAL] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CSIS3714_FINAL', N'ON'
GO
USE [CSIS3714_FINAL]
GO
/****** Object:  UserDefinedFunction [dbo].[isValidIDNumber]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[isValidIDNumber]
(
	@StaffIDNumber NVarchar(13)
)
RETURNS BIT
AS
BEGIN
	Declare @DOB Varchar(6)
	DECLARE @LastSevenDigits Varchar(7)

	--Pattern to validate the last seven digits of an ID number
	DECLARE @Pattern NVarchar(35) = '[0-9][0-9][0-9][0-9][0-1][8-9][0-9]'

	--Get the first six digits of an ID number
	SET @DOB = LEFT(@StaffIDNumber,6)

	--Get the last seven digits of an ID number 
	SET @LastSevenDigits = RIGHT(@StaffIDNumber,7)


	IF(ISDATE(@DOB) = 1 AND @LastSevenDigits LIKE @Pattern)
		RETURN 1
	
	RETURN 0;
END
GO
/****** Object:  Table [dbo].[AuditTrailId]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditTrailId](
	[AuditTrain_Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditTrail_TableAffected] [nvarchar](100) NULL,
	[AuditTrail_PreviousValue] [nvarchar](100) NULL,
	[AutiTrail_NewValue] [nvarchar](100) NULL,
	[AuditTrail_UserId] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditTrain_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Benefit]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benefit](
	[BenefitID] [int] IDENTITY(1,1) NOT NULL,
	[Benefit_Name] [nvarchar](50) NULL,
	[Benefit_Desc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[BenefitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Benefit_Staff]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benefit_Staff](
	[BenefitID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[DateAssigned] [datetimeoffset](7) NOT NULL DEFAULT (sysdatetimeoffset()),
 CONSTRAINT [PK_StaffBenefit] PRIMARY KEY CLUSTERED 
(
	[BenefitID] ASC,
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [nvarchar](20) NOT NULL,
	[Cus_EAccount] [nvarchar](50) NULL,
	[Cus_FName] [nvarchar](50) NULL,
	[Cus_LName] [nvarchar](50) NULL,
	[Cus_ContactNumber] [nvarchar](20) NULL,
	[Cus_Email] [nvarchar](100) NULL,
	[Cus_BankAccNumber] [nvarchar](20) NULL,
	[Cus_BankCode] [nvarchar](10) NULL,
	[Cus_StreetNumber] [nvarchar](50) NULL,
	[Cus_StreetName] [nvarchar](100) NULL,
	[Cus_Area] [nvarchar](100) NULL,
	[Cus_City] [nvarchar](100) NULL,
	[Cus_Region] [nvarchar](100) NULL,
	[Cus_PostalCode] [nvarchar](50) NULL,
	[Cus_ProfilePic] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Degree]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Degree](
	[DegreeID] [int] IDENTITY(1,1) NOT NULL,
	[DegreeName] [nvarchar](100) NULL,
	[DegreeDesc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[DegreeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiscountRate]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountRate](
	[DRateID] [int] IDENTITY(1,1) NOT NULL,
	[DRate_StartDateTime] [datetime] NULL,
	[DRate_EndDateTime] [datetime] NULL,
	[DRate_Percentage] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[DRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DriverLicense]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DriverLicense](
	[CustomerID] [nvarchar](20) NOT NULL,
	[DLicense_Number] [nvarchar](50) NULL,
	[DLicense_ExpireDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Engineer]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Engineer](
	[StaffID] [int] NOT NULL,
	[Eng_YearsOfExperience] [int] NULL,
	[DegreeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[ErrorLog_Id] [int] IDENTITY(1,1) NOT NULL,
	[ErrorLog_Date] [datetime] NULL,
	[ErrorLog_Message] [varchar](8000) NULL,
	[ErrorLog_Severity] [int] NULL,
	[ErrorLog_Procedure] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorLog_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fines]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fines](
	[FineID] [int] IDENTITY(1,1) NOT NULL,
	[Fine_Name] [nvarchar](50) NULL,
	[Fine_Desc] [nvarchar](100) NULL,
	[Fine_Amount] [decimal](18, 2) NULL,
	[Fine_IsDefault] [bit] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[FineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gantry]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gantry](
	[GantryID] [int] IDENTITY(1,1) NOT NULL,
	[Gantry_Name] [nvarchar](100) NULL,
	[Gantry_Desc] [nvarchar](100) NULL,
	[Gantry_GPSLocation] [nvarchar](200) NULL,
	[ROfficeID] [int] NOT NULL,
	[TRateID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GantryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Manager]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[StaffID] [int] NOT NULL,
	[ManagerRoleId] [int] NULL,
	[Man_StaffManaged] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ManagerRole]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerRole](
	[ManagerRoleId] [int] IDENTITY(1,1) NOT NULL,
	[MRole_Desc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ManagerRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Municipality]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Municipality](
	[MunID] [int] IDENTITY(1,1) NOT NULL,
	[Mun_Name] [nvarchar](50) NULL,
	[Mun_Desc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MunID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PayID] [int] IDENTITY(1,1) NOT NULL,
	[Pay_DateTime] [datetimeoffset](7) NOT NULL DEFAULT (sysdatetimeoffset()),
	[Pay_Amount] [decimal](18, 2) NULL,
	[PayMethodID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethod](
	[PayMethodID] [int] IDENTITY(1,1) NOT NULL,
	[PayMethodDesc] [nvarchar](100) NULL,
	[PayMethod_ClearTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PayMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RegionOffice]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegionOffice](
	[ROfficeID] [int] IDENTITY(1,1) NOT NULL,
	[ROffice_Name] [nvarchar](100) NULL,
	[ROffice_Desc] [nvarchar](100) NULL,
	[ROffice_StreeNumber] [nvarchar](20) NULL,
	[ROffice_StreetName] [nvarchar](100) NULL,
	[ROffice_Area] [nvarchar](100) NULL,
	[ROffice_City] [nvarchar](100) NULL,
	[ROffice_Region] [nvarchar](100) NULL,
	[ROffice_PostalCode] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ROfficeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Staff]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [int] IDENTITY(1,1) NOT NULL,
	[Staff_PNumber] [nvarchar](100) NULL,
	[Staff_FName] [nvarchar](100) NULL,
	[Staff_LName] [nvarchar](100) NULL,
	[Staff_IDNumber] [nvarchar](20) NULL,
	[Staff_Type] [nvarchar](50) NULL,
	[Staff_Income] [decimal](18, 2) NULL,
	[ManagerID] [int] NULL,
	[ROfficeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Support]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Support](
	[StaffID] [int] NOT NULL,
	[SupportRoleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SupportRole]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportRole](
	[SupportRoleID] [int] IDENTITY(1,1) NOT NULL,
	[SRole_Desc] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupportRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TollRate]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TollRate](
	[TRateID] [int] IDENTITY(1,1) NOT NULL,
	[TRateName] [nvarchar](50) NULL,
	[TRateDesc] [nvarchar](100) NULL,
	[TRateAmount] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[TRateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TollTag]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TollTag](
	[TTagID] [int] IDENTITY(1,1) NOT NULL,
	[TTag_RFIDNumber] [nvarchar](20) NULL,
	[TTag_ManufactureDate] [datetimeoffset](7) NOT NULL DEFAULT (sysdatetimeoffset()),
	[TTag_Brand] [nvarchar](100) NULL,
	[CT_AssignedDate] [datetime] NULL,
	[CT_IsActive] [bit] NULL DEFAULT ((1)),
	[CustomerID] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[TTagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TollTransaction]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TollTransaction](
	[TTID] [int] IDENTITY(1,1) NOT NULL,
	[TT_DateTime] [datetimeoffset](7) NOT NULL DEFAULT (sysdatetimeoffset()),
	[TT_Amount] [decimal](18, 2) NULL,
	[TT_IsPaid] [bit] NULL DEFAULT ((0)),
	[TT_OnDiscount] [bit] NULL DEFAULT ((0)),
	[TT_VehicleRegistration] [nvarchar](20) NULL,
	[TTagID] [int] NULL DEFAULT ((-1)),
	[PayID] [int] NULL,
	[DRateID] [int] NULL,
	[GantryID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[UserPassword] [nvarchar](100) NULL,
	[RoleId] [nvarchar](100) NULL,
	[LastLoginDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleId] [nvarchar](100) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[IsDefault] [bit] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleFine]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleFine](
	[Vehicle_FineId] [int] IDENTITY(1,1) NOT NULL,
	[VF_DateTime] [datetimeoffset](7) NOT NULL DEFAULT (sysdatetimeoffset()),
	[VF_IsPaid] [bit] NULL DEFAULT ((0)),
	[VehicleID] [int] NOT NULL,
	[FineID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Vehicle_FineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VehicleRegistration]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleRegistration](
	[VehicleID] [int] IDENTITY(1,1) NOT NULL,
	[Vehicle_Name] [nvarchar](50) NULL,
	[Vehicle_Desc] [nvarchar](100) NULL,
	[Vehicle_Registration] [nvarchar](20) NULL,
	[CustomerID] [nvarchar](20) NOT NULL,
	[MunID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[SearchCustomer]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SearchCustomer]
(
	@CustomerSurname NVarchar(100)
)
RETURNS TABLE
AS
	RETURN (SELECT * FROM Customer WHERE Cus_LName LIKE '%'+@CustomerSurname+'%')


GO
SET IDENTITY_INSERT [dbo].[AuditTrailId] ON 

INSERT [dbo].[AuditTrailId] ([AuditTrain_Id], [AuditTrail_TableAffected], [AuditTrail_PreviousValue], [AutiTrail_NewValue], [AuditTrail_UserId]) VALUES (1, N'Customer', N'10001', N'10002', N'MOLORANEMOT109B\moloranemothusimicha')
SET IDENTITY_INSERT [dbo].[AuditTrailId] OFF
SET IDENTITY_INSERT [dbo].[Benefit] ON 

INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (1, N'Medical Aid', N'Medical help when staff sick')
INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (2, N'Pension Fund', N'Money paid to retired staff')
INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (3, N'Car Allowance', N'Car benefits for staff')
INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (4, N'Travell Allowance', N'Travel benefits for staff')
INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (5, N'Food Allowance', N'Food benefits for staff')
INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (6, N'Entertainment Budget', N'Staff entertainment')
INSERT [dbo].[Benefit] ([BenefitID], [Benefit_Name], [Benefit_Desc]) VALUES (7, N'Study Benefit', N'Study benfits for staff')
SET IDENTITY_INSERT [dbo].[Benefit] OFF
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (1, 1, CAST(N'2017-05-17T18:14:10.6286020+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (1, 4, CAST(N'2017-05-17T18:15:01.5461550+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (2, 1, CAST(N'2017-05-17T18:14:27.5047983+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (2, 7, CAST(N'2017-05-17T18:15:38.7804552+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (3, 1, CAST(N'2017-05-17T18:14:34.1481049+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (3, 4, CAST(N'2017-05-17T18:15:07.0617542+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (4, 1, CAST(N'2017-05-17T18:14:38.4762194+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (5, 1, CAST(N'2017-05-17T18:14:43.4604904+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (6, 4, CAST(N'2017-05-17T18:15:11.6711206+02:00' AS DateTimeOffset))
INSERT [dbo].[Benefit_Staff] ([BenefitID], [StaffID], [DateAssigned]) VALUES (6, 7, CAST(N'2017-05-17T18:15:34.6711050+02:00' AS DateTimeOffset))
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'1', N'10002', N'Mothusi', N'Molorane', N'0632347733', N'molorane.mothusi@gmail.com', N'62345', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'10', N'1001', N'Josiase', N'Reteng', N'0982444', N'josiase@gmail.com', N'63231313', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'2', N'20002', N'Sthe', N'Malindisa', N'082327323', N'the.malindisa@gmail.com', N'91381983', N'250655', N'320', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'3', N'30003', N'Sne', N'Sthekisa', N'0713183111', N'Sne.molind@gmail.com', N'024924', N'250655', N'322', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'4', N'40004', N'Thema', N'Mabaso', N'0634293283', N'Themba.mabaso@gmail.com', N'039039', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'5', N'50005', N'Vutha', N'Mola', N'08371371221', N'vutha.mola@gmail.com', N'098731', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'6', N'6006', N'Moli', N'Motloa', N'07813131', N'moli.mola@gmail.com', N'093131', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'7', N'7007', N'Thembi', N'Letooa', N'08663173', N'thembi@gmail.com', N'09873132', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'8', N'8008', N'Bucie', N'Sisewe', N'07131631', N'bucie@gmail.com', N'08716513', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
INSERT [dbo].[Customer] ([CustomerID], [Cus_EAccount], [Cus_FName], [Cus_LName], [Cus_ContactNumber], [Cus_Email], [Cus_BankAccNumber], [Cus_BankCode], [Cus_StreetNumber], [Cus_StreetName], [Cus_Area], [Cus_City], [Cus_Region], [Cus_PostalCode], [Cus_ProfilePic]) VALUES (N'9', N'90009', N'Lerato', N'Bereng', N'086136137', N'bereng@gmail.com', N'62394813', N'250655', N'220', N'Paul Kruger', N'12', N'Bloem', N'Mangaung', N'9301', N'')
SET IDENTITY_INSERT [dbo].[Degree] ON 

INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (1, N'Mechanical Engineer', N'Mechanical')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (2, N'Petrol Engineer', N'Crude OIL')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (3, N'Database Engineer', N'Database')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (4, N'Computer Engineer', N'Computer Engineer')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (5, N'Car Engineer', N'Car Engineer')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (6, N'Light Engineer', N'Light Engineer')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (7, N'Gantry Engineer', N'Gantry Engineer')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (8, N'Electrical Engineer', N'Electrical Engineer')
INSERT [dbo].[Degree] ([DegreeID], [DegreeName], [DegreeDesc]) VALUES (9, N'Software Engineer', N'Software Engineer')
SET IDENTITY_INSERT [dbo].[Degree] OFF
SET IDENTITY_INSERT [dbo].[DiscountRate] ON 

INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (1, CAST(N'2017-01-02 00:00:00.000' AS DateTime), CAST(N'2017-02-02 00:00:00.000' AS DateTime), CAST(20.00 AS Decimal(18, 2)))
INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (3, CAST(N'2017-03-03 00:00:00.000' AS DateTime), CAST(N'2017-03-12 00:00:00.000' AS DateTime), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (4, CAST(N'2017-04-04 00:00:00.000' AS DateTime), CAST(N'2017-04-10 00:00:00.000' AS DateTime), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (5, CAST(N'2017-04-04 00:00:00.000' AS DateTime), CAST(N'2017-04-11 00:00:00.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (7, CAST(N'2017-05-05 00:00:00.000' AS DateTime), CAST(N'2017-05-10 00:00:00.000' AS DateTime), CAST(23.00 AS Decimal(18, 2)))
INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (10, CAST(N'2017-05-10 00:00:00.000' AS DateTime), CAST(N'2017-05-13 00:00:00.000' AS DateTime), CAST(21.00 AS Decimal(18, 2)))
INSERT [dbo].[DiscountRate] ([DRateID], [DRate_StartDateTime], [DRate_EndDateTime], [DRate_Percentage]) VALUES (11, CAST(N'2017-04-04 00:00:00.000' AS DateTime), CAST(N'2017-04-30 00:00:00.000' AS DateTime), CAST(1.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[DiscountRate] OFF
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'1', N'39898131', CAST(N'2016-02-26' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'10', N'3009912', CAST(N'2016-04-05' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'2', N'5848131', CAST(N'2017-05-26' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'3', N'7648131', CAST(N'2017-01-20' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'4', N'98711', CAST(N'2017-06-20' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'5', N'8768711', CAST(N'2017-07-20' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'6', N'981100', CAST(N'2017-08-20' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'7', N'8001100', CAST(N'2017-03-20' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'8', N'6509912', CAST(N'2017-04-03' AS Date))
INSERT [dbo].[DriverLicense] ([CustomerID], [DLicense_Number], [DLicense_ExpireDate]) VALUES (N'9', N'53109912', CAST(N'2017-04-05' AS Date))
INSERT [dbo].[Engineer] ([StaffID], [Eng_YearsOfExperience], [DegreeID]) VALUES (16, 2, 4)
INSERT [dbo].[Engineer] ([StaffID], [Eng_YearsOfExperience], [DegreeID]) VALUES (17, 1, 1)
INSERT [dbo].[Engineer] ([StaffID], [Eng_YearsOfExperience], [DegreeID]) VALUES (18, 4, 3)
INSERT [dbo].[Engineer] ([StaffID], [Eng_YearsOfExperience], [DegreeID]) VALUES (19, 5, 6)
SET IDENTITY_INSERT [dbo].[ErrorLog] ON 

INSERT [dbo].[ErrorLog] ([ErrorLog_Id], [ErrorLog_Date], [ErrorLog_Message], [ErrorLog_Severity], [ErrorLog_Procedure]) VALUES (1, CAST(N'2017-05-17 18:23:14.660' AS DateTime), N'Divide by zero error encountered.', 16, NULL)
INSERT [dbo].[ErrorLog] ([ErrorLog_Id], [ErrorLog_Date], [ErrorLog_Message], [ErrorLog_Severity], [ErrorLog_Procedure]) VALUES (3, CAST(N'2017-05-17 18:28:47.953' AS DateTime), N'Conversion failed when converting the varchar value ''ke'' to data type int.', 16, NULL)
INSERT [dbo].[ErrorLog] ([ErrorLog_Id], [ErrorLog_Date], [ErrorLog_Message], [ErrorLog_Severity], [ErrorLog_Procedure]) VALUES (4, CAST(N'2017-05-17 18:29:41.137' AS DateTime), N'Cannot insert explicit value for identity column in table ''ErrorLog'' when IDENTITY_INSERT is set to OFF.', 16, NULL)
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
SET IDENTITY_INSERT [dbo].[Fines] ON 

INSERT [dbo].[Fines] ([FineID], [Fine_Name], [Fine_Desc], [Fine_Amount], [Fine_IsDefault]) VALUES (1, N'Not tag', N'Charge for no tag', CAST(50.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Fines] ([FineID], [Fine_Name], [Fine_Desc], [Fine_Amount], [Fine_IsDefault]) VALUES (2, N'Late toll payment', N'Charge for payment delay', CAST(20.00 AS Decimal(18, 2)), 0)
SET IDENTITY_INSERT [dbo].[Fines] OFF
SET IDENTITY_INSERT [dbo].[Gantry] ON 

INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1004, N'Paul Gantry', N'Paul Gantry', N'23.09,24.22', 1, 1)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1005, N'Bloem Gate1', N'bloem gate from JHB', N'23.191,23.31', 1, 1)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1006, N'Paul Gantry2', N'Paul Gantry2', N'13.23,22.22', 1, 2)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1007, N'Bloem Gate2', N'bloem gate2', N'10.191,12.31', 1, 2)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1008, N'CPT1', N'CPT Gantry1', N'23.23,22.22', 4, 1)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1009, N'CPT2', N'CPT2', N'11.191,10.31', 4, 1)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1010, N'JHB2', N'JHB2', N'23.43,21.33', 2, 1)
INSERT [dbo].[Gantry] ([GantryID], [Gantry_Name], [Gantry_Desc], [Gantry_GPSLocation], [ROfficeID], [TRateID]) VALUES (1011, N'JHB2', N'JHB2', N'23.43,21.33', 3, 1)
SET IDENTITY_INSERT [dbo].[Gantry] OFF
INSERT [dbo].[Manager] ([StaffID], [ManagerRoleId], [Man_StaffManaged]) VALUES (1, 6, 2)
INSERT [dbo].[Manager] ([StaffID], [ManagerRoleId], [Man_StaffManaged]) VALUES (4, 2, 1)
INSERT [dbo].[Manager] ([StaffID], [ManagerRoleId], [Man_StaffManaged]) VALUES (7, 5, 0)
INSERT [dbo].[Manager] ([StaffID], [ManagerRoleId], [Man_StaffManaged]) VALUES (8, 9, 0)
INSERT [dbo].[Manager] ([StaffID], [ManagerRoleId], [Man_StaffManaged]) VALUES (10, 4, 0)
SET IDENTITY_INSERT [dbo].[ManagerRole] ON 

INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (1, N'Office Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (2, N'Finance Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (3, N'Department Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (4, N'HR Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (5, N'IT Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (6, N'Company Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (7, N'Gantry Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (8, N'Registrations Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (9, N'EToll Manager')
INSERT [dbo].[ManagerRole] ([ManagerRoleId], [MRole_Desc]) VALUES (10, N'Support Manager')
SET IDENTITY_INSERT [dbo].[ManagerRole] OFF
SET IDENTITY_INSERT [dbo].[Municipality] ON 

INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (1, N'Mangaung', N'Free state region')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (2, N'Lejoeleputswa', N'Welkom')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (3, N'Puthalitjaba', N'Free state region')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (4, N'Fezile', N'Sasolburg')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (5, N'Xareip', N'Trompsburg')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (6, N'Tswelopele', N'Bulfontein')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (7, N'Setsoto', N'Ficksburg')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (8, N'Tokologo', N'Boshof')
INSERT [dbo].[Municipality] ([MunID], [Mun_Name], [Mun_Desc]) VALUES (9, N'Kopanong', N'Trompsburg')
SET IDENTITY_INSERT [dbo].[Municipality] OFF
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (1, CAST(N'2017-05-15T03:21:15.1259264+02:00' AS DateTimeOffset), CAST(30.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (2, CAST(N'2017-05-15T03:21:15.1726844+02:00' AS DateTimeOffset), CAST(4.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (3, CAST(N'2017-05-15T03:22:10.1899727+02:00' AS DateTimeOffset), CAST(30.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (4, CAST(N'2017-05-15T03:22:10.1899727+02:00' AS DateTimeOffset), CAST(20.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (5, CAST(N'2017-05-15T03:22:37.5650695+02:00' AS DateTimeOffset), CAST(10.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (6, CAST(N'2017-05-15T03:22:37.5650695+02:00' AS DateTimeOffset), CAST(40.00 AS Decimal(18, 2)), 2)
INSERT [dbo].[Payment] ([PayID], [Pay_DateTime], [Pay_Amount], [PayMethodID]) VALUES (7, CAST(N'2017-05-17T23:32:14.8454078+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[Payment] OFF
SET IDENTITY_INSERT [dbo].[PaymentMethod] ON 

INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (1, N'Card', CAST(N'2017-05-14 21:17:31.593' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (2, N'Cash', CAST(N'2017-05-14 21:17:40.217' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (3, N'Cheque', CAST(N'2017-05-14 21:18:08.570' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (4, N'Bank Transfer', CAST(N'2017-05-14 21:18:29.193' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (5, N'Gift Card', CAST(N'2017-05-14 21:19:14.810' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (6, N'Dynamic Payment', CAST(N'2017-05-14 21:19:40.343' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (7, N'eWallet', CAST(N'2017-05-14 21:19:49.560' AS DateTime))
INSERT [dbo].[PaymentMethod] ([PayMethodID], [PayMethodDesc], [PayMethod_ClearTime]) VALUES (8, N'Pay Pal', CAST(N'2017-05-15 02:30:03.593' AS DateTime))
SET IDENTITY_INSERT [dbo].[PaymentMethod] OFF
SET IDENTITY_INSERT [dbo].[RegionOffice] ON 

INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (1, N'Free State', N'Paul lekaba office', N'230', N'Phase 2', N'Phase', N'Bloem', N'Mangaung', N'9300')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (2, N'Free State', N'Botsabelo office', N'430', N'Litaleng', N'Village Square', N'Botsabelo', N'Botsabelo', N'1313')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (3, N'Free State', N'Thaba Ntso', N'231', N'Leratong', N'Leratong', N'Thaba Ntso', N'Thaba Ntso', N'9181')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (4, N'Cape Town', N'CP TWN', N'1342', N'CTGate', N'CPTWN', N'Cape', N'Darlings', N'9821')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (5, N'Cape Town', N'CP TWN', N'1234', N'CT Mountain', N'CPTWN', N'Cape', N'Leratong', N'231')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (6, N'Cape Town', N'CP TWN', N'09871', N'Table Mountain', N'CPTWN', N'Cape', N'Little Darlings', N'8891')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (7, N'Gauteng', N'Bloem TWN', N'09871', N'Bradwag', N'Bloem', N'East Bloem', N'Tsuo', N'01131')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (8, N'Gauteng', N'Bloem TWN', N'0831', N'Krugerland', N'Bloem', N'West Bloem', N'The State', N'0813')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (9, N'Gauteng', N'Gauteng TWN', N'0831', N'Centurion', N'JHB', N'West', N'The State', N'98731')
INSERT [dbo].[RegionOffice] ([ROfficeID], [ROffice_Name], [ROffice_Desc], [ROffice_StreeNumber], [ROffice_StreetName], [ROffice_Area], [ROffice_City], [ROffice_Region], [ROffice_PostalCode]) VALUES (10, N'Gauteng', N'Gauteng Main Bridge', N'098313', N'Centurion', N'JHB', N'West', N'Leratong', N'0811')
SET IDENTITY_INSERT [dbo].[RegionOffice] OFF
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (1, N'MM901831', N'Nel', N'Koze', N'78022498131', N'Manager', CAST(45000.00 AS Decimal(18, 2)), NULL, 1)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (4, N'JM816131', N'Jaco', N'Marias', N'81022498131', N'Manager', CAST(30000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (7, N'SD8161211', N'Strott', N'DBD', N'45022498131', N'Manager', CAST(28000.00 AS Decimal(18, 2)), 4, 1)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (8, N'PB1261211', N'Peter', N'Blignault', N'68022498131', N'Manager', CAST(28000.00 AS Decimal(18, 2)), 1, 5)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (10, N'VL1261211', N'Vutha', N'Lerato', N'93022498131', N'Manager', CAST(10000.00 AS Decimal(18, 2)), NULL, 4)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (11, N'TM9261211', N'Tsepo', N'Mohapi', N'95022498131', N'Support', CAST(1000.00 AS Decimal(18, 2)), NULL, 2)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (13, N'TT9761211', N'Thembi', N'Thoko', N'99022498131', N'Support', CAST(500.00 AS Decimal(18, 2)), NULL, 2)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (14, N'BC9761211', N'Bucie', N'Lucricia', N'96022298131', N'Support', CAST(5000.00 AS Decimal(18, 2)), NULL, 4)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (15, N'TM9261211', N'Themba', N'Mabaso', N'81022298131', N'Support', CAST(5500.00 AS Decimal(18, 2)), NULL, 3)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (16, N'RA901725', N'Mothusi', N'Molorane', N'910504183716', N'Engineer', CAST(80000.00 AS Decimal(18, 2)), NULL, 8)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (17, N'RA86110', N'Felleng', N'Molorane', N'950504183716', N'Engineer', CAST(60000.00 AS Decimal(18, 2)), NULL, 8)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (18, N'BR46110', N'Moketsi', N'Mohapi', N'820504183716', N'Engineer', CAST(20000.00 AS Decimal(18, 2)), NULL, 3)
INSERT [dbo].[Staff] ([StaffID], [Staff_PNumber], [Staff_FName], [Staff_LName], [Staff_IDNumber], [Staff_Type], [Staff_Income], [ManagerID], [ROfficeID]) VALUES (19, N'HK09131', N'Setsomi', N'Morati', N'870204183716', N'Engineer', CAST(10000.00 AS Decimal(18, 2)), NULL, 3)
SET IDENTITY_INSERT [dbo].[Staff] OFF
INSERT [dbo].[Support] ([StaffID], [SupportRoleId]) VALUES (11, 2)
INSERT [dbo].[Support] ([StaffID], [SupportRoleId]) VALUES (13, 1)
INSERT [dbo].[Support] ([StaffID], [SupportRoleId]) VALUES (14, 6)
INSERT [dbo].[Support] ([StaffID], [SupportRoleId]) VALUES (15, 7)
SET IDENTITY_INSERT [dbo].[SupportRole] ON 

INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (1, N'Data capturer')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (2, N'Registrar')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (3, N'IT Assistant')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (4, N'Database Administrator')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (5, N'Software Engineer')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (6, N'Gantry Maintainer')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (7, N'eToll Producer')
INSERT [dbo].[SupportRole] ([SupportRoleID], [SRole_Desc]) VALUES (8, N'Car Registrar')
SET IDENTITY_INSERT [dbo].[SupportRole] OFF
SET IDENTITY_INSERT [dbo].[TollRate] ON 

INSERT [dbo].[TollRate] ([TRateID], [TRateName], [TRateDesc], [TRateAmount]) VALUES (1, N'Charge', N'Normal Charge', CAST(2.50 AS Decimal(18, 2)))
INSERT [dbo].[TollRate] ([TRateID], [TRateName], [TRateDesc], [TRateAmount]) VALUES (2, N'Charge', N'Severe Charge', CAST(10.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[TollRate] OFF
SET IDENTITY_INSERT [dbo].[TollTag] ON 

INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (1, N'RF7812', CAST(N'2017-05-15T02:52:07.3238586+02:00' AS DateTimeOffset), N'TTLaser', CAST(N'2017-05-15 02:52:07.327' AS DateTime), 1, N'1')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (4, N'UBT123', CAST(N'2017-05-15T03:26:51.8631760+02:00' AS DateTimeOffset), N'TTLaser', CAST(N'2017-05-15 03:26:51.867' AS DateTime), 1, N'3')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (6, N'UBT124', CAST(N'2017-05-15T03:27:06.6888215+02:00' AS DateTimeOffset), N'TTLaser', CAST(N'2017-05-15 03:27:06.687' AS DateTime), 1, N'4')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (8, N'UBT125', CAST(N'2017-05-15T03:27:37.2074661+02:00' AS DateTimeOffset), N'TTLaser', CAST(N'2017-05-15 03:27:37.207' AS DateTime), 1, N'6')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (9, N'UBT134', CAST(N'2017-05-15T03:27:50.3182552+02:00' AS DateTimeOffset), N'TTLaser', CAST(N'2017-05-15 03:27:50.317' AS DateTime), 1, N'8')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (10, N'UBT191', CAST(N'2017-05-17T01:31:35.8864069+02:00' AS DateTimeOffset), N'TTAnalog', CAST(N'2017-05-17 01:31:35.890' AS DateTime), 1, N'1')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (12, N'UBT9090', CAST(N'2017-05-17T01:32:01.0113735+02:00' AS DateTimeOffset), N'TTAnalog', CAST(N'2017-05-17 01:32:01.010' AS DateTime), 1, N'1')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (13, N'UBT8907', CAST(N'2017-05-17T01:32:20.2770187+02:00' AS DateTimeOffset), N'TTAnalog', CAST(N'2017-05-17 01:32:20.277' AS DateTime), 1, N'2')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (14, N'UBT8612', CAST(N'2017-05-17T01:32:35.1206964+02:00' AS DateTimeOffset), N'TTAnalog', CAST(N'2017-05-17 01:32:35.120' AS DateTime), 1, N'2')
INSERT [dbo].[TollTag] ([TTagID], [TTag_RFIDNumber], [TTag_ManufactureDate], [TTag_Brand], [CT_AssignedDate], [CT_IsActive], [CustomerID]) VALUES (15, N'UBT76154', CAST(N'2017-05-17T01:32:44.4956638+02:00' AS DateTimeOffset), N'TTAnalog', CAST(N'2017-05-17 01:32:44.483' AS DateTime), 1, N'3')
SET IDENTITY_INSERT [dbo].[TollTag] OFF
SET IDENTITY_INSERT [dbo].[TollTransaction] ON 

INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (1, CAST(N'2017-04-15T03:34:30.3972665+02:00' AS DateTimeOffset), CAST(50.00 AS Decimal(18, 2)), 1, 0, NULL, 4, 3, NULL, 1004)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (2, CAST(N'2017-03-15T03:37:16.3132772+02:00' AS DateTimeOffset), CAST(60.00 AS Decimal(18, 2)), 1, 0, NULL, 1, 4, NULL, 1005)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (3, CAST(N'2017-05-15T03:38:28.7636028+02:00' AS DateTimeOffset), CAST(30.00 AS Decimal(18, 2)), 1, 0, NULL, 9, 5, NULL, 1008)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (5, CAST(N'2017-03-16T17:17:58.9641723+02:00' AS DateTimeOffset), CAST(50.00 AS Decimal(18, 2)), 0, 0, NULL, 1, NULL, NULL, 1004)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (6, CAST(N'2017-02-16T17:18:48.1876831+02:00' AS DateTimeOffset), CAST(5.00 AS Decimal(18, 2)), 0, 0, NULL, 1, NULL, NULL, 1007)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (7, CAST(N'2017-04-16T17:19:25.8811175+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 0, 0, NULL, 1, NULL, NULL, 1006)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (9, CAST(N'2017-05-16T17:55:00.2670514+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 0, 0, NULL, 4, NULL, NULL, 1009)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (11, CAST(N'2017-05-16T17:55:17.6685670+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 0, 0, NULL, 6, NULL, NULL, 1009)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (13, CAST(N'2017-05-16T17:55:36.9188443+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 0, 0, NULL, 8, NULL, NULL, 1008)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (16, CAST(N'2017-05-16T17:56:01.4400217+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 0, 0, NULL, 4, NULL, NULL, 1004)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (17, CAST(N'2017-05-17T21:44:07.4597045+02:00' AS DateTimeOffset), CAST(3.50 AS Decimal(18, 2)), 0, 0, N'', 9, NULL, NULL, 1005)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (23, CAST(N'2017-05-17T22:00:29.7389725+02:00' AS DateTimeOffset), CAST(3.50 AS Decimal(18, 2)), 0, 0, N'MBG188', NULL, NULL, NULL, 1005)
INSERT [dbo].[TollTransaction] ([TTID], [TT_DateTime], [TT_Amount], [TT_IsPaid], [TT_OnDiscount], [TT_VehicleRegistration], [TTagID], [PayID], [DRateID], [GantryID]) VALUES (37, CAST(N'2017-05-17T23:32:14.8454078+02:00' AS DateTimeOffset), CAST(2.50 AS Decimal(18, 2)), 1, 0, N'HJH267', NULL, 7, NULL, 1006)
SET IDENTITY_INSERT [dbo].[TollTransaction] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (1, N'Blessing', N'123', N'1', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (2, N'Admin', N'123', N'1', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (3, N'Mary', N'123', N'9', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (4, N'Peter', N'123', N'8', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (5, N'Lerato', N'123', N'3', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (6, N'Themba', N'123', N'6', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (7, N'Neil', N'123', N'2', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (8, N'Strott', N'123', N'4', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (9, N'Jacobus', N'123', N'5', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (10, N'Marias', N'123', N'10', NULL)
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [RoleId], [LastLoginDate]) VALUES (21, N'Jesus', N'0d5399508427ce79556cda71918020c1e8d15b53', N'8', NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'1', N'ADMIN', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'10', N'Registrar', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'2', N'MANAGER', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'3', N'MODERATOR', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'4', N'SUPPORT', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'5', N'IT', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'6', N'HR', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'7', N'Engineer', 0)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'8', N'USER', 1)
INSERT [dbo].[UserRole] ([RoleId], [RoleName], [IsDefault]) VALUES (N'9', N'FINANCE', 0)
SET IDENTITY_INSERT [dbo].[VehicleFine] ON 

INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (1, CAST(N'2017-05-15T02:41:05.6484680+02:00' AS DateTimeOffset), 0, 1, 1)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (2, CAST(N'2017-05-15T02:41:20.6297457+02:00' AS DateTimeOffset), 0, 2, 1)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (4, CAST(N'2017-05-15T02:41:56.4855026+02:00' AS DateTimeOffset), 0, 7, 1)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (5, CAST(N'2017-05-17T21:33:45.1719480+02:00' AS DateTimeOffset), 0, 3, 2)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (6, CAST(N'2017-05-17T21:34:25.1325455+02:00' AS DateTimeOffset), 0, 3, 1)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (9, CAST(N'2017-05-17T21:35:02.4762461+02:00' AS DateTimeOffset), 0, 2, 2)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (13, CAST(N'2017-05-17T21:35:43.9072551+02:00' AS DateTimeOffset), 0, 6, 1)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (14, CAST(N'2017-05-17T21:35:50.1940424+02:00' AS DateTimeOffset), 0, 6, 2)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (15, CAST(N'2017-05-17T21:36:07.4239474+02:00' AS DateTimeOffset), 0, 8, 1)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (16, CAST(N'2017-05-17T21:36:14.6644508+02:00' AS DateTimeOffset), 0, 8, 2)
INSERT [dbo].[VehicleFine] ([Vehicle_FineId], [VF_DateTime], [VF_IsPaid], [VehicleID], [FineID]) VALUES (20, CAST(N'2017-05-17T23:32:14.8454078+02:00' AS DateTimeOffset), 0, 3, 1)
SET IDENTITY_INSERT [dbo].[VehicleFine] OFF
SET IDENTITY_INSERT [dbo].[VehicleRegistration] ON 

INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (1, N'Jeep', N'Jeep', N'MOLO2', N'1', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (2, N'BMW X5', N'BMW', N'RGN8912', N'2', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (3, N'AMG 62', N'Mercedes Benz', N'HJH267', N'2', 2)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (6, N'ML 63', N'Mercedes Benz', N'MH1781', N'4', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (7, N'Toyota 200', N'Toyota', N'JTU9818', N'5', 2)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (8, N'Mazda 7', N'Mazda', N'UY9012', N'6', 3)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (9, N'VW Polo', N'VW', N'TWG5671', N'7', 2)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (10, N'VW GTI', N'VW', N'THG16121', N'8', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (11, N'Ford Ranger', N'Ford', N'FRD0971', N'9', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (12, N'Porsche Sirene', N'Porsche', N'FRN 7611 FS', N'1', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (13, N'Polo VIVO', N'VW', N'FGN 781 FS', N'2', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (14, N'AMG 231', N'Benz', N'Blessy FS', N'1', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (15, N'Ferari', N'Benz', N'Blessy2 FS', N'1', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (16, N'Mazda', N'Mazda', N'HJG 787 FS', N'4', 2)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (17, N'BMW', N'BMW', N'RTH 787 FS', N'4', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (18, N'Toyota', N'Toyota', N'TYT 987 FS', N'6', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (19, N'Chevrolet', N'SS', N'CGT 876 FS', N'6', 2)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (20, N'Lamboghin', N'Lamboghin', N'LKJ 124 FS', N'6', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (21, N'Lamboghin', N'Lamboghin', N'MNJ 092 FS', N'3', 1)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (22, N'BMW', N'X5 M', N'KLH 092 FS', N'3', 2)
INSERT [dbo].[VehicleRegistration] ([VehicleID], [Vehicle_Name], [Vehicle_Desc], [Vehicle_Registration], [CustomerID], [MunID]) VALUES (23, N'Jeep', N'Cherokee', N'FGI 654 FS', N'1', 1)
SET IDENTITY_INSERT [dbo].[VehicleRegistration] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_CustomerEmail]    Script Date: 5/18/17 5:35:58 PM ******/
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [UK_CustomerEmail] UNIQUE NONCLUSTERED 
(
	[Cus_Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_DriverLicenseNumber]    Script Date: 5/18/17 5:35:58 PM ******/
ALTER TABLE [dbo].[DriverLicense] ADD  CONSTRAINT [UK_DriverLicenseNumber] UNIQUE NONCLUSTERED 
(
	[DLicense_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_StaffIDNumber]    Script Date: 5/18/17 5:35:58 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [UK_StaffIDNumber] UNIQUE NONCLUSTERED 
(
	[Staff_IDNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_TagRFIDNumber]    Script Date: 5/18/17 5:35:58 PM ******/
ALTER TABLE [dbo].[TollTag] ADD  CONSTRAINT [UK_TagRFIDNumber] UNIQUE NONCLUSTERED 
(
	[TTag_RFIDNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Users_UserName]    Script Date: 5/18/17 5:35:58 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UK_Users_UserName] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_VehicleRegistration]    Script Date: 5/18/17 5:35:58 PM ******/
ALTER TABLE [dbo].[VehicleRegistration] ADD  CONSTRAINT [UK_VehicleRegistration] UNIQUE NONCLUSTERED 
(
	[Vehicle_Registration] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Benefit_Staff]  WITH CHECK ADD  CONSTRAINT [FK_BenefitStaff] FOREIGN KEY([BenefitID])
REFERENCES [dbo].[Benefit] ([BenefitID])
GO
ALTER TABLE [dbo].[Benefit_Staff] CHECK CONSTRAINT [FK_BenefitStaff]
GO
ALTER TABLE [dbo].[Benefit_Staff]  WITH CHECK ADD  CONSTRAINT [FK_StaffBenefit] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Benefit_Staff] CHECK CONSTRAINT [FK_StaffBenefit]
GO
ALTER TABLE [dbo].[DriverLicense]  WITH CHECK ADD  CONSTRAINT [FK_StaffLicense] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[DriverLicense] CHECK CONSTRAINT [FK_StaffLicense]
GO
ALTER TABLE [dbo].[Engineer]  WITH CHECK ADD  CONSTRAINT [FK_EngineerExperience] FOREIGN KEY([DegreeID])
REFERENCES [dbo].[Degree] ([DegreeID])
GO
ALTER TABLE [dbo].[Engineer] CHECK CONSTRAINT [FK_EngineerExperience]
GO
ALTER TABLE [dbo].[Engineer]  WITH CHECK ADD  CONSTRAINT [FK_StaffEngineer] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Engineer] CHECK CONSTRAINT [FK_StaffEngineer]
GO
ALTER TABLE [dbo].[Gantry]  WITH CHECK ADD  CONSTRAINT [FK_GantryOffice] FOREIGN KEY([ROfficeID])
REFERENCES [dbo].[RegionOffice] ([ROfficeID])
GO
ALTER TABLE [dbo].[Gantry] CHECK CONSTRAINT [FK_GantryOffice]
GO
ALTER TABLE [dbo].[Gantry]  WITH CHECK ADD  CONSTRAINT [FK_GantryTallRate] FOREIGN KEY([TRateID])
REFERENCES [dbo].[TollRate] ([TRateID])
GO
ALTER TABLE [dbo].[Gantry] CHECK CONSTRAINT [FK_GantryTallRate]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_MangerRole] FOREIGN KEY([ManagerRoleId])
REFERENCES [dbo].[ManagerRole] ([ManagerRoleId])
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_MangerRole]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_StaffManger] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_StaffManger]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_PaymentMethod] FOREIGN KEY([PayMethodID])
REFERENCES [dbo].[PaymentMethod] ([PayMethodID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_PaymentMethod]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_UserManager] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_UserManager]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_UserRegion] FOREIGN KEY([ROfficeID])
REFERENCES [dbo].[RegionOffice] ([ROfficeID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_UserRegion]
GO
ALTER TABLE [dbo].[Support]  WITH CHECK ADD  CONSTRAINT [FK_StaffSupport] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Support] CHECK CONSTRAINT [FK_StaffSupport]
GO
ALTER TABLE [dbo].[Support]  WITH CHECK ADD  CONSTRAINT [FK_StaffSupportRole] FOREIGN KEY([SupportRoleId])
REFERENCES [dbo].[SupportRole] ([SupportRoleID])
GO
ALTER TABLE [dbo].[Support] CHECK CONSTRAINT [FK_StaffSupportRole]
GO
ALTER TABLE [dbo].[TollTag]  WITH CHECK ADD  CONSTRAINT [FK_CustomerToll] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[TollTag] CHECK CONSTRAINT [FK_CustomerToll]
GO
ALTER TABLE [dbo].[TollTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TTransactionGantry] FOREIGN KEY([GantryID])
REFERENCES [dbo].[Gantry] ([GantryID])
GO
ALTER TABLE [dbo].[TollTransaction] CHECK CONSTRAINT [FK_TTransactionGantry]
GO
ALTER TABLE [dbo].[TollTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TTransactionPayment] FOREIGN KEY([PayID])
REFERENCES [dbo].[Payment] ([PayID])
GO
ALTER TABLE [dbo].[TollTransaction] CHECK CONSTRAINT [FK_TTransactionPayment]
GO
ALTER TABLE [dbo].[TollTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TTransactionTollRate] FOREIGN KEY([DRateID])
REFERENCES [dbo].[DiscountRate] ([DRateID])
GO
ALTER TABLE [dbo].[TollTransaction] CHECK CONSTRAINT [FK_TTransactionTollRate]
GO
ALTER TABLE [dbo].[TollTransaction]  WITH CHECK ADD  CONSTRAINT [FK_TTransactionTollTag] FOREIGN KEY([TTagID])
REFERENCES [dbo].[TollTag] ([TTagID])
GO
ALTER TABLE [dbo].[TollTransaction] CHECK CONSTRAINT [FK_TTransactionTollTag]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_UserInRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[UserRole] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_UserInRole]
GO
ALTER TABLE [dbo].[VehicleFine]  WITH CHECK ADD  CONSTRAINT [FK_VehicleFine] FOREIGN KEY([FineID])
REFERENCES [dbo].[Fines] ([FineID])
GO
ALTER TABLE [dbo].[VehicleFine] CHECK CONSTRAINT [FK_VehicleFine]
GO
ALTER TABLE [dbo].[VehicleFine]  WITH CHECK ADD  CONSTRAINT [FK_VehicleFineRegistration] FOREIGN KEY([VehicleID])
REFERENCES [dbo].[VehicleRegistration] ([VehicleID])
GO
ALTER TABLE [dbo].[VehicleFine] CHECK CONSTRAINT [FK_VehicleFineRegistration]
GO
ALTER TABLE [dbo].[VehicleRegistration]  WITH CHECK ADD  CONSTRAINT [FK_CustomerVehicle] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[VehicleRegistration] CHECK CONSTRAINT [FK_CustomerVehicle]
GO
ALTER TABLE [dbo].[VehicleRegistration]  WITH CHECK ADD  CONSTRAINT [FK_VehicleMunicipality] FOREIGN KEY([MunID])
REFERENCES [dbo].[Municipality] ([MunID])
GO
ALTER TABLE [dbo].[VehicleRegistration] CHECK CONSTRAINT [FK_VehicleMunicipality]
GO
/****** Object:  StoredProcedure [dbo].[GeneratePassoword]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GeneratePassoword]
    @Passlen int,
    @RandomPassword varchar(8) output
as 
BEGIN
    declare @char char
    set @RandomPassword = ''

	
	--Do not allow the following Characters
    DECLARE @NotAllowCharacters varchar(50) = '[]`^\/0:;<=>?@O'
 
    while @Passlen > 0 begin
       select @char = char(round(rand() * 100, 0))
       if charindex(@char, @NotAllowCharacters) = 0 begin
           set @RandomPassword += @char
           set @Passlen = @Passlen - 1
       end
    end
END
GO
/****** Object:  StoredProcedure [dbo].[spAddAuditTrail]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddAuditTrail]
@AuditTrail_TableAffected NVarchar(100),
@AuditTrail_PreviousValue NVarchar(100),
@AutiTrail_NewValue NVarchar(100)
AS
BEGIN
	
	INSERT INTO AuditTrailId(AuditTrail_TableAffected,AuditTrail_PreviousValue,AutiTrail_NewValue,AuditTrail_UserId)
				VALUES(@AuditTrail_TableAffected,@AuditTrail_PreviousValue,@AutiTrail_NewValue,SUSER_SNAME())

END
GO
/****** Object:  StoredProcedure [dbo].[spAddEditBenefits]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddEditBenefits]
@BenefitID int = -1,
@Benefit_Name NVarchar(100),
@Benefit_Desc NVarchar(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				IF EXISTS(SELECT BenefitID FROM Benefit WHERE BenefitID = @BenefitID)
					BEGIN
						UPDATE Benefit SET 
							Benefit_Name = @Benefit_Name,
							Benefit_Desc = @Benefit_Desc
							WHERE BenefitID = @BenefitID
					END
				ELSE
					BEGIN
						INSERT INTO Benefit(Benefit_Name,Benefit_Desc) 
								VALUES(@Benefit_Name,@Benefit_Desc)
					END
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddEditGantries]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddEditGantries]
@GantryID int = -1,
@Gantry_Name NVarchar(100),
@Gantry_Desc NVarchar(100),
@Gantry_GPSLocation NVarchar(100),
@ROfficeID INT,
@TRateID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				--Check if the Gantry with the ID @GantryID already Exist
				-- If it exist, Update the Gantry Information
				-- If it doesn't exist Insert a new gantry
				IF EXISTS(SELECT GantryID FROM Gantry WHERE GantryID = @GantryID)
					BEGIN
						UPDATE Gantry SET 
							Gantry_Name = @Gantry_Name,
							Gantry_Desc = @Gantry_Desc,
							Gantry_GPSLocation = @Gantry_GPSLocation,
							ROfficeID = @ROfficeID,
							TRateID = @TRateID
							WHERE GantryID = @GantryID
					END
				ELSE
					BEGIN
						INSERT INTO Gantry(Gantry_Name,Gantry_Desc,Gantry_GPSLocation,ROfficeID,TRateID) 
								VALUES(@Gantry_Name,@Gantry_Desc,@Gantry_GPSLocation,@ROfficeID,@TRateID)
					END
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddEditQualifications]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddEditQualifications]
@DegreeID int = -1,
@DegreeName NVarchar(100),
@DegreeDesc NVarchar(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				IF EXISTS(SELECT DegreeID FROM Degree WHERE DegreeID = @DegreeID)
					BEGIN
						UPDATE Degree SET 
							DegreeName = @DegreeName,
							DegreeDesc = @DegreeDesc
							WHERE DegreeID = @DegreeID
					END
				ELSE
					BEGIN
						INSERT INTO Degree(DegreeName,DegreeDesc) 
								VALUES(@DegreeName,@DegreeDesc)
					END
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddEditVehicleRegistration]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddEditVehicleRegistration]
@VehicleID INT,
@Vehicle_Name NVarchar(100),
@Vehicle_Desc NVarchar(100),
@Vehicle_Registration NVarchar(20),
@CustomerID INT,
@MunID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				IF EXISTS(SELECT VehicleID FROM VehicleRegistration WHERE VehicleID = @VehicleID)
					BEGIN

						DECLARE @PreviousCustmerID NVarchar(20)

						--Get Old CustomerID
						SELECT @PreviousCustmerID = CustomerID 
								FROM VehicleRegistration
							    WHERE VehicleID = @VehicleID
						
						--Check if vehicle is not changing from one owner to another
						--IF the vehicle is not changing ownership(Previous CustomerID = Current given @CustomerID)
						--Update vehicle details
						IF( @PreviousCustmerID = @CustomerID )
							BEGIN
								UPDATE VehicleRegistration 
									SET Vehicle_Name = @Vehicle_Name,Vehicle_Desc = @Vehicle_Desc, Vehicle_Registration = @Vehicle_Registration,MunID = @MunID
										WHERE VehicleID = @VehicleID AND CustomerID = @CustomerID			
							END
						ELSE
							BEGIN
								--IF the vehicle is changing ownership(Previous CustomerID <> Current given @CustomerID)
								--Then, we can have two OPTIONS
								-- 1. Update the CustomerID to the New owner, thereby Inheriting the fines of the previous owner
								-- 2. Or, Insert a new vehicle registration thereby not inheriting the fines
								
								-- OPTION 1
								UPDATE VehicleRegistration 
									SET Vehicle_Name = @Vehicle_Name,Vehicle_Desc = @Vehicle_Desc,MunID = @MunID,CustomerID = @CustomerID
										WHERE Vehicle_Registration = @Vehicle_Registration


								-- OPTION 2
								--Inserting new record INTO Vehicle Registration will 
								--    *Generate new Vehicle ID for new owner
								--    *With new CustomerID
								--    *But VehicleRegistration no is for the previous owner
								--    *This will prevent new owner from inheriting the fines of the previous owner
								--	   Because the new Customer has new VehicleID which is a foreign Key in VehicleFines
								INSERT INTO VehicleRegistration(Vehicle_Name,Vehicle_Desc,Vehicle_Registration,CustomerID,MunID) 
									VALUES(@Vehicle_Name,@Vehicle_Desc,@Vehicle_Registration,@CustomerID,@MunID)


							END

					END
				ELSE
				BEGIN
					INSERT INTO VehicleRegistration(Vehicle_Name,Vehicle_Desc,Vehicle_Registration,CustomerID,MunID) 
							VALUES(@Vehicle_Name,@Vehicle_Desc,@Vehicle_Registration,@CustomerID,@MunID)
				END
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddStaffRecord]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddStaffRecord]
@Staff_PNumber NVarchar(13),
@Staff_IDNumber NVarchar(13),
@Staff_FName NVarchar(100),
@Staff_LName NVarchar(100),
@Staff_Type NVarchar(20), -- Manager/Engineer/Support
@Staff_Income DECIMAL(18,2),
@ManagerID INT = null,
@ROfficeID INT = null,

@RoleID INT, -- RoleID of new staff if is(Manager/Support)

--Egineer Details if this staff is an engineer
@YearsOFExperince INT,
@DegreeID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

			DECLARE @StaffID INT;

			--IF ID Number is not valid
			--Terminate the transaction and stop
			IF(dbo.isValidIDNumber(@Staff_IDNumber) = 0)
				RETURN

			--Insert new Staff
			INSERT INTO Staff(Staff_PNumber,Staff_FName,Staff_LName,Staff_IDNumber,Staff_Type,Staff_Income,ManagerID,ROfficeID)
				   VALUES(@Staff_PNumber,@Staff_IDNumber,@Staff_FName,@Staff_LName,@Staff_Type,@Staff_Income,@ManagerID,@ROfficeID)
			
			--Get new StaffID
			SELECT @StaffID = SCOPE_IDENTITY()

			-- IF Staff is an Engineer
			-- Record Engineer details
			IF(@Staff_Type = 'Engineer')
			BEGIN
				
				INSERT INTO Engineer(StaffID,Eng_YearsOfExperience,DegreeID)
					   VALUES(@StaffID,@YearsOFExperince,@DegreeID)

				IF(@@ROWCOUNT = 0)
					ROLLBACK; RETURN
			END

			-- IF Staff is a Manager
			-- Record Manager details
			IF(@Staff_Type = 'Manager')
			BEGIN
				
				--Get the number of staff managed by new staff
				DECLARE @Man_StaffManaged INT;
				SELECT @Man_StaffManaged = COUNT(StaffID) FROM Staff WHERE ManagerID = @StaffID


				--If inserting staff for the first time
				INSERT INTO Manager(StaffID,ManagerRoleId,Man_StaffManaged)
					   VALUES(@StaffID,@RoleID,@Man_StaffManaged)
				
				--If Staff already exist it could be updated
				--As follows
				UPDATE Manager SET Man_StaffManaged = @Man_StaffManaged WHERE StaffID = @StaffID

				--Check whether transaction was successful depending on whether
				--it was an insert(new staff) or an update of (existing staff)
				IF(@@ROWCOUNT = 0)
					ROLLBACK; RETURN
			END

			-- IF Staff is a Support
			-- Record Support details
			IF(@Staff_Type = 'Support')
			BEGIN
				
				INSERT INTO Support(StaffID,SupportRoleId)
					   VALUES(@StaffID,@RoleID)

				IF(@@ROWCOUNT = 0)
					ROLLBACK; RETURN
			END

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

		ROLLBACK;

		SELECT ERROR_MESSAGE(),
				ERROR_LINE(),
				ERROR_NUMBER(),
				ERROR_PROCEDURE()
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddTollTransaction]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddTollTransaction]
@TT_Amount DECIMAL(18,2),
@TT_VehicleRegistration NVarchar(20) = NULL,
@TTagID INT,
@DRateID INT,
@GantryID INT,
@FineID INT  = -1, --When FineID is not specified set it to -1

--Payment Details if payment is made(@@isPaymentMade = 1)
@isPaymentMade BIT = 1, -- Assume payment is also made
@PaymentMethodID INT = -1, --Assume no paymentmethod
@ActualAmountPaid DECIMAL(18,2) = 0.00
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				
			DECLARE @TTOnDiscount INT = 0;  --Assume No dicount rate
			DECLARE @TagIDDetected INT = -1; --Assume No tag was detected
			DECLARE @NewTTID INT
			DECLARE @NewPayID INT

			--Check if TransactionDate Falls within Discount Rate
			Select DRateID FROM DiscountRate  
					WHERE DRateID = @DRateID AND 
					GETDATE() BETWEEN DRate_StartDateTime AND DRate_EndDateTime

			IF(@@ROWCOUNT >= 1)
					SET @TTOnDiscount = 1;

			--Check IF Tag is detected(IF TTagID exists in TollTag Entity)
			IF(EXISTS(SELECT TTagID FROM TollTag WHERE TTagID = @TTagID))
				SET @TagIDDetected = @TTagID
	
			-- THE FOLLOWING FIELDS ARE NOT SPECIFIED BECAUSE
			-- TTID -> is an Identity Key
			-- TT_DateTime -> configured to take CurrentTimeStamp from SQL Server
			-- TT_IsPaid -> has a default value 0 at transaction creation, meaning transaction not paid yet
			IF(@TagIDDetected = -1)
				INSERT INTO TollTransaction(TT_Amount,TT_OnDiscount,TT_VehicleRegistration,TTagID,PayID,DRateID,GantryID)
						VALUES(@TT_Amount,@TTOnDiscount,@TT_VehicleRegistration,NULL,NULL,@DRateID,@GantryID);
			ELSE
				INSERT INTO TollTransaction(TT_Amount,TT_OnDiscount,TT_VehicleRegistration,TTagID,PayID,DRateID,GantryID)
						VALUES(@TT_Amount,@TTOnDiscount,@TT_VehicleRegistration,@TagIDDetected,NULL,@DRateID,@GantryID);
			
			SELECT @NewTTID = SCOPE_IDENTITY()

			--If payment is also made
			--If yes meaning (@@isPaymentMade = 1) 
			IF(@isPaymentMade = 1)
			BEGIN
				INSERT INTO Payment(Pay_Amount,PayMethodID) VALUES(@ActualAmountPaid,@PaymentMethodID)

				SELECT @NewPayID = SCOPE_IDENTITY()
			
				UPDATE TollTransaction SET TT_IsPaid = 1,PayID = @NewPayID WHERE TTID = @NewTTID
			END

			--IF No tag was detected issue a fine
			--Given VehicleRegistration Number, Find VehicleID that has the given registration number
			--Call a stored procedure (spAddVehicleFine) to issue a fine
			IF(@TagIDDetected = -1)
			BEGIN
				DECLARE @VehicleID INT;
				
				SELECT @VehicleID = VehicleID FROM VehicleRegistration
								WHERE Vehicle_Registration = @TT_VehicleRegistration

				IF(@@ROWCOUNT >= 1)
					EXEC spAddVehicleFine @VehicleID,@FineID
				ELSE	
					ROLLBACK
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK --Undo changes
		SELECT ERROR_MESSAGE(),ERROR_LINE(),ERROR_PROCEDURE(),ERROR_NUMBER()
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddUser]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddUser]
@UserName NVarchar(100),
@Password NVarchar(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @HashedPassword NVarchar(100)
			DECLARE @NewUserID INT
			DECLARE @RoleId NVarchar(100)
			
			-- Get Default RoleId
			SELECT @RoleId = RoleId FROM UserRole WHERE IsDefault = 1

			SET @HashedPassword = sys.fn_varbintohexsubstring(0, HashBytes('SHA1', @Password), 1, 0)
			--After INSERT the trigger called 'trAssignUserRole' will be executed 
			--To assign a user to a default Role	
			INSERT INTO "User"(UserName,UserPassword,RoleId)
						VALUES(@UserName,@HashedPassword,@RoleId)

			SELECT @NewUserID = SCOPE_IDENTITY()
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spAddVehicleFine]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddVehicleFine]
@VehicleID int,
@FineID INT = -1 
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				--IF the Fine is not specified (FineID = -1), 
				--Check the default fine from Fines Entity
				IF(@FineID = -1)
					BEGIN
						DECLARE @DefaultFineID INT

						SELECT @DefaultFineID = FineID FROM Fines WHERE Fine_IsDefault = 1

						IF(@@ROWCOUNT >= 1)
						BEGIN
							-- THE FOLLOWING FIELDS ARE NOT SPECIFIED BECAUSE
							-- Vehicle_FineId -> is an Identity Key
							-- VF_IsPaid -> has a default value 0 at fine creation, meaning fine not paid yet
							-- VF_DateTime -> configured to take CurrentTimeStamp from SQL Server

							INSERT INTO VehicleFine(VehicleID,FineID)
									VALUES(@VehicleID,@DefaultFineID)
						END
					END
				ELSE
					BEGIN
						INSERT INTO VehicleFine(VehicleID,FineID)
									VALUES(@VehicleID,@FineID)
					END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK --Undo changes
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spCustomerAccount]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCustomerAccount]
@CustomerID NVarchar(13)
AS
BEGIN
	
	DECLARE @VehicleReg NVarchar(30)
	DECLARE @DateTime DATETIME
	DECLARE @Charge DECIMAL(18,2)
	DECLARE @IsPaid varchar
	DECLARE @EAccount INT
	DECLARE @Balance DECIMAL(18,2)
	DECLARE @Cus_Area NVarchar(40)
	DECLARE @Cus_City NVarchar(40)
	DECLARE @Cus_StreetName NVarchar(60)
	DECLARE @Cus_StreetNumber NVarchar(40)
	DECLARE @Cus_FName NVarchar(40)
	DECLARE @Cus_LName NVarchar(40)
	DECLARE @PrintDate DATETIME
	DECLARE @EAccountFromSystem INT


	-- Assume the Dynamic temporary Table Called SystemVariable has already been Created
	-- AND ITS LAST Value is 20993
	CREATE TABLE #SystemVariable(EAccount INT)

	-- Insert virtual value to represent last stored value
	INSERT INTO #SystemVariable VALUES(20993)

	--Extract the last stored value from the Temporary table SystemVariable
	--Store it in Variable @EAccount
	SELECT @EAccountFromSystem = EAccount FROM #SystemVariable

	CREATE TABLE #TollPayments(VReg Nvarchar(20),TT_DateTime DATETIME,Charge DECIMAL(18,2),IsPaid varchar,
	Balance DECIMAL(18,2),Area nvarchar(40),City nvarchar(40),StreetName NVarchar(40),StreetNumber NVarchar(10),
	FName NVarchar(40),LName NVarchar(40),EAccount Nvarchar(20),PrintDate DATETIME)

	DECLARE CustomerAccount CURSOR FOR
		SELECT vr.Vehicle_Registration as 'Vehicle Reg',
				Convert(DATETIME,tt.TT_DateTime) as 'Date/Time',
				tt.TT_Amount as Charge,
				CASE tt.TT_IsPaid
					WHEN 0 THEN 'N'
					ELSE 'Y'
				END as Paid,
				-1*(SELECT SUM(TT_Amount) FROM TollTransaction WHERE TTagID = tt.TTagID AND TT_IsPaid = 0) as Balance,
				c.Cus_Area,
				c.Cus_City,
				c.Cus_StreetName,
				c.Cus_StreetNumber,
				c.Cus_FName,
				c.Cus_LName,
				@EAccountFromSystem as EAccount,
				Convert(DATE,GETDATE()) as PrintDate
				FROM TollTransaction tt
				JOIN  TollTag tl
				ON tt.TTagID = tl.TTagID
				JOIN Customer c
				ON tl.CustomerID = c.CustomerID
				JOIN VehicleRegistration vr
				ON c.CustomerID = vr.CustomerID
				WHERE c.CustomerID = @CustomerID AND DATEDIFF(DAY,CONVERT(DATETIME,tt.TT_DateTime),GETDATE()) > 30

	OPEN CustomerAccount

	FETCH NEXT FROM CustomerAccount INTO @VehicleReg,@DateTime,@Charge,@IsPaid,@Balance,@Cus_Area,@Cus_City,@Cus_StreetName,
						@Cus_StreetNumber,@Cus_FName,@Cus_LName,@EAccount,@PrintDate

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		
		--insert record into temporary table
		INSERT INTO #TollPayments VALUES( @VehicleReg,@DateTime,@Charge,@IsPaid,@Balance,@Cus_Area,@Cus_City,@Cus_StreetName,
						@Cus_StreetNumber,@Cus_FName,@Cus_LName,@EAccount,@PrintDate)

		FETCH NEXT FROM CustomerAccount INTO @VehicleReg,@DateTime,@Charge,@IsPaid,@Balance,@Cus_Area,@Cus_City,@Cus_StreetName,
						@Cus_StreetNumber,@Cus_FName,@Cus_LName,@EAccount,@PrintDate

	END


	--UPDATE THE Account Number 
	-- Increment it by 1
	SET @EAccountFromSystem = @EAccountFromSystem + 1;
	UPDATE #SystemVariable SET EAccount = @EAccountFromSystem

	CLOSE CustomerAccount
	DEALLOCATE CustomerAccount

	--Return All records in the temporary table to a calling application
	SELECT * FROM #TollPayments
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteBenefit]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteBenefit]
@BenefitID int
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				DELETE FROM Benefit WHERE BenefitID = @BenefitID
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK --Undo changes
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[spETagOwnership]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spETagOwnership]
AS
BEGIN
	SELECT  tt.CustomerID,
			c.Cus_FName,
			c.Cus_LName,
			(SELECT COUNT(vr.VehicleID)
				FROM VehicleRegistration vr
				WHERE vr.CustomerID = tt.CustomerID
				GROUP BY vr.CustomerID) as VehiclesOwned,
				COUNT(tt.TTagID) as eTagsPurchased
			FROM TollTag tt	
			JOIN Customer c
			ON tt.CustomerID = c.CustomerID
			GROUP BY tt.CustomerID,c.Cus_FName,c.Cus_LName
			HAVING COUNT(tt.TTagID) <> (SELECT COUNT(vr.VehicleID) 
												FROM VehicleRegistration vr
												WHERE vr.CustomerID = tt.CustomerID
												GROUP BY vr.CustomerID)
END
GO
/****** Object:  StoredProcedure [dbo].[spExpiredDriversLicense]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spExpiredDriversLicense]
AS
BEGIN
	
	SELECT c.CustomerID,c.Cus_FName,c.Cus_LName,dl.DLicense_ExpireDate as ExpiredDate
	FROM Customer c
	JOIN DriverLicense dl
	ON c.CustomerID = dl.CustomerID
	WHERE c.CustomerID IN (SELECT CustomerID FROM VehicleRegistration)
	AND dl.DLicense_ExpireDate < Convert(DATE,GETDATE())

END
GO
/****** Object:  StoredProcedure [dbo].[spGeneratePassword]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGeneratePassword]  
@LengthOfPassword INT 
AS
BEGIN


	DECLARE @Password     VARCHAR(20)
	DECLARE @ValidCharacters   VARCHAR(100)
	DECLARE @PasswordIndex    INT
	DECLARE @CharacterIndex   INT


	SET @ValidCharacters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890*'


	SET @PasswordIndex = 1
	SET @Password = ''


	WHILE @PasswordIndex <= @LengthOfPassword
	BEGIN
	 SELECT @CharacterIndex = ABS(CAST(CAST(RAND() AS VARBINARY) AS INT)) % 
	LEN(@ValidCharacters) + 1

	 SET @Password = @Password + SUBSTRING(@ValidCharacters, @CharacterIndex, 1)


	 SET @PasswordIndex = @PasswordIndex + 1
	END


	SELECT @Password
END

GO
/****** Object:  StoredProcedure [dbo].[spInActiveLastMonth]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spInActiveLastMonth]
AS
BEGIN
	SELECT * FROM "User" WHERE MONTH(LastLoginDate) = MONTH(DATEADD(mm,DATEDIFF(mm,0,GETDATE())-1,0))
END
GO
/****** Object:  StoredProcedure [dbo].[spInvalidIDsReport]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInvalidIDsReport]
AS
BEGIN
	SELECT * FROM Customer WHERE dbo.isValidIDNumber(CustomerID) = 0
END
GO
/****** Object:  StoredProcedure [dbo].[spMaintainErrorLog]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMaintainErrorLog]
@ErrorMessage VARCHAR(5000),
@ErrorSeverity INT,
@ErrorProcedure VARCHAR(100)
AS
BEGIN
	
	INSERT INTO ErrorLog(ErrorLog_Date,ErrorLog_Message,ErrorLog_Severity,ErrorLog_Procedure)
				VALUES(GETDATE(),@ErrorMessage,@ErrorSeverity,@ErrorProcedure)
	
	--How I will Call StoredProcedure(spMaintainErrorLog) from another StoredProcedure
	--The Below code will be in the body of the calling storedProcedure
	
	/*
		BEGIN TRY
		
			-- Complex code comes in here
			-- If any error occurs while executing any code segment in here(TRY block)
			-- Control will be send to CATCH block to execute statements in the CATCH block 
			

		END TRY
		BEGIN CATCH
		
			-- Normally ROLLBACK statement is placed here, to undo Changes done in the TRY block 
			-- This is done to maintain data integrtity,leaving a database in the consistent state

			**Ultimately i will call the storedProcedure in here as shown below**

			DECLARE @ErrorMessage VARCHAR(5000)
			DECLARE @ErrorSeverity INT
			DECLARE @ErrorProcedure VARCHAR(100)

			SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(),@ErrorProcedure = ERROR_PROCEDURE()

			EXECUTE spMaintainErrorLog @ErrorMessage,@ErrorSeverity,@ErrorProcedure

		END CATCH
	*/
END
GO
/****** Object:  StoredProcedure [dbo].[spMaintainLastLogin]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMaintainLastLogin]
@UserName NVarchar(50),
@Password NVarchar(200),
@ErrorMessage NVarchar(200) OUTPUT
AS
BEGIN
	
	--Add Field to the User entity called LastLoginDate--
	/*	
		ALTER TABLE "User"
		ADD LastLoginDate DATETIME;
	*/

	SELECT * 
		FROM "User" 
		WHERE UserName = @UserName AND 
		UserPassword = sys.fn_varbintohexsubstring(0, HashBytes('SHA1', @Password), 1, 0)

	IF(@@ROWCOUNT <> 0)
		-- Update LastLoginDate after successful login
		UPDATE "User" SET LastLoginDate = GETDATE() WHERE UserName = @UserName
	ELSE
		SET @ErrorMessage = 'Either the password is incorrect or the Username does not exist'
END

GO
/****** Object:  StoredProcedure [dbo].[spNoneComplianceReport]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spNoneComplianceReport]
AS
BEGIN
	SELECT c.Cus_FName as FirstName,c.Cus_LName as LastName,c.Cus_Email as Email,c.Cus_ContactNumber as ContactNumber
	FROM Customer c
	INNER JOIN VehicleRegistration vg
	ON c.CustomerID = vg.CustomerID
	INNER JOIN VehicleFine vf
	ON vg.VehicleID = vf.VehicleID
	LEFT JOIN TollTag tt
	ON c.CustomerID = tt.CustomerID
	WHERE tt.CustomerID IS NULL
	ORDER BY c.Cus_LName,c.Cus_FName
END
GO
/****** Object:  StoredProcedure [dbo].[spOutStandingTollsReport]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spOutStandingTollsReport]
AS
BEGIN
	
	SELECT ro.ROffice_Region, SUM(tt.TT_Amount) as OutStanding
		FROM RegionOffice ro
		JOIN Gantry g
		ON ro.ROfficeID = g.ROfficeID
		JOIN TollTransaction tt
		ON g.GantryID = tt.GantryID
		WHERE tt.TT_IsPaid = 0
		GROUP BY ro.ROffice_Region
END
GO
/****** Object:  StoredProcedure [dbo].[spPopularRegionReport]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPopularRegionReport]
AS
BEGIN
	SELECT ro.ROffice_Name as RegionNane,COUNT(tt.TTID) as TotalTolls 
	FROM RegionOffice ro
	JOIN Gantry g
	ON g.ROfficeID = ro.ROfficeID
	JOIN TollTransaction tt
	ON g.GantryID = tt.GantryID
	GROUP BY ro.ROffice_Name
END
GO
/****** Object:  StoredProcedure [dbo].[spSMSDailyReport]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSMSDailyReport]
AS
BEGIN

	DECLARE @id NVarchar(13)
	DECLARE @Email NVarchar(100)
	DECLARE @FullNames NVarchar(100)
	DECLARE @CellNumber NVarchar(20)
	DECLARE @TTagID INT
	DECLARE @DaysBalance DECIMAL(18,2)
	DECLARE @TotalBalance DECIMAL(18,2)

	DECLARE @MessageBody NVarchar(1000);

	SELECT TOP 1 @id  =  c.CustomerID, @Email = c.Cus_Email,@FullNames = c.Cus_FName+' '+c.Cus_LName,@CellNumber = c.Cus_ContactNumber,
				@TTagID = tt.TTagID 
				FROM Customer c
				JOIN TollTag tt 
				ON c.CustomerID = tt.CustomerID
				JOIN TollTransaction tl
				ON tt.TTagID = tl.TTagID
				ORDER BY c.CustomerID

	WHILE @id IS NOT NULL
	BEGIN

	  SELECT @DaysBalance = (SUM(tt.TT_Amount) - SUM(p.Pay_Amount))
					FROM TollTransaction tt
					JOIN Payment p
					ON tt.PayID = p.PayID
					WHERE tt.TTagID = @TTagID
					AND Convert(date,tt.TT_DateTime) = Convert(date, getdate())
					GROUP BY tt.TT_DateTime

  
	  SELECT @TotalBalance = (SUM(tt.TT_Amount) - SUM(p.Pay_Amount))
					FROM TollTransaction tt
					JOIN Payment p
					ON tt.PayID = p.PayID
					WHERE tt.TTagID = @TTagID
					GROUP BY tt.TTagID

		--Check whether the aggregate values are NULL
		--IF NULL set to 0.00
		IF(@DaysBalance IS NULL)
			SET @DaysBalance = 0.00

		IF(@TotalBalance IS NULL)
			SET @TotalBalance = 0.00
	
		SET @MessageBody = @CellNumber + ' , '+@FullNames+' you have '+Convert(varchar(10),@DaysBalance)+
						 ' for '+ Convert(Varchar(13),Convert(date, getdate()))+' and a total toll balance of '+Convert(varchar(10),@TotalBalance)

	  ---SEND EMAIL TO CUSTOMER
		EXEC msdb.dbo.sp_send_dbmail
		 @profile_name = 'SMSDailyReport',
		 @recipients = @Email,
		 @body = @MessageBody,
		 @subject = 'Tolls Owing Reminder';
	  ---END MAIL

	  --IF we also want to return the list to calling application
	  SELECT @CellNumber as CellNumber,@FullNames as FullNames,@DaysBalance as BalanceToday,@TotalBalance as TotalBalance

	  SELECT  TOP 1 @id  =  c.CustomerID, @Email = c.Cus_Email,@FullNames = c.Cus_FName+' '+c.Cus_LName,@CellNumber = c.Cus_ContactNumber, 
				@TTagID = tt.TTagID 
				FROM Customer c
				JOIN TollTag tt 
				ON c.CustomerID = tt.CustomerID
				JOIN TollTransaction tl
				ON tt.TTagID = tl.TTagID 
				WHERE c.CustomerID > @id
				ORDER BY c.CustomerID
	  IF @@ROWCOUNT = 0
	  BREAK

	END
END
GO
/****** Object:  StoredProcedure [dbo].[spStaffPerRegionOffice]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spStaffPerRegionOffice]
AS
BEGIN
	
	SELECT ro.ROffice_Name as Region,s.Staff_Type,COUNT(s.StaffID) as Number
		 FROM RegionOffice ro
		 JOIN Staff s
		 ON ro.ROfficeID = s.ROfficeID
		 GROUP BY ROffice_Name,Staff_Type
		 ORDER BY ROffice_Name,Staff_Type
END
GO
/****** Object:  Trigger [dbo].[trCustomerAfterUpdate]    Script Date: 5/18/17 5:35:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trCustomerAfterUpdate]
ON [dbo].[Customer]
FOR UPDATE
AS
BEGIN
	DECLARE @AuditTrail_PreviousValue NVarchar(20)
	DECLARE @AuditTrail_NewValue NVarchar(20)


	SELECT @AuditTrail_NewValue = i.Cus_EAccount,
			@AuditTrail_PreviousValue = d.Cus_EAccount
			FROM inserted i
			JOIN deleted d
			ON i.CustomerID = d.CustomerID

	EXECUTE spAddAuditTrail 'Customer',@AuditTrail_PreviousValue,@AuditTrail_NewValue
END
GO
USE [master]
GO
ALTER DATABASE [CSIS3714_FINAL] SET  READ_WRITE 
GO
