﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[Organizations_Select_TotalTrainees]    Script Date: 12/17/2022 11:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <12/06/2022>
-- Description: <Selects Total Active Trainees of each Organization with Name>
-- Code Reviewer: <E**n D****e>

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer: 
-- Note:
-- =============================================

CREATE PROC [dbo].[Organizations_Select_TotalTrainees]

AS

/*

    EXECUTE [dbo].[Organizations_Select_TotalTrainees]

*/

BEGIN

    SELECT       o.[Id] AS OrgId
                ,o.[Name] AS OrganizationName
                ,COUNT(t.[Id]) AS ActiveTrainees
    FROM        [dbo].[Trainees] AS t
    INNER JOIN  [dbo].[TrainingUnits] AS tu
    ON          t.[TrainingUnitId] = tu.[Id]
    INNER JOIN  [dbo].[Organizations] AS o
    ON          tu.[OrganizationId] = o.[Id]
    WHERE       t.[TraineeStatusId] = 1
    GROUP BY     o.[Id]
                ,o.[Name]
    ORDER BY    OrganizationName ASC

END

GO
