USE [master]
GO

/****** Object:  Database [LOG_SSIS]    Script Date: 23/12/2021 20:21:07 ******/
CREATE DATABASE [LOG_SSIS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LOG_SSIS', FILENAME = N'D:\SQL2012\DADOS\LOG_SSIS.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LOG_SSIS_log', FILENAME = N'D:\SQL2012\LOG\LOG_SSIS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [LOG_SSIS] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LOG_SSIS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [LOG_SSIS] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [LOG_SSIS] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [LOG_SSIS] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [LOG_SSIS] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [LOG_SSIS] SET ARITHABORT OFF 
GO

ALTER DATABASE [LOG_SSIS] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [LOG_SSIS] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [LOG_SSIS] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [LOG_SSIS] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [LOG_SSIS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [LOG_SSIS] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [LOG_SSIS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [LOG_SSIS] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [LOG_SSIS] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [LOG_SSIS] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [LOG_SSIS] SET  DISABLE_BROKER 
GO

ALTER DATABASE [LOG_SSIS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [LOG_SSIS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [LOG_SSIS] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [LOG_SSIS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [LOG_SSIS] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [LOG_SSIS] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [LOG_SSIS] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [LOG_SSIS] SET RECOVERY FULL 
GO

ALTER DATABASE [LOG_SSIS] SET  MULTI_USER 
GO

ALTER DATABASE [LOG_SSIS] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [LOG_SSIS] SET DB_CHAINING OFF 
GO

ALTER DATABASE [LOG_SSIS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [LOG_SSIS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [LOG_SSIS] SET  READ_WRITE 
GO


