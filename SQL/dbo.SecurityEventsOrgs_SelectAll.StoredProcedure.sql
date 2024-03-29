﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[SecurityEventsOrgs_SelectAll]    Script Date: 12/17/2022 11:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <12/09/2022>
-- Description: <Selects Organizations with Security Events>
-- Code Reviewer: <J*e M****a>

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[SecurityEventsOrgs_SelectAll]

AS

/*

    EXECUTE [dbo].[SecurityEventsOrgs_SelectAll]

*/

BEGIN

    SELECT      o.[Id] AS OrgId
                ,o.[Name] AS OrgName
    FROM        [dbo].[Organizations] AS o
    INNER JOIN  [dbo].[TrainingUnits] AS tu
    ON          o.[Id] = tu.[OrganizationId]
    INNER JOIN  [dbo].[Trainees] AS t
    ON          tu.[Id] = t.[TrainingUnitId]
    INNER JOIN  [dbo].[TraineeAccounts] AS ta
    ON          t.[Id] = ta.[TraineeId]
    INNER JOIN  [dbo].[SecurityEvents] AS se
    ON          ta.[Id] = se.[TraineeAccountId]
    GROUP BY    o.[Id]
                ,o.[Name]
    ORDER BY    OrgId

END

GO
