USE [master]
GO
/****** Object:  Database [projekt]    Script Date: 21/09/2023 08:44:36 ******/
CREATE DATABASE [ivan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'projekt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\projekt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'projekt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\projekt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ivan] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ivan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ivan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ivan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ivan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ivan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ivan] SET ARITHABORT OFF 
GO
ALTER DATABASE [ivan] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ivan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ivan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ivan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ivan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ivan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ivan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ivan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ivan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ivan] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ivan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ivan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ivan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ivan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ivan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ivan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ivan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ivan] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ivan] SET  MULTI_USER 
GO
ALTER DATABASE [ivan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ivan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ivan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ivan] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ivan] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ivan] SET QUERY_STORE = OFF
GO
USE [ivan]
GO
/****** Object:  Schema [ePodrska]    Script Date: 21/09/2023 08:44:36 ******/
CREATE SCHEMA [ePodrska]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 21/09/2023 08:44:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ePodrska].[korisnik]    Script Date: 21/09/2023 08:44:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ePodrska].[korisnik](
	[korisnik_id] [int] IDENTITY(1,1) NOT NULL,
	[tip_id] [int] NOT NULL,
	[korisnicko_ime] [varchar](50) NOT NULL,
	[lozinka] [varchar](max) NULL,
	[ime] [varchar](50) NULL,
	[prezime] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[slika] [varchar](max) NULL,
	[Blocked] [bit] NOT NULL,
	[LastLogIn] [datetime2](7) NULL,
	[Zaposlen] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[korisnik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ePodrska].[odgovor]    Script Date: 21/09/2023 08:44:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ePodrska].[odgovor](
	[odgovor_id] [int] IDENTITY(1,1) NOT NULL,
	[pitanje_id] [int] NOT NULL,
	[zaposlenik_id] [int] NOT NULL,
	[tekst] [varchar](max) NOT NULL,
	[datum_vrijeme_odgovora] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[odgovor_id] ASC,
	[zaposlenik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ePodrska].[pitanje]    Script Date: 21/09/2023 08:44:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ePodrska].[pitanje](
	[pitanje_id] [int] IDENTITY(1,1) NOT NULL,
	[tvrtka_id] [int] NOT NULL,
	[naslov] [varchar](50) NOT NULL,
	[datum_vrijeme_pitanja] [datetime2](0) NOT NULL,
	[tekst] [varchar](max) NOT NULL,
	[slika] [varchar](max) NOT NULL,
	[video] [varchar](max) NULL,
	[Odgovoreno] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pitanje_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ePodrska].[tip_korisnika]    Script Date: 21/09/2023 08:44:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ePodrska].[tip_korisnika](
	[tip_id] [int] IDENTITY(1,1) NOT NULL,
	[naziv] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tip_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ePodrska].[tvrtka]    Script Date: 21/09/2023 08:44:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ePodrska].[tvrtka](
	[tvrtka_id] [int] IDENTITY(1,1) NOT NULL,
	[moderator_id] [int] NOT NULL,
	[naziv] [varchar](50) NOT NULL,
	[opis] [varchar](max) NULL,
	[broj_zaposlenika] [int] NOT NULL,
	[preostaliOdgovori] [int] NOT NULL,
	[zahtjev] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tvrtka_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ePodrska].[zaposlenik]    Script Date: 21/09/2023 08:44:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ePodrska].[zaposlenik](
	[zaposlenik_id] [int] NOT NULL,
	[korisnik_id] [int] NOT NULL,
	[tvrtka_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[zaposlenik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230904113527_Initial-Model', N'7.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230904115718_AddColumnToKorisnikTable', N'7.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230904131929_AddColumnLastLogInDateToKorisnikTable', N'7.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230906100322_AddColumnOdgvorenoToPitanje', N'7.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230912092645_AddColumnToKorisnikTableZaposlen', N'7.0.10')
GO
SET IDENTITY_INSERT [ePodrska].[korisnik] ON 

INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (1, 0, N'admin', N'$2b$10$Ierx2.6l3UAlzmHrnqvjHulTuiiCBkpzw3jaFoZFtpvAes3uVmfV.', N'Administrator', N'Admin', NULL, N'NoImage.jpg', 0, CAST(N'2023-09-21T08:30:47.7738402' AS DateTime2), 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (2, 0, N'voditelj', N'$2b$10$ULaGRu/32sk1y4ioOAOUjeYgdbaOzRKwvEavnKRdpbN5CQ0fyNR/q', N'voditelj', N'Vodi', NULL, N'NoImage.jpg', 0, CAST(N'2023-09-21T08:31:45.3462552' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (3, 0, N'pkos', N'$2b$10$lcHMTWS2MYeNAlcfxQh./.tjIVL0vgFZkT5bkzkktAtZlreUvJ9NO', N'Pero', N'Kos', NULL, N'NoImage.jpg', 0, CAST(N'2023-09-21T08:40:24.0521338' AS DateTime2), 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (4, 2, N'vzec', N'$2b$10$.HUuw6GUQ4VgzGJq6K6s3.SAgmTEgKfdn7yz825X0tTUB0tRzTUb2', N'Vladimir', N'Zec', N'vzec@fff.hr', N'NoImage.jpg', 0, CAST(N'2023-09-11T13:06:45.7209092' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (5, 2, N'qtarantino', N'$2b$10$VgcrsyIOm3IsnVDlNxr0wOHW.xLV6CtMhKWvOEuotKqjtpDCiZv7e', N'Quentin', N'Tarantino', N'qtarantino@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T12:27:08.9346846' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (6, 2, N'mbellucci', N'$2b$10$yE0yw87c4OPp9iTbgED9xuAqLnquwN4f5AFg2sEnUyp/WntPu2iEi', N'Monica', N'Bellucci', N'mbellucci@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (7, 2, N'vmortensen', N'$2b$10$rZLc9JNQHvf2y7hgPSQt/.E8iJnVv2YtN/hVSKj/EBz5uXipDt0Cq', N'Viggo', N'Mortensen', N'vmortensen@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (8, 2, N'jgarner', N'$2b$10$0dQzT1SLdW5T41fjZI7GsuVjoNZBn908IJmj.903M1b1j8XUDC0km', N'Jennifer', N'Garner', N'jgarner@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T12:47:06.8683637' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (9, 2, N'nportman', N'$2b$10$Igbqb7HxRFkdgOlkVIuEnuaIOhlOykMZZFvUoYBE4SPoZ140p4Yx2', N'Natalie', N'Portman', N'nportman@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (10, 2, N'dradcliffe', N'$2b$10$4BeC0NkIQMKP6o1hug6aiuzf8s2kIg49mS6VIC16pnXCb7gU19LmS', N'Daniel', N'Radcliffe', N'dradcliffe@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (11, 2, N'hberry', N'$2b$10$1P9HCk/fmMl.J5ypWnOCpe9rr8TQKBuPp264K/MKliAZ0VNMA4Z56', N'Halle', N'Berry', N'hberry@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (12, 2, N'vdiesel', N'$2b$10$aqbVthaoQ5hNFHqazrLq5OI.E1N7nfxWj/pdSeRmRI0gfP98edMbO', N'Vin', N'Diesel', N'vdiesel@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-05T10:17:03.1721353' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (13, 2, N'ecuthbert', N'$2b$10$2OLUVvaemtr/YJ1NgEVpfuLC3tqv9b9QRAjDErgk/ZesyLAVslSOe', N'Elisha', N'Cuthbert', N'ecuthbert@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (14, 2, N'janiston', N'$2b$10$1IZZHHk8q20Ua/yef29Ii.mIkw7J9YKQFsY.0plTeb1RkyVOAAsp.', N'Jennifer', N'Aniston', N'janiston@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (15, 2, N'ctheron', N'$2b$10$nxkqaluIHgSvdNk5h1xkyuuENIQM9uAQc1kzTa4/I.hKv6219tEje', N'Charlize', N'Theron', N'ctheron@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (16, 2, N'nkidman', N'$2b$10$NGo4QM5rAI2mCSl3ExGDVO/WbXB3lxNC/42z/7YFTgCoVSSRLFPL6', N'Nicole', N'Kidman', N'nkidman@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (17, 2, N'ewatson', N'$2b$10$sR/bbqerZ80b0JDTRnzwruHCiYAaVEPsFLBQgSMfeUUUU4MmA.1Na', N'Emma', N'Watson', N'ewatson@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (18, 1, N'kdunst', N'$2b$10$u.TlWo.gPHyVobba34jD0uqK7xngDU2w3mIXwKx/sUeyy.nN4ghcS', N'Kirsten', N'Dunst', N'kdunst@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-20T13:41:09.4945228' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (19, 2, N'sjohansson', N'$2b$10$ydazG6x7v/R4VJL8gRJ7MeeDzYSjAO4JhrAWcTOjEzri3w1cYKaNu', N'Scarlett', N'Johansson', N'sjohansson@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-12T11:10:53.6519524' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (20, 2, N'philton', N'$2b$10$kbRx.2W2npBzdDByMtW2o.qa6AmA/fjEC0Q197LSWbc8MBZkBwEBi', N'Paris', N'Hilton', N'philton@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (21, 2, N'kbeckinsale', N'$2b$10$dE4h/wCNfjf701u8LA/rFuqQ17UvWB2wGK.QWadO6s1BlZMBxEgCO', N'Kate', N'Beckinsale', N'kbeckinsale@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (22, 2, N'tcruise', N'$2b$10$uYfGJNPp.CQ5uoK3T4s2U.5gYE2H7La/r8Bq8rBQvrz7FIpXxxSyu', N'Tom', N'Cruise', N'tcruise@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (23, 2, N'hduff', N'$2b$10$uGuVDQNdRD45nnffY5SUveXmOGGE0UsWfoYMMreCjuiDWHeBJBjNq', N'Hilary', N'Duff', N'hduff@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (24, 2, N'ajolie', N'$2b$10$RymM6Vr.kBO49BgW3hfBV.TYdFo3lzHj3VqCEURW9gMVrDvAY2NR6', N'Angelina', N'Jolie', N'ajolie@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (25, 2, N'kknightley', N'$2b$10$gV6R.fP86ljbO262ESH4wOrKQz2nEB.zt7si/UhaAlx1YHMG/h8b.', N'Keira', N'Knightley', N'kknightley@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (26, 2, N'obloom', N'$2b$10$z0RUf5kPhLb5C7SMGECDqufmf0hjbUnxJANWgs9DQyX.1G68ZtbAu', N'Orlando', N'Bloom', N'obloom@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (27, 2, N'llohan', N'$2b$10$ME5jmXLz6NO5Nys//8RzYePxXCZOH8lZXa2eOz7vcCHylaBrvhW0m', N'Lindsay', N'Lohan', N'llohan@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-19T09:43:11.2691178' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (28, 2, N'jdepp', N'$2b$10$N2tv25ShC.oIMfLAff.Hp.ZMw38mWufWvFvCdJcs02IDoF0Q3UTx2', N'Johnny', N'Depp', N'jdepp@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T08:44:17.4486657' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (29, 2, N'kreeves', N'$2b$10$QO.eN/6HL74wD1w9dYaYuOyqXEhKBanNbTI5Kl6gtu03ljuk2odnm', N'Keanu', N'Reeves', N'kreeves@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (30, 1, N'thanks', N'$2b$10$ys4tosi2nuOVm47krCybvO/Gw1dqZ6rH0C4hD07ouTGYThZRrvGQS', N'Tom', N'Hanks', N'thanks@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-11T12:21:28.8345223' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (31, 2, N'elongoria', N'$2b$10$WSo1CGFoaBkvhzphSSnn0uDzKiMHqh2RaR/JjapZNOQ7oiRjI1Tba', N'Eva', N'Longoria', N'elongoria@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (32, 2, N'rde', N'$2b$10$x/HZsglrzZBOaJsYQMX6C.OHLYoFUw7mORTNQphJzGEXBOigs4gE2', N'Robert', N'De', N'rde@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (33, 2, N'jheder', N'$2b$10$E021dOpJMjg7jAmxv/puAOlh7IsYZORETG47oX8GfU/RR6bDYmdFW', N'Jon', N'Heder', N'jheder@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (34, 2, N'rmcadams', N'$2b$10$wg0XgrCyMnsNMhl02sEyXOzpF.9FWqeULJw2hWkG67LdeYB47KazO', N'Rachel', N'McAdams', N'rmcadams@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (35, 2, N'cbale', N'$2b$10$gU3Af8RY5IQ5ZN9uKgLn..jaUK.Oc3CXMjo7yAVMtQ53UnafnSeH.', N'Christian', N'Bale', N'cbale@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T13:00:22.4379475' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (36, 1, N'jalba', N'$2b$10$TT4DWh0N/RVAQANLBHfiQ.gtUs1VzsJqrd2gVGqNNJSHE7MxeQzV6', N'Jessica', N'Alba', N'jalba@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-11T13:25:35.5994976' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (37, 2, N'bpitt', N'$2b$10$bEbF53Wy3O4VZ5OrOuO9I.kZHxZRiftAQ2JWRf3j7/tVkOBg/hnnS', N'Brad', N'Pitt', N'bpitt@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T07:41:19.3909401' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (43, 2, N'apacino', N'$2b$10$fe.i7Yta12O76W2APRHSc.J8eGl/VM2Sazll5VbPe6J8BgV14XrCW', N'Al', N'Pacino', N'apacino@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T13:27:41.7026829' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (44, 2, N'wsmith', N'$2b$10$FHpaQG2GKee42AsfxvGgO.gH0sal0RRgtaVtKZyxwXreqPpzZtPS6', N'Will', N'Smith', N'wsmith@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (45, 2, N'ncage', N'$2b$10$oM9Bbr1e9SS8XOGbnd9KNurznHVbxFmXYBaUiAIvF7ULBj6PggCgu', N'Nicolas', N'Cage', N'ncage@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (46, 2, N'vanne', N'$2b$10$qZBdWKVuMgzJ3ZOgBSDdlOK.7q335GjObFup/sXsULf8iAE6tdzna', N'Vanessa', N'Anne', N'vanne@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (47, 2, N'kheigl', N'$2b$10$I/Xmq.Af6pLF/I0luPZeW.aRprdUiL3g7YEEIf.SsES1b2NEunDh6', N'Katherine', N'Heigl', N'kheigl@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (48, 2, N'gbutler', N'$2b$10$3qgK2sjjl1TvAFeJFNmaAe8iqOEcMxk/mTX63xKtm7Xn6QtObflxq', N'Gerard', N'Butler', N'gbutler@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (49, 2, N'jbiel', N'$2b$10$3s9t4E6M1sGgO4/7XAKMbeDk19pgKKO19YxWkYJbbNgzV9sLJ30aO', N'Jessica', N'Biel', N'jbiel@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (50, 2, N'ldicaprio', N'$2b$10$xG53Ct4kkeJHhq2o/1pbSeXz1WcyNiDG6gDB.c.Nt9hmHOMd1UxsS', N'Leonardo', N'DiCaprio', N'ldicaprio@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (51, 2, N'mdamon', N'$2b$10$CdMi9IarknXD/qbnCsUy7O00skkEC4.tVJXnblC9gwW6Ge2BzO0zG', N'Matt', N'Damon', N'mdamon@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (52, 2, N'hpanettiere', N'$2b$10$oQc2NkluypHzirHexiFbGexAx2ijaVJNJvhsg0dxYZL55oXY9r7h.', N'Hayden', N'Panettiere', N'hpanettiere@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (53, 2, N'rreynolds', N'$2b$10$xnuck5CPtVB1Mlm.4hjg3OAMTuESc4qToBm6Kqz/E6BYWRx.wYDPC', N'Ryan', N'Reynolds', N'rreynolds@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (54, 2, N'jstatham', N'$2b$10$NIs7IKEzK4JA8Drc.QsvOe.K1HPjzNM7GB1eU.7Qcz5N8sT4rKmq.', N'Jason', N'Statham', N'jstatham@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (55, 2, N'enorton', N'$2b$10$l.vqOvKiECfkQREBImz.U.3/kk98ZwW7NwVcwThLa/ngpdW9u1oDS', N'Edward', N'Norton', N'enorton@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (56, 2, N'mwahlberg', N'$2b$10$.IpXXI9TDoLi9.3mv03ml.AHIDbvtAk.1bLeMku7LcTXEdb9sF7Ay', N'Mark', N'Wahlberg', N'mwahlberg@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (57, 2, N'jmcavoy', N'$2b$10$mXHW9aRssftXiBaIUj50TeJubyttdSG4DQG2D1CftbGxGcvonw3BK', N'James', N'McAvoy', N'jmcavoy@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (58, 2, N'epage', N'$2b$10$VjG0G17jvpkHh4LfSycya.787nwbfFHg74ff2NadScMlIyKBETVd2', N'Ellen', N'Page', N'epage@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-18T13:41:02.8943515' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (59, 1, N'mcyrus', N'$2b$10$RudPN7/JXUB5oNTs84U1QO.q/2WipPTXbkk3V2Is/hTBe2QhpF5FW', N'Miley', N'Cyrus', N'mcyrus@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-19T14:06:00.6566284' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (60, 2, N'kstewart', N'$2b$10$QMC2WHZImP4aFrx9F.y.auhd5HOmcUmzrd/hkET0AwPxZjXXtnE3e', N'Kristen', N'Stewart', N'kstewart@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (61, 2, N'mfox', N'$2b$10$Kor7Ri1160QE8GkQJrpbueEtdjdN.tYpImh7qLvBhKYCt0WU3.D7e', N'Megan', N'Fox', N'mfox@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-20T13:10:11.6034496' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (62, 2, N'slabeouf', N'$2b$10$pjyyp8QNgcjmDbVlJSN0YOrF/PiU0QU6uYmKfbjwr2RDxtaXdszLG', N'Shia', N'LaBeouf', N'slabeouf@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (63, 2, N'ceastwood', N'$2b$10$kTFz/xzRqVHcsQwp2BY/d.OVZRcRUlCycmCiZj0iKdpsnseRgo982', N'Clint', N'Eastwood', N'ceastwood@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (64, 1, N'srogen', N'$2b$10$eqxU8q7Wotebgje/BxDGIOKEyrEmvh/cWDmIe/fEJU//BLPnw3u6S', N'Seth', N'Rogen', N'srogen@mail.com', N'NoImage.jpg', 0, CAST(N'2023-09-19T09:42:53.3086818' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (65, 2, N'nreed', N'$2b$10$RF78YBFssrgaxxs2nP/QIuVF5dNw5RJyQFNV6eIQj3V.FjFg0TVha', N'Nikki', N'Reed', N'nreed@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (66, 2, N'agreene', N'$2b$10$xxf14pxjwR3QVSNuvWQKyubTfm7PB5Jxvi0ZseB0Kke7h7kXK1MFO', N'Ashley', N'Greene', N'agreene@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (67, 2, N'zdeschanel', N'$2b$10$t4jMlAQpWAB63mf8HXQ/f.WpRTCWsm/voP..bGWQT757i6jYVwkjW', N'Zooey', N'Deschanel', N'zdeschanel@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (68, 2, N'dfanning', N'$2b$10$fsLZPvbzoySjbqiPTpjPlOIotFlnc08qXCe8jIQRgZdWl9sFMeC4.', N'Dakota', N'Fanning', N'dfanning@mail.com', N'NoImage.jpg', 0, NULL, 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (69, 2, N'tlautner', N'$2b$10$0f43iFesT3aN9ZzIfMf/p.j8SNe.sgHoDOLXncLSFpkuufHis0QcK', N'Taylor', N'Lautner', N'tlautner@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (70, 2, N'rpattinson', N'$2b$10$PF8jM3ko.dvFQW4wP31sD.HC3zgiWdjeiyT5hiYboVOKGP0ieaLMq', N'Robert', N'Pattinson', N'rpattinson@mail.com', N'NoImage.jpg', 0, NULL, 0)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (74, 1, N'ikozjan', N'$2b$10$OdOsC4jOik.dzUjPISJSn.gKlcDd4kf5pEmeDuFybOS8wSFWhAOcq', N'Ivan', N'Kozjan', N'kozjanivan@gmail.com', N'NoImage.jpg', 0, CAST(N'2023-09-19T08:56:21.0180814' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (1072, 1, N'mtoma', N'$2b$10$wk8/P7rEjRn92FYIW9vIs.Shb6PNgWHppsCQ632..1Q.iSyxWXZDO', N'Mateo', N'Tomasevic', N'mtoma@gmail.com', N'NoImage.jpg', 0, CAST(N'2023-09-13T10:36:39.7724556' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (1073, 1, N'tandacic', N'$2b$10$Bq3CmyCigrK/r1aaINpW6..Bqo6WXz4nb/hnmNNZSi14O/yWuM0p6', N'Tadijan', N'Andacic', N'tado@gmail.com', N'NoImage.jpg', 0, CAST(N'2023-09-13T10:55:13.3256113' AS DateTime2), 1)
INSERT [ePodrska].[korisnik] ([korisnik_id], [tip_id], [korisnicko_ime], [lozinka], [ime], [prezime], [email], [slika], [Blocked], [LastLogIn], [Zaposlen]) VALUES (1074, 1, N'mmilkovic', N'$2b$10$2.JHkf0EHxrysHRIB583v.4sxbbLw4Yr/z1Oo1MfepAGT2mEpv5q.', N'Marino', N'Milkovic', N'mmilkovic@gmail.com', N'NoImage.jpg', 0, CAST(N'2023-09-19T11:06:26.5265557' AS DateTime2), 1)
SET IDENTITY_INSERT [ePodrska].[korisnik] OFF
GO
SET IDENTITY_INSERT [ePodrska].[odgovor] ON 

INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (1, 1, 1, N'Grid je više od godine dana u CSS specifikaciji i znatno olakšava slaganje rasporeda Web stranica i izradu responzivnog dizajna. Za korištenje potrebna su osnovna znanja o CSS-u. Podržan je u svim modernim web preglednicima (CanIUse). Više informacija: Mozilla Developer Documentation, W3Schools, CssTricks.', CAST(N'2018-11-01T10:30:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (2, 2, 2, N'Mogu se primjerice koristiti fontovi dostupni od strane Google-a. Više informacija: Google Fonts servis.', CAST(N'2018-11-01T15:15:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (3, 3, 3, N'Pokušajte s HTML5 oznakom iframe. Više informacija: W3Schools.', CAST(N'2018-11-02T11:45:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (4, 3, 4, N'Preostale HTML5 oznaka za prikaz videa: video, embed, object. Više informacija: HTML5 Rocks.', CAST(N'2018-11-02T12:00:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (5, 4, 5, N'HTML: https://jigsaw.w3.org/css-validator/validator?uri={uri}, CSS: http://validator.w3.org/check?uri={uri}. Umjesto {uri} trebate unijeti cijelu putanju do Vaše stranice (npr. https://google.com).', CAST(N'2018-11-02T15:15:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (6, 4, 1, N'Nadovezujem se na prethodan odgovor. Ispravna vrijednost za {uri} kod CSS validatora je referer. Puna putanja onda izgleda ovako: https://jigsaw.w3.org/css-validator/validator?uri=referer', CAST(N'2018-11-02T15:25:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (7, 4, 2, N'Odgovor možete pronaći na samim stranicama HTML i CSS validatora nakon što obavite validaciju Vaše stranice. Više informacija: HTML5 validator, CSS validator.', CAST(N'2018-11-02T16:05:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (8, 5, 3, N'Pokušajte spremiti datoteku izvornog koda stranice (ukoliko ste ga mijenjali) ili obrišite međuspremnik (cache) Web preglednika.', CAST(N'2018-11-03T09:00:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (9, 6, 1, N'Trenutni datum i vrijeme mogu se hardkodirati (datum i vrijeme zadnje promijene).', CAST(N'2018-11-03T16:50:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (10, 6, 4, N'Upotrebom iframe-a na Web stranicu koja prikazuje trenutni datum i vrijeme.', CAST(N'2018-11-03T17:15:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (11, 7, 6, N'NetBeans', CAST(N'2018-11-03T20:05:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (12, 7, 7, N'Atom', CAST(N'2018-11-03T20:10:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (13, 7, 8, N'Komodo Edit', CAST(N'2018-11-03T20:15:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (14, 7, 9, N'Visual Studio', CAST(N'2018-11-03T20:25:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (15, 8, 6, N'Pokrenite XAMPP i u upravljačkoj ploči odaberite pod modulom MySQL gumb Admin.', CAST(N'2018-11-04T12:00:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (16, 9, 10, N'Format dobre lozinke uključuje najmanje 12 znakova (velika i mala slova, brojeve i posebne znakove).', CAST(N'2018-11-04T18:00:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (18, 1, 3, N'Da', CAST(N'2023-09-07T08:58:40.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (19, 3, 3, N'<video></video>', CAST(N'2023-09-07T09:01:33.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (22, 2, 2, N'Bravo jako dobro', CAST(N'2023-09-11T10:58:15.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (23, 4, 3, N'Bravo ja', CAST(N'2023-09-11T12:52:28.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (24, 14, 4, N'Bravo zeko', CAST(N'2023-09-11T13:06:09.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (25, 13, 4, N'Toooo bato', CAST(N'2023-09-11T13:06:52.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (26, 18, 19, N'Zao nam je cuti za vasa losa iskustva, pokusati cemo to ispraviti', CAST(N'2023-09-12T11:11:18.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (30, 19, 22, N'Brao', CAST(N'2023-09-13T10:51:00.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (31, 16, 1, N'rdsgfds', CAST(N'2023-09-18T07:33:42.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (32, 20, 23, N'Velika kompanija za rad sa klijentima', CAST(N'2023-09-18T07:41:38.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (33, 22, 32, N'Radimo na površini od 500 hektara', CAST(N'2023-09-18T13:00:42.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (34, 23, 30, N'22.5 Eura', CAST(N'2023-09-18T13:27:53.0000000' AS DateTime2))
INSERT [ePodrska].[odgovor] ([odgovor_id], [pitanje_id], [zaposlenik_id], [tekst], [datum_vrijeme_odgovora]) VALUES (35, 25, 31, N'Hvala lijepo', CAST(N'2023-09-19T09:43:20.0000000' AS DateTime2))
SET IDENTITY_INSERT [ePodrska].[odgovor] OFF
GO
SET IDENTITY_INSERT [ePodrska].[pitanje] ON 

INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (1, 1, N'Korištenje CSS Grida', CAST(N'2018-11-01T10:15:00.0000000' AS DateTime2), N'Je li u izradi Web stranice za početnike preporučeno korištenje CSS Grida kod kreiranje rasporeda elemenata?', N'https://www.w3schools.com/css/grid_columns.png', N'https://www.html5rocks.com/en/tutorials/video/basics/devstories.mp4', 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (2, 1, N'Dodatni fontovi', CAST(N'2018-11-01T14:30:00.0000000' AS DateTime2), N'S obzirom da CSS ne nudi previše mogućnosti oko odabira fontova koje su alternative?', N'www.faqs.org/docs/htmltut/graphics/styles.fontfam.gif', N'', 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (3, 1, N'Prikazivanje videa', CAST(N'2018-11-02T09:45:00.0000000' AS DateTime2), N'Koja HTML5 oznaka se koristi za prikazivanje videa, npr. YouTube?', N'https://www.queness.com/resources/images/14362.jpg', N'', 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (4, 1, N'HTML i CSS validacija', CAST(N'2018-11-02T15:00:00.0000000' AS DateTime2), N'Ispravan naziv poveznice kojim se pozivaju stranice validatora?', N'https://www.oodlesstudio.com/wp-content/uploads/html-css.jpg', N'', 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (5, 2, N'Testiranja Web stranice ', CAST(N'2018-11-03T08:00:00.0000000' AS DateTime2), N'Preglednik uvijek prikazuje raniju verziju Web stranice. U čemu je problem?', N'https://imgcdn.maketecheasier.com/2016/12/google-chrome-inspect-element-hero-a.jpg', N'', 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (6, 2, N'Ispis trenutnog datuma i vrijemena', CAST(N'2018-11-03T16:00:00.0000000' AS DateTime2), N'Na koji način prikazati trenutni datum i vrijeme bez korištenja JavaScripta?', N'https://cdn.splessons.com/spf/c81e728d9d4c2f636f067f89cc14862c/wp-content/uploads/2016/03/javascript-date-01-splessons.png', N'', 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (7, 2, N'Razvojni alati za PHP', CAST(N'2018-11-03T20:00:00.0000000' AS DateTime2), N'Alati slični Notepadu++?', N'https://pngimg.com/uploads/php/php_PNG50.png', N'', 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (8, 2, N'phpMyAdmin', CAST(N'2018-11-04T11:00:00.0000000' AS DateTime2), N'Kako pristupiti sustavu za upravljanje bazom podataka u XAMPP-u?', N'https://i2.wp.com/journalxtra.com/wp-content/uploads/2013/10/phpMyAdmin-Logo.png?resize=360%2C254&ssl=1', N'', 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (9, 3, N'Autentikacija korisnika', CAST(N'2018-11-04T17:00:00.0000000' AS DateTime2), N'Koji je preporučen format i veličina lozinke?', N'http://andrewlouis.co.uk/images/portal_login.png', N'', 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (10, 3, N'Web dizajn', CAST(N'2018-11-05T10:00:00.0000000' AS DateTime2), N'Koja su obilježja dobrog Web dizajna?', N'https://responsivedevelopment.weebly.com/uploads/1/3/3/9/13398422/2513526_orig.jpg', N'', 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (11, 2, N'Pitanje za NTH', CAST(N'2023-09-06T10:46:23.0000000' AS DateTime2), N'Ovo je katastrofalna aplikacija', N'download.jpg', NULL, 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (12, 2, N'Pitanje za NTH', CAST(N'2023-09-06T10:46:59.0000000' AS DateTime2), N'Ovo je katastrofalna aplikacija', N'download.jpg', NULL, 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (13, 1, N'Ozbiljno pitanje', CAST(N'2023-09-06T10:48:31.0000000' AS DateTime2), N'Ja sam Ivan Kozjan', N'download.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (14, 1, N'Pitanje za Styria', CAST(N'2023-09-06T10:49:44.0000000' AS DateTime2), N'fjkdlshfjkldsfds', N'download.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (15, 4, N'Pitanje za Ivana', CAST(N'2023-09-06T10:50:55.0000000' AS DateTime2), N'Ovo je katastrofalna aplikacija', N'download.jpg', NULL, 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (16, 1, N'Kako učiti programiranje', CAST(N'2023-09-11T13:07:39.0000000' AS DateTime2), N'Mene jako puno zanima kako ja mogu naučiti programirati', N'admin.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (18, 6, N'Pitanje za Ivana', CAST(N'2023-09-12T11:10:05.0000000' AS DateTime2), N'Ovo je katastrofalna aplikacija', N'admin.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (19, 7, N'Upit', CAST(N'2023-09-13T10:38:55.0000000' AS DateTime2), N'Koliko veliko polje imate', N'admin.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (20, 5, N'Pitanje', CAST(N'2023-09-18T07:39:27.0000000' AS DateTime2), N'Što je firsko', N'admin.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (22, 10, N'Kvadratura', CAST(N'2023-09-18T12:59:41.0000000' AS DateTime2), N'Lijep pozdrav,

Zanima me površina na kojoj radite svoje zanimanje.

Lp', N'admin.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (23, 8, N'Upit', CAST(N'2023-09-18T13:27:08.0000000' AS DateTime2), N'Kolika vam je cijena studentske mjesecne clanairne', N'admin.jpg', NULL, 1)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (24, 9, N'Rodendan', CAST(N'2023-09-19T08:00:52.0000000' AS DateTime2), N'Lijep pozdrav, zanima me ima li mjesta za rodendan', N'admin.jpg', NULL, 0)
INSERT [ePodrska].[pitanje] ([pitanje_id], [tvrtka_id], [naslov], [datum_vrijeme_pitanja], [tekst], [slika], [video], [Odgovoreno]) VALUES (25, 10, N'Upit', CAST(N'2023-09-19T09:41:02.0000000' AS DateTime2), N'fdsfdsfdsfds', N'admin.jpg', NULL, 1)
SET IDENTITY_INSERT [ePodrska].[pitanje] OFF
GO
SET IDENTITY_INSERT [ePodrska].[tip_korisnika] ON 

INSERT [ePodrska].[tip_korisnika] ([tip_id], [naziv]) VALUES (0, N'administrator')
INSERT [ePodrska].[tip_korisnika] ([tip_id], [naziv]) VALUES (1, N'voditelj')
INSERT [ePodrska].[tip_korisnika] ([tip_id], [naziv]) VALUES (2, N'korisnik')
SET IDENTITY_INSERT [ePodrska].[tip_korisnika] OFF
GO
SET IDENTITY_INSERT [ePodrska].[tvrtka] ON 

INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (1, 2, N'Styria', N'Izrada dizajna Web stranica', 13, 70, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (2, 18, N'NTH', N'Izrada dinamičkih Web stranica', 6, 15, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (3, 30, N'Diverto', N'Informacijska sigurnost', 2, 29, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (4, 36, N'Poslovna inteligencija', N'Konzultantske usluge', 3, 10, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (5, 74, N'Frisko d.o.o', N'Pekara za slasne proizvode', 4, 0, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (6, 1072, N'Mlinar', N'Pekara za slasne proizvode i ukusne', 1, 0, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (7, 1073, N'Pavlovic d.o.o', N'Firma za poljoprivredu', 1, 0, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (8, 1074, N'Gyms4You', N'Unirvezalne teretane 0-24h', 3, 0, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (9, 59, N'Biblos', N'Kuca za proslave', 1, 0, 0)
INSERT [ePodrska].[tvrtka] ([tvrtka_id], [moderator_id], [naziv], [opis], [broj_zaposlenika], [preostaliOdgovori], [zahtjev]) VALUES (10, 64, N'Jozo d.o.o', N'Jozo i kukuruz', 2, 10, 0)
SET IDENTITY_INSERT [ePodrska].[tvrtka] OFF
GO
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (1, 3, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (2, 4, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (3, 5, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (4, 6, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (5, 7, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (6, 8, 2)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (7, 9, 2)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (8, 10, 2)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (9, 11, 2)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (10, 12, 3)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (11, 13, 3)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (12, 14, 4)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (13, 15, 4)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (14, 22, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (15, 24, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (16, 28, 2)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (17, 23, 4)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (18, 33, 2)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (19, 25, 5)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (20, 16, 5)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (21, 19, 6)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (22, 61, 7)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (23, 37, 5)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (24, 60, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (25, 20, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (26, 20, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (27, 29, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (28, 44, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (29, 31, 1)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (30, 43, 8)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (31, 27, 10)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (32, 35, 10)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (33, 58, 8)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (34, 68, 5)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (35, 46, 8)
INSERT [ePodrska].[zaposlenik] ([zaposlenik_id], [korisnik_id], [tvrtka_id]) VALUES (36, 48, 9)
GO
/****** Object:  Index [fk_korisnik_tip_korisnika_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_korisnik_tip_korisnika_idx] ON [ePodrska].[korisnik]
(
	[tip_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_odgovor_dodijeljen1_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_odgovor_dodijeljen1_idx] ON [ePodrska].[odgovor]
(
	[zaposlenik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_odgovor_pitanje1_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_odgovor_pitanje1_idx] ON [ePodrska].[odgovor]
(
	[pitanje_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_pitanje_kategorija1_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_pitanje_kategorija1_idx] ON [ePodrska].[pitanje]
(
	[tvrtka_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_kategorija_korisnik1_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_kategorija_korisnik1_idx] ON [ePodrska].[tvrtka]
(
	[moderator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_tvrtka_has_korisnik_korisnik1_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_tvrtka_has_korisnik_korisnik1_idx] ON [ePodrska].[zaposlenik]
(
	[korisnik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_tvrtka_has_korisnik_tvrtka1_idx]    Script Date: 21/09/2023 08:44:37 ******/
CREATE NONCLUSTERED INDEX [fk_tvrtka_has_korisnik_tvrtka1_idx] ON [ePodrska].[zaposlenik]
(
	[tvrtka_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [ePodrska].[korisnik] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Blocked]
GO
ALTER TABLE [ePodrska].[korisnik] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Zaposlen]
GO
ALTER TABLE [ePodrska].[pitanje] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Odgovoreno]
GO
ALTER TABLE [ePodrska].[tvrtka] ADD  CONSTRAINT [DF_tvrtka_broj_zaposlenika]  DEFAULT ((0)) FOR [broj_zaposlenika]
GO
ALTER TABLE [ePodrska].[tvrtka] ADD  CONSTRAINT [DF_tvrtka_preostaliOdgovori]  DEFAULT ((0)) FOR [preostaliOdgovori]
GO
ALTER TABLE [ePodrska].[tvrtka] ADD  CONSTRAINT [DF_tvrtka_zahtjev]  DEFAULT ((0)) FOR [zahtjev]
GO
ALTER TABLE [ePodrska].[korisnik]  WITH CHECK ADD  CONSTRAINT [fk_korisnik_tip_korisnika] FOREIGN KEY([tip_id])
REFERENCES [ePodrska].[tip_korisnika] ([tip_id])
GO
ALTER TABLE [ePodrska].[korisnik] CHECK CONSTRAINT [fk_korisnik_tip_korisnika]
GO
ALTER TABLE [ePodrska].[odgovor]  WITH CHECK ADD  CONSTRAINT [fk_odgovor_dodijeljen1] FOREIGN KEY([zaposlenik_id])
REFERENCES [ePodrska].[zaposlenik] ([zaposlenik_id])
GO
ALTER TABLE [ePodrska].[odgovor] CHECK CONSTRAINT [fk_odgovor_dodijeljen1]
GO
ALTER TABLE [ePodrska].[odgovor]  WITH CHECK ADD  CONSTRAINT [fk_odgovor_pitanje1] FOREIGN KEY([pitanje_id])
REFERENCES [ePodrska].[pitanje] ([pitanje_id])
GO
ALTER TABLE [ePodrska].[odgovor] CHECK CONSTRAINT [fk_odgovor_pitanje1]
GO
ALTER TABLE [ePodrska].[pitanje]  WITH CHECK ADD  CONSTRAINT [FK_Tvrtka1] FOREIGN KEY([tvrtka_id])
REFERENCES [ePodrska].[tvrtka] ([tvrtka_id])
GO
ALTER TABLE [ePodrska].[pitanje] CHECK CONSTRAINT [FK_Tvrtka1]
GO
ALTER TABLE [ePodrska].[tvrtka]  WITH CHECK ADD  CONSTRAINT [fk_kategorija_korisnik1] FOREIGN KEY([moderator_id])
REFERENCES [ePodrska].[korisnik] ([korisnik_id])
GO
ALTER TABLE [ePodrska].[tvrtka] CHECK CONSTRAINT [fk_kategorija_korisnik1]
GO
ALTER TABLE [ePodrska].[zaposlenik]  WITH CHECK ADD  CONSTRAINT [fk_tvrtka_has_korisnik_korisnik1] FOREIGN KEY([korisnik_id])
REFERENCES [ePodrska].[korisnik] ([korisnik_id])
GO
ALTER TABLE [ePodrska].[zaposlenik] CHECK CONSTRAINT [fk_tvrtka_has_korisnik_korisnik1]
GO
ALTER TABLE [ePodrska].[zaposlenik]  WITH CHECK ADD  CONSTRAINT [fk_tvrtka_has_korisnik_tvrtka1] FOREIGN KEY([tvrtka_id])
REFERENCES [ePodrska].[tvrtka] ([tvrtka_id])
GO
ALTER TABLE [ePodrska].[zaposlenik] CHECK CONSTRAINT [fk_tvrtka_has_korisnik_tvrtka1]
GO
USE [master]
GO
ALTER DATABASE [projekt] SET  READ_WRITE 
GO
