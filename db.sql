USE [master]
GO
/****** Object:  Database [App]    Script Date: 8/30/2018 3:27:25 PM ******/
CREATE DATABASE [App]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'App', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\App.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'App_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\App_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [App] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [App].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [App] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [App] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [App] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [App] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [App] SET ARITHABORT OFF 
GO
ALTER DATABASE [App] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [App] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [App] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [App] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [App] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [App] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [App] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [App] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [App] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [App] SET  ENABLE_BROKER 
GO
ALTER DATABASE [App] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [App] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [App] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [App] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [App] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [App] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [App] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [App] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [App] SET  MULTI_USER 
GO
ALTER DATABASE [App] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [App] SET DB_CHAINING OFF 
GO
ALTER DATABASE [App] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [App] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [App] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [App] SET QUERY_STORE = OFF
GO
USE [App]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [App]
GO
/****** Object:  Table [dbo].[DiemDanh]    Script Date: 8/30/2018 3:27:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiemDanh](
	[MaDD] [nvarchar](50) NOT NULL,
	[MaDuKien] [nvarchar](50) NULL,
	[Ngay] [date] NULL,
	[Buoi] [nvarchar](50) NULL,
 CONSTRAINT [PK_DiemDanh] PRIMARY KEY CLUSTERED 
(
	[MaDD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DuKienTT]    Script Date: 8/30/2018 3:27:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuKienTT](
	[MaDuKien] [nvarchar](50) NOT NULL,
	[MaUser] [nvarchar](50) NOT NULL,
	[Tuan] [nvarchar](50) NULL,
	[Thu] [nvarchar](50) NULL,
	[Ngay] [nvarchar](50) NULL,
	[Thang] [nvarchar](50) NULL,
	[Buoi] [nvarchar](50) NULL,
 CONSTRAINT [PK_DuKienTT_1] PRIMARY KEY CLUSTERED 
(
	[MaDuKien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 8/30/2018 3:27:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Ma] [nvarchar](50) NULL,
	[NoiDung] [nvarchar](50) NULL,
	[Time] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 8/30/2018 3:27:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaUser] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](100) NULL,
	[TenTaiKhoan] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[MaQuyen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](200) NOT NULL,
	[NienKhoa] [nvarchar](50) NULL,
	[BatDau] [date] NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[MaUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 8/30/2018 3:27:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongBao](
	[MaTB] [nvarchar](50) NOT NULL,
	[TieuDe] [nvarchar](250) NULL,
	[NoiDung] [nvarchar](500) NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[MaUser] [nvarchar](50) NOT NULL,
	[NgayTao] [datetime] NULL,
 CONSTRAINT [PK_ThongBao] PRIMARY KEY CLUSTERED 
(
	[MaTB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XinPhep]    Script Date: 8/30/2018 3:27:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XinPhep](
	[MaXP] [nvarchar](50) NOT NULL,
	[MaDuKien] [nvarchar](50) NULL,
	[NgayTao] [date] NULL,
	[Buoi] [nvarchar](50) NULL,
	[LyDo] [nvarchar](250) NULL,
	[DaXem] [bit] NULL,
 CONSTRAINT [PK_XinPhep] PRIMARY KEY CLUSTERED 
(
	[MaXP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_2_208_208_CH', N'NV01_2_208', CAST(N'2018-08-20' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_2_208_208_SA', N'NV01_2_208', CAST(N'2018-08-20' AS Date), N'sa')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_2_27_CH', N'NV01_2_27', CAST(N'2018-07-02' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_2_27_SA', N'NV01_2_27', CAST(N'2018-07-02' AS Date), N'sa')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_2_278_278_SA', N'NV01_2_278', CAST(N'2018-08-27' AS Date), N'sa')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_3_218_218_CH', N'NV01_3_218', CAST(N'2018-08-21' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_3_218_218_SA', N'NV01_3_218', CAST(N'2018-08-21' AS Date), N'sa')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_4_228_228_CH', N'NV01_4_228', CAST(N'2018-08-22' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_5_168_168_CH', N'NV01_5_168', CAST(N'2018-08-16' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_5_308_308_CH', N'NV01_5_308', CAST(N'2018-08-30' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV01_6_248_248_CH', N'NV01_6_248', CAST(N'2018-08-24' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV02_6_248_248_CH', N'NV02_6_248', CAST(N'2018-08-24' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV02_6_248_248_SA', N'NV02_6_248', CAST(N'2018-08-24' AS Date), N'sa')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV03_2_208_208_SA', N'NV03_2_208', CAST(N'2018-08-20' AS Date), N'sa')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV03_6_248_248_CH', N'NV03_6_248', CAST(N'2018-08-24' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV04_6_248_248_CH', N'NV04_6_248', CAST(N'2018-08-24' AS Date), N'ch')
INSERT [dbo].[DiemDanh] ([MaDD], [MaDuKien], [Ngay], [Buoi]) VALUES (N'DD_NV04_6_248_248_SA', N'NV04_6_248', CAST(N'2018-08-24' AS Date), N'sa')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_138', N'NV01', N'7', N'2', N'13', N'8', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_167', N'NV01', N'3', N'2', N'16', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_208', N'NV01', N'8', N'2', N'20', N'8', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_237', N'NV01', N'4', N'2', N'23', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_27', N'NV01', N'1', N'2', N'2', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_278', N'NV01', N'9', N'2', N'27', N'8', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_307', N'NV01', N'5', N'2', N'30', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_68', N'NV01', N'6', N'2', N'6', N'8', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_2_97', N'NV01', N'2', N'2', N'9', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_107', N'NV01', N'2', N'3', N'10', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_148', N'NV01', N'7', N'3', N'14', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_177', N'NV01', N'3', N'3', N'17', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_218', N'NV01', N'8', N'3', N'21', N'8', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_247', N'NV01', N'4', N'3', N'24', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_288', N'NV01', N'9', N'3', N'28', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_317', N'NV01', N'5', N'3', N'31', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_37', N'NV01', N'1', N'3', N'3', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_3_78', N'NV01', N'6', N'3', N'7', N'8', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_117', N'NV01', N'2', N'4', N'11', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_158', N'NV01', N'7', N'4', N'15', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_18', N'NV01', N'5', N'4', N'1', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_187', N'NV01', N'3', N'4', N'18', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_228', N'NV01', N'8', N'4', N'22', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_257', N'NV01', N'4', N'4', N'25', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_298', N'NV01', N'9', N'4', N'29', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_47', N'NV01', N'1', N'4', N'4', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_4_88', N'NV01', N'6', N'4', N'8', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_127', N'NV01', N'2', N'5', N'12', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_168', N'NV01', N'7', N'5', N'16', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_197', N'NV01', N'3', N'5', N'19', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_238', N'NV01', N'8', N'5', N'23', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_267', N'NV01', N'4', N'5', N'26', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_28', N'NV01', N'5', N'5', N'2', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_308', N'NV01', N'9', N'5', N'30', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_57', N'NV01', N'1', N'5', N'5', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_5_98', N'NV01', N'6', N'5', N'9', N'8', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_108', N'NV01', N'6', N'6', N'10', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_137', N'NV01', N'2', N'6', N'13', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_178', N'NV01', N'7', N'6', N'17', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_207', N'NV01', N'3', N'6', N'20', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_248', N'NV01', N'8', N'6', N'24', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_277', N'NV01', N'4', N'6', N'27', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_318', N'NV01', N'9', N'6', N'31', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_38', N'NV01', N'5', N'6', N'3', N'8', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV01_6_67', N'NV01', N'1', N'6', N'6', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_2_167', N'NV03', N'3', N'2', N'16', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_2_27', N'NV03', N'1', N'2', N'2', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_2_97', N'NV03', N'2', N'2', N'9', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_3_107', N'NV03', N'2', N'3', N'10', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_3_177', N'NV03', N'3', N'3', N'17', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_3_37', N'NV03', N'1', N'3', N'3', N'7', N'sang')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_4_117', N'NV03', N'2', N'4', N'11', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_4_187', N'NV03', N'3', N'4', N'18', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_4_47', N'NV03', N'1', N'4', N'4', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_5_127', N'NV03', N'2', N'5', N'12', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_5_197', N'NV03', N'3', N'5', N'19', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_5_57', N'NV03', N'1', N'5', N'5', N'7', N'chieu')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_6_137', N'NV03', N'2', N'6', N'13', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_6_207', N'NV03', N'3', N'6', N'20', N'7', N'cangay')
INSERT [dbo].[DuKienTT] ([MaDuKien], [MaUser], [Tuan], [Thu], [Ngay], [Thang], [Buoi]) VALUES (N'NV03_6_67', N'NV03', N'1', N'6', N'6', N'7', N'cangay')
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'1', N'Task Xin Phép', CAST(N'2018-08-17T22:16:04.790' AS DateTime))
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'2', N'Task Admin', CAST(N'2018-08-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'3', N'task GetDiemDanh', CAST(N'2018-08-18T14:54:18.883' AS DateTime))
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'4', N'task GetXinPhep', CAST(N'2018-08-18T15:56:27.227' AS DateTime))
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'5', N'task Tong', CAST(N'2018-08-18T15:57:32.163' AS DateTime))
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'6', N'task get xin nghi', CAST(N'2018-08-19T22:22:36.060' AS DateTime))
INSERT [dbo].[Log] ([Ma], [NoiDung], [Time]) VALUES (N'7', N'tast trang thai', CAST(N'2018-08-19T23:02:32.650' AS DateTime))
INSERT [dbo].[TaiKhoan] ([MaUser], [HoTen], [TenTaiKhoan], [NgaySinh], [MatKhau], [MaQuyen], [DiaChi], [NienKhoa], [BatDau]) VALUES (N'admin', N'admin', N'admin', CAST(N'1995-01-01' AS Date), N'1', N'Admin', N'Lâm Đồng', N'2018', NULL)
INSERT [dbo].[TaiKhoan] ([MaUser], [HoTen], [TenTaiKhoan], [NgaySinh], [MatKhau], [MaQuyen], [DiaChi], [NienKhoa], [BatDau]) VALUES (N'NV01', N'Hồng Giang', N'gianghong', CAST(N'1997-05-10' AS Date), N'1', N'NhanVien', N'Lâm Đồng', N'2018', CAST(N'2018-07-02' AS Date))
INSERT [dbo].[TaiKhoan] ([MaUser], [HoTen], [TenTaiKhoan], [NgaySinh], [MatKhau], [MaQuyen], [DiaChi], [NienKhoa], [BatDau]) VALUES (N'NV02', N'Bích Bông', N'bichbong', CAST(N'1990-12-28' AS Date), N'1', N'NhanVien', N'Lâm Đồng', N'2018', CAST(N'2018-07-02' AS Date))
INSERT [dbo].[TaiKhoan] ([MaUser], [HoTen], [TenTaiKhoan], [NgaySinh], [MatKhau], [MaQuyen], [DiaChi], [NienKhoa], [BatDau]) VALUES (N'NV03', N'Nguyễn Mai', N'mainguyen', CAST(N'1990-12-22' AS Date), N'1', N'NhanVien', N'Lâm Đồng', N'2018', CAST(N'2018-07-02' AS Date))
INSERT [dbo].[TaiKhoan] ([MaUser], [HoTen], [TenTaiKhoan], [NgaySinh], [MatKhau], [MaQuyen], [DiaChi], [NienKhoa], [BatDau]) VALUES (N'NV04', N'Hoàng Tiến Đạt', N'tiendat', CAST(N'1995-01-01' AS Date), N'1', N'NhanVien', N'Lâm Đồng', N'2018', CAST(N'2018-07-02' AS Date))
INSERT [dbo].[TaiKhoan] ([MaUser], [HoTen], [TenTaiKhoan], [NgaySinh], [MatKhau], [MaQuyen], [DiaChi], [NienKhoa], [BatDau]) VALUES (N'NV05', N'Phạm Huy', N'phamhuy', CAST(N'1995-01-01' AS Date), N'1', N'NhanVien', N'Lâm Đồng', N'2018', CAST(N'2018-07-02' AS Date))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'f', N'test', N'các bạn thực tập,test giúp bên công ty mình website này với nha. Cảm ơn.', CAST(N'2018-08-27' AS Date), CAST(N'2018-08-29' AS Date), N'admin', CAST(N'2018-08-27T08:34:48.180' AS DateTime))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'TB_8/24/2018', N'Thông báo App', N'Các bạn chuẩn bị làm báo cáo về App các em làm nha.', CAST(N'2018-08-23' AS Date), CAST(N'2018-08-24' AS Date), N'admin', CAST(N'2018-08-24T21:53:10.040' AS DateTime))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'TB_8/24/2018_2', N'Đi thực tập', N'Các bạn đi thực tập đầy đủ, làm xong app bên anh giao , hoàn thành 2 tháng thực tập. Chúc các em thành công.', CAST(N'2018-08-24' AS Date), CAST(N'2018-08-25' AS Date), N'admin', CAST(N'2018-08-24T21:57:23.750' AS DateTime))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'TB_8/24/2018_3', N'Giấy tờ', N'Các bạn chuẩn bị giấy tờ để bên anh kí giấy để hoàn thành thực tập nha.', CAST(N'2018-08-24' AS Date), CAST(N'2018-08-25' AS Date), N'admin', CAST(N'2018-08-24T21:57:30.990' AS DateTime))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'TB_8/27/2018_6', N'Nhập liệu', N'Vui lòng nhập liệu', CAST(N'2018-08-27' AS Date), CAST(N'2018-08-28' AS Date), N'admin', CAST(N'2018-08-27T09:43:40.997' AS DateTime))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'TB_8/27/2018_7', N'KÍ ĐƠN', N'Các bạn tranh thủ in đơn nộp cho sếp đóng dấu.', CAST(N'2018-08-30' AS Date), CAST(N'2018-08-31' AS Date), N'admin', CAST(N'2018-08-27T11:21:51.550' AS DateTime))
INSERT [dbo].[ThongBao] ([MaTB], [TieuDe], [NoiDung], [NgayBatDau], [NgayKetThuc], [MaUser], [NgayTao]) VALUES (N'TB_8/30/2018_7', N'Thông báo chiều đi chơi', N'Hdhdhđjje', CAST(N'2018-08-30' AS Date), CAST(N'2018-08-31' AS Date), N'admin', CAST(N'2018-08-30T14:57:22.287' AS DateTime))
INSERT [dbo].[XinPhep] ([MaXP], [MaDuKien], [NgayTao], [Buoi], [LyDo], [DaXem]) VALUES (N'XP_NV01_2_208_SA', N'NV01_2_208', CAST(N'2018-08-17' AS Date), N'sa', N'Do nhà em có việc,mong anh cho e nghỉ 1 ngày.Cảm ơn anh.', 1)
INSERT [dbo].[XinPhep] ([MaXP], [MaDuKien], [NgayTao], [Buoi], [LyDo], [DaXem]) VALUES (N'XP_NV01_5_238_CH', N'NV01_5_238', CAST(N'2018-08-21' AS Date), N'ch', N'Em bị ốm nên cho em xin nghỉ buổi chiều.', 1)
INSERT [dbo].[XinPhep] ([MaXP], [MaDuKien], [NgayTao], [Buoi], [LyDo], [DaXem]) VALUES (N'XP_NV01_5_238_SA', N'NV01_5_238', CAST(N'2018-08-21' AS Date), N'sa', N'Do em bị đau bụng nên cho em nghỉ buổi chiều.', 1)
INSERT [dbo].[XinPhep] ([MaXP], [MaDuKien], [NgayTao], [Buoi], [LyDo], [DaXem]) VALUES (N'XP_NV01_6_178_SA', N'NV01_6_178', CAST(N'2018-08-17' AS Date), N'sa', N'Sáng nay em bị ốm,nên xin nghỉ 1 buổi. Cảm ơn anh.', 1)
INSERT [dbo].[XinPhep] ([MaXP], [MaDuKien], [NgayTao], [Buoi], [LyDo], [DaXem]) VALUES (N'XP_NV01_6_248_SA', N'NV01_6_248', CAST(N'2018-08-20' AS Date), N'sa', N'Ghc', 1)
INSERT [dbo].[XinPhep] ([MaXP], [MaDuKien], [NgayTao], [Buoi], [LyDo], [DaXem]) VALUES (N'XP_NV01_6_318_SA', N'NV01_6_318', CAST(N'2018-08-30' AS Date), N'sa', N'Đâu bung', 1)
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_Time]  DEFAULT (getdate()) FOR [Time]
GO
USE [master]
GO
ALTER DATABASE [App] SET  READ_WRITE 
GO
