USE [master]
GO
/****** Object:  Database [SimpleBilling]    Script Date: 6/24/2023 12:12:02 AM ******/
CREATE DATABASE [SimpleBilling]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SimpleBilling', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SimpleBilling.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SimpleBilling_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SimpleBilling_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SimpleBilling] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleBilling].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleBilling] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleBilling] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleBilling] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleBilling] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleBilling] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleBilling] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleBilling] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleBilling] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleBilling] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleBilling] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleBilling] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleBilling] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleBilling] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleBilling] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleBilling] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SimpleBilling] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleBilling] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleBilling] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleBilling] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleBilling] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleBilling] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SimpleBilling] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleBilling] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SimpleBilling] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleBilling] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleBilling] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleBilling] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleBilling] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SimpleBilling] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SimpleBilling] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SimpleBilling] SET QUERY_STORE = OFF
GO
USE [SimpleBilling]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 6/24/2023 12:12:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 6/24/2023 12:12:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[BillNo] [nvarchar](50) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TotalDiscount] [decimal](18, 2) NOT NULL,
	[TotalBillAmount] [decimal](18, 2) NOT NULL,
	[DueAmount] [decimal](18, 2) NOT NULL,
	[PaidAmount] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryProduct]    Script Date: 6/24/2023 12:12:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InventoryId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
	[Discount] [decimal](18, 2) NOT NULL,
	[Qty] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/24/2023 12:12:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Rate] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 
GO
INSERT [dbo].[Customer] ([Id], [Name], [Address], [Phone]) VALUES (1, N'John Doe', N'123 Main St', N'123-456-7890')
GO
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 
GO
INSERT [dbo].[Inventory] ([Id], [Date], [BillNo], [CustomerId], [TotalDiscount], [TotalBillAmount], [DueAmount], [PaidAmount]) VALUES (1, CAST(N'2023-06-01T00:00:00.000' AS DateTime), N'INV-001', 1, CAST(5.00 AS Decimal(18, 2)), CAST(50.00 AS Decimal(18, 2)), CAST(45.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Inventory] ([Id], [Date], [BillNo], [CustomerId], [TotalDiscount], [TotalBillAmount], [DueAmount], [PaidAmount]) VALUES (2, CAST(N'2023-06-02T00:00:00.000' AS DateTime), N'INV-002', 1, CAST(2.50 AS Decimal(18, 2)), CAST(75.00 AS Decimal(18, 2)), CAST(72.50 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[InventoryProduct] ON 
GO
INSERT [dbo].[InventoryProduct] ([Id], [InventoryId], [ProductId], [Rate], [Discount], [Qty]) VALUES (1, 1, 1, CAST(10.99 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), 3)
GO
INSERT [dbo].[InventoryProduct] ([Id], [InventoryId], [ProductId], [Rate], [Discount], [Qty]) VALUES (2, 1, 2, CAST(15.99 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), 2)
GO
INSERT [dbo].[InventoryProduct] ([Id], [InventoryId], [ProductId], [Rate], [Discount], [Qty]) VALUES (3, 2, 3, CAST(8.99 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)), 5)
GO
SET IDENTITY_INSERT [dbo].[InventoryProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([Id], [Code], [Name], [Rate]) VALUES (1, N'P1', N'Product 1', CAST(10.99 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([Id], [Code], [Name], [Rate]) VALUES (2, N'P2', N'Product 2', CAST(15.99 AS Decimal(18, 2)))
GO
INSERT [dbo].[Product] ([Id], [Code], [Name], [Rate]) VALUES (3, N'P3', N'Product 3', CAST(8.99 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[InventoryProduct]  WITH CHECK ADD FOREIGN KEY([InventoryId])
REFERENCES [dbo].[Inventory] ([Id])
GO
ALTER TABLE [dbo].[InventoryProduct]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
USE [master]
GO
ALTER DATABASE [SimpleBilling] SET  READ_WRITE 
GO
