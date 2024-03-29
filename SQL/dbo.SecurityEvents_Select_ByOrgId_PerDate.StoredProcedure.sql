﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[SecurityEvents_Select_ByOrgId_PerDate]    Script Date: 12/17/2022 11:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <12/08/2022>
-- Description: <Selects Security Events of Organization by Id, based on Week, Month, and Year>
-- Code Reviewer: <J*e M****a>

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[SecurityEvents_Select_ByOrgId_PerDate]
            @OrgId int

AS

/*

    DECLARE @OrgId int = 27
    EXECUTE [dbo].[SecurityEvents_Select_ByOrgId_PerDate] 
            @OrgId

*/

BEGIN

    SELECT      CONVERT(DATE, DATEADD(dd, 0 - (@@DATEFIRST + 6 + DATEPART(dw, se.[DateCreated])) % 7, se.[DateCreated])) AS StartOfWeek
                ,DATEPART(WEEK, se.[DateCreated]) AS WeekCreated
                ,COUNT(se.[Id]) AS SecurityEvents
    FROM        [dbo].[Organizations] AS o
    INNER JOIN  [dbo].[TrainingUnits] AS tu
    ON          o.[Id] = tu.[OrganizationId]
    INNER JOIN  [dbo].[Trainees] AS t
    ON          tu.[Id] = t.[TrainingUnitId]
    INNER JOIN  [dbo].[TraineeAccounts] AS ta
    ON          t.[Id] = ta.[TraineeId]
    INNER JOIN  [dbo].[SecurityEvents] AS se
    ON          ta.[Id] = se.[TraineeAccountId]
    WHERE       o.[Id] = @OrgId
    GROUP BY    CONVERT(DATE, DATEADD(dd, 0 - (@@DATEFIRST + 6 + DATEPART(dw, se.[DateCreated])) % 7, se.[DateCreated]))
                ,DATEPART(WEEK, se.[DateCreated])
    ORDER BY    StartOfWeek DESC

    SELECT      DATEADD(MONTH, DATEDIFF(MONTH, 0, se.[DateCreated]), 0) AS ISOMonth
                ,DATEPART(MONTH, se.[DateCreated]) AS MonthCreated
                ,COUNT(se.[Id]) AS SecurityEvents
    FROM        [dbo].[Organizations] AS o
    INNER JOIN  [dbo].[TrainingUnits] AS tu
    ON          o.[Id] = tu.[OrganizationId]
    INNER JOIN  [dbo].[Trainees] AS t
    ON          tu.[Id] = t.[TrainingUnitId]
    INNER JOIN  [dbo].[TraineeAccounts] AS ta
    ON          t.[Id] = ta.[TraineeId]
    INNER JOIN  [dbo].[SecurityEvents] AS se
    ON          ta.[Id] = se.[TraineeAccountId]
    WHERE       o.[Id] = @OrgId
    GROUP BY    DATEADD(MONTH, DATEDIFF(MONTH, 0, se.[DateCreated]), 0)
                ,DATEPART(MONTH, se.[DateCreated])
    ORDER BY    ISOMonth DESC

    SELECT      DATEADD(YEAR, DATEDIFF(YEAR,0,se.[DateCreated]), 0) AS ISOYear
                ,DATEPART(YEAR, se.[DateCreated]) AS YearCreated
                ,COUNT(se.[Id]) AS SecurityEvents
    FROM        [dbo].[Organizations] AS o
    INNER JOIN  [dbo].[TrainingUnits] AS tu
    ON          o.[Id] = tu.[OrganizationId]
    INNER JOIN  [dbo].[Trainees] AS t
    ON          tu.[Id] = t.[TrainingUnitId]
    INNER JOIN  [dbo].[TraineeAccounts] AS ta
    ON          t.[Id] = ta.[TraineeId]
    INNER JOIN  [dbo].[SecurityEvents] AS se
    ON          ta.[Id] = se.[TraineeAccountId]
    WHERE       o.[Id] = @OrgId
    GROUP BY    DATEADD(YEAR, DATEDIFF(YEAR,0,se.[DateCreated]), 0)
                ,DATEPART(YEAR, se.[DateCreated])
    ORDER BY    ISOYear DESC

END

GO
