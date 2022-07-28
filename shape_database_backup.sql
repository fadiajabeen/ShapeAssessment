USE [master]
GO
/****** Object:  Database [Shape]    Script Date: 7/28/2022 7:13:03 PM ******/
CREATE DATABASE [Shape]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'shape', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\shape.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'shape_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\shape_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Shape] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Shape].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Shape] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Shape] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Shape] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Shape] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Shape] SET ARITHABORT OFF 
GO
ALTER DATABASE [Shape] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Shape] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Shape] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Shape] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Shape] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Shape] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Shape] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Shape] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Shape] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Shape] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Shape] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Shape] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Shape] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Shape] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Shape] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Shape] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Shape] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Shape] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Shape] SET  MULTI_USER 
GO
ALTER DATABASE [Shape] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Shape] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Shape] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Shape] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Shape] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Shape] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Shape] SET QUERY_STORE = OFF
GO
USE [Shape]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/28/2022 7:13:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Firstname] [nvarchar](24) NOT NULL,
	[Lastname] [nvarchar](24) NOT NULL,
	[Email] [varchar](320) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[PasswordUpdateRequired] [bit] NOT NULL,
	[CreatedDate] [smalldatetime] NOT NULL,
	[UpdatedDate] [smalldatetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLoginHistory]    Script Date: 7/28/2022 7:13:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLoginHistory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[LoginToken] [varchar](350) NULL,
	[IsLoggedIn] [bit] NOT NULL,
	[IP] [varchar](18) NULL,
	[LoginDate] [smalldatetime] NOT NULL,
	[LocalTimeHoursOffset] [decimal](3, 1) NOT NULL,
	[LogoutDate] [smalldatetime] NULL,
	[TokenExpiryDate] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UniqueEmail]    Script Date: 7/28/2022 7:13:03 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UniqueEmail] ON [dbo].[User]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_PasswordUpdateRequired]  DEFAULT ((0)) FOR [PasswordUpdateRequired]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_UpdatedDate]  DEFAULT (getutcdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[UserLoginHistory] ADD  CONSTRAINT [DF_UserLogin_IsLoggedIn]  DEFAULT ((0)) FOR [IsLoggedIn]
GO
ALTER TABLE [dbo].[UserLoginHistory] ADD  CONSTRAINT [DF_UserLogin_LoginDate]  DEFAULT (getutcdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[UserLoginHistory] ADD  CONSTRAINT [DF_Table_1_TimeZoneOffset]  DEFAULT ((0.0)) FOR [LocalTimeHoursOffset]
GO
ALTER TABLE [dbo].[UserLoginHistory]  WITH CHECK ADD  CONSTRAINT [FK_UserLogin_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLoginHistory] CHECK CONSTRAINT [FK_UserLogin_User]
GO
USE [master]
GO
ALTER DATABASE [Shape] SET  READ_WRITE 
GO
