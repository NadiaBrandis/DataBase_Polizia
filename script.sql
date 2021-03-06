USE [master]
GO
/****** Object:  Database [Polizia_Nadia]    Script Date: 14/05/2021 12:10:34 ******/
CREATE DATABASE [Polizia_Nadia]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Polizia_Nadia', FILENAME = N'C:\Users\39347\Polizia_Nadia.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Polizia_Nadia_log', FILENAME = N'C:\Users\39347\Polizia_Nadia_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Polizia_Nadia] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Polizia_Nadia].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Polizia_Nadia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET ARITHABORT OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Polizia_Nadia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Polizia_Nadia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Polizia_Nadia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Polizia_Nadia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Polizia_Nadia] SET  MULTI_USER 
GO
ALTER DATABASE [Polizia_Nadia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Polizia_Nadia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Polizia_Nadia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Polizia_Nadia] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Polizia_Nadia] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Polizia_Nadia] SET QUERY_STORE = OFF
GO
USE [Polizia_Nadia]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [Polizia_Nadia]
GO
/****** Object:  Table [dbo].[AgentePolizia]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgentePolizia](
	[IdAgente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Cognome] [nvarchar](50) NOT NULL,
	[CodiceFiscale] [nchar](16) NOT NULL,
	[DataNascita] [date] NOT NULL,
	[AnniServizio] [int] NOT NULL,
 CONSTRAINT [PK_AgentePolizia] PRIMARY KEY CLUSTERED 
(
	[IdAgente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_AgentePolizia] UNIQUE NONCLUSTERED 
(
	[CodiceFiscale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AreaMetropolitana]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaMetropolitana](
	[IdArea] [int] IDENTITY(1,1) NOT NULL,
	[CodiceArea] [nchar](5) NOT NULL,
	[AltoRischio] [bit] NOT NULL,
 CONSTRAINT [PK_AreaMetropolitana] PRIMARY KEY CLUSTERED 
(
	[IdArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AgentiConArea]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AgentiConArea]
AS
SELECT        dbo.AgentePolizia.IdAgente, dbo.AgentePolizia.Nome, dbo.AgentePolizia.Cognome, dbo.AgentePolizia.AnniServizio, dbo.AreaMetropolitana.AltoRischio
FROM            dbo.AgentePolizia CROSS JOIN
                         dbo.AreaMetropolitana
GO
/****** Object:  Table [dbo].[Pattuglia]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pattuglia](
	[IdArea] [int] NOT NULL,
	[IdAgente] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pattuglia]  WITH CHECK ADD  CONSTRAINT [FK_Pattuglia_AgentePolizia] FOREIGN KEY([IdAgente])
REFERENCES [dbo].[AgentePolizia] ([IdAgente])
GO
ALTER TABLE [dbo].[Pattuglia] CHECK CONSTRAINT [FK_Pattuglia_AgentePolizia]
GO
ALTER TABLE [dbo].[Pattuglia]  WITH CHECK ADD  CONSTRAINT [FK_Pattuglia_AreaMetropolitana] FOREIGN KEY([IdArea])
REFERENCES [dbo].[AreaMetropolitana] ([IdArea])
GO
ALTER TABLE [dbo].[Pattuglia] CHECK CONSTRAINT [FK_Pattuglia_AreaMetropolitana]
GO
ALTER TABLE [dbo].[AgentePolizia]  WITH CHECK ADD  CONSTRAINT [CK_AgentePolizia_1] CHECK  (([DataNascita]<'2003-5-13'))
GO
ALTER TABLE [dbo].[AgentePolizia] CHECK CONSTRAINT [CK_AgentePolizia_1]
GO
/****** Object:  StoredProcedure [dbo].[AgentiPerArea]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AgentiPerArea]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        COUNT(dbo.AgentiConArea.IdAgente) AS NumeroAgenti, dbo.AreaMetropolitana.CodiceArea AS codiceArea
FROM            dbo.AreaMetropolitana INNER JOIN
                         dbo.Pattuglia ON dbo.AreaMetropolitana.IdArea = dbo.Pattuglia.IdArea CROSS JOIN
                         dbo.AgentiConArea
GROUP BY dbo.AreaMetropolitana.CodiceArea
END
GO
/****** Object:  StoredProcedure [dbo].[AgentiRischio]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AgentiRischio]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Nome,Cognome,IdAgente from AgentiConArea where AnniServizio<3 and AltoRischio=1
END
GO
/****** Object:  StoredProcedure [dbo].[EliminazioneAgente]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EliminazioneAgente]
	-- Add the parameters for the stored procedure here
	@idAgente int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from AgentePolizia  where IdAgente=@idAgente
	delete from Pattuglia where IdAgente=@idAgente
	
END
GO
/****** Object:  StoredProcedure [dbo].[IdentificazioneArea]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[IdentificazioneArea]
	-- Add the parameters for the stored procedure here
	@codiceArea nchar(5),
	@rischio bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into AreaMetropolitana values(@codiceArea,@rischio)
END
GO
/****** Object:  StoredProcedure [dbo].[InserimentoAgente]    Script Date: 14/05/2021 12:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InserimentoAgente] 
	-- Add the parameters for the stored procedure here
	@nome nvarchar(30),
	@cognome nvarchar(50),
	@codiceFiscale nchar(16),
	@dataNascita date,
	@anniServizio int,
	@idArea nchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into AgentePolizia(Nome,Cognome,CodiceFiscale,DataNascita,AnniServizio)
	values(@nome,@cognome,@codiceFiscale,@dataNascita,@anniServizio)
	declare @idAgente int=@@identity
	select @idAgente=IdAgente from Pattuglia where IdArea=@idArea
	insert into Pattuglia(IdAgente,IdArea)values (@idAgente,@idArea)

END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[3] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AgentePolizia"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AreaMetropolitana"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 119
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AgentiConArea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AgentiConArea'
GO
USE [master]
GO
ALTER DATABASE [Polizia_Nadia] SET  READ_WRITE 
GO
