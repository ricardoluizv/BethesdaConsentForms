USE [BethesdaCollege ]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[Fname] [varchar](256) NULL,
	[Lname] [varchar](256) NULL,
	[FullName] [varchar](512) NULL,
	[BirthDate] [datetime] NULL,
	[Age] [int] NULL,
	[Gender] [varchar](10) NULL,
	[MR#] [varchar](250) NULL,
	[PrimaryDoctor] [int] NULL,
	[AssociatedDoctor] [int] NULL,
	[AdmDate] [datetime] NULL,
	[Location] [nchar](10) NULL,
	[ConsentFormType] [nvarchar](max) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Doctor_Procedures]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor_Procedures](
	[ProcID] [int] NOT NULL,
	[UniqueID] [int] NOT NULL,
	[PrimaryDoctorID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConsentType]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConsentType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ConsentType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConsentForm]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConsentForm](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ConsentForm] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CFSignatures]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFSignatures](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CFOrder] [smallint] NOT NULL,
 CONSTRAINT [PK_CFSignatures] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CFProcedures]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CFProcedures](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CFProcedures] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treatment_Signature]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatment_Signature](
	[SignatureId] [int] NOT NULL,
	[TContent] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[TSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treatment]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treatment](
	[PatentId] [int] NOT NULL,
	[ConsentType] [int] NOT NULL,
	[IsPatientunabletosign] [bit] NOT NULL,
	[Unabletosignreason] [nvarchar](max) NOT NULL,
	[TrackingID] [int] NOT NULL,
	[Signatures] [int] NOT NULL,
	[DoctorandProcedure] [int] NOT NULL,
	[TransaltedBy] [nvarchar](max) NOT NULL,
	[Date] [datetime] NOT NULL,
	[IsStatementOfConsentAccepted] [bit] NOT NULL,
	[IsAutologousUnits] [bit] NOT NULL,
	[IsDirectedUnits] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrackingInformation]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackingInformation](
	[Device] [nvarchar](max) NOT NULL,
	[IP] [nvarchar](50) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TrackingInformation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Signatures]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Signatures](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Signatures] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhysicianCategory]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhysicianCategory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PhysicianCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Physician]    Script Date: 11/30/2012 12:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Physician](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Associated] [bit] NOT NULL,
	[PH_Primary] [nvarchar](max) NOT NULL,
	[PCID] [int] NOT NULL,
 CONSTRAINT [PK_Physician_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_Physician_PhysicianCategory1]    Script Date: 11/30/2012 12:39:59 ******/
ALTER TABLE [dbo].[Physician]  WITH CHECK ADD  CONSTRAINT [FK_Physician_PhysicianCategory1] FOREIGN KEY([PCID])
REFERENCES [dbo].[PhysicianCategory] ([ID])
GO
ALTER TABLE [dbo].[Physician] CHECK CONSTRAINT [FK_Physician_PhysicianCategory1]
GO
