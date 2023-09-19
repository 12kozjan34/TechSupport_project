USE [master]
GO
/****** Object:  Database [projekt]    Script Date: 19/09/2023 09:50:01 ******/
CREATE DATABASE [projekt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'projekt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\projekt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'projekt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\projekt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [projekt] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [projekt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [projekt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [projekt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [projekt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [projekt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [projekt] SET ARITHABORT OFF 
GO
ALTER DATABASE [projekt] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [projekt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [projekt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [projekt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [projekt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [projekt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [projekt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [projekt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [projekt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [projekt] SET  ENABLE_BROKER 
GO
ALTER DATABASE [projekt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [projekt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [projekt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [projekt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [projekt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [projekt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [projekt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [projekt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [projekt] SET  MULTI_USER 
GO
ALTER DATABASE [projekt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [projekt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [projekt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [projekt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [projekt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [projekt] SET QUERY_STORE = OFF
GO
USE [projekt]
GO
/****** Object:  Schema [ePodrska]    Script Date: 19/09/2023 09:50:01 ******/
CREATE SCHEMA [ePodrska]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Table [ePodrska].[korisnik]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Table [ePodrska].[odgovor]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Table [ePodrska].[pitanje]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Table [ePodrska].[tip_korisnika]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Table [ePodrska].[tvrtka]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Table [ePodrska].[zaposlenik]    Script Date: 19/09/2023 09:50:01 ******/
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
/****** Object:  Index [fk_korisnik_tip_korisnika_idx]    Script Date: 19/09/2023 09:50:01 ******/
CREATE NONCLUSTERED INDEX [fk_korisnik_tip_korisnika_idx] ON [ePodrska].[korisnik]
(
	[tip_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_odgovor_dodijeljen1_idx]    Script Date: 19/09/2023 09:50:01 ******/
CREATE NONCLUSTERED INDEX [fk_odgovor_dodijeljen1_idx] ON [ePodrska].[odgovor]
(
	[zaposlenik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_odgovor_pitanje1_idx]    Script Date: 19/09/2023 09:50:01 ******/
CREATE NONCLUSTERED INDEX [fk_odgovor_pitanje1_idx] ON [ePodrska].[odgovor]
(
	[pitanje_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_pitanje_kategorija1_idx]    Script Date: 19/09/2023 09:50:01 ******/
CREATE NONCLUSTERED INDEX [fk_pitanje_kategorija1_idx] ON [ePodrska].[pitanje]
(
	[tvrtka_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_kategorija_korisnik1_idx]    Script Date: 19/09/2023 09:50:01 ******/
CREATE NONCLUSTERED INDEX [fk_kategorija_korisnik1_idx] ON [ePodrska].[tvrtka]
(
	[moderator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_tvrtka_has_korisnik_korisnik1_idx]    Script Date: 19/09/2023 09:50:01 ******/
CREATE NONCLUSTERED INDEX [fk_tvrtka_has_korisnik_korisnik1_idx] ON [ePodrska].[zaposlenik]
(
	[korisnik_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [fk_tvrtka_has_korisnik_tvrtka1_idx]    Script Date: 19/09/2023 09:50:01 ******/
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
