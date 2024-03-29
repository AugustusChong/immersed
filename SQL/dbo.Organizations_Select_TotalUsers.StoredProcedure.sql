﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[Organizations_Select_TotalUsers]    Script Date: 12/17/2022 11:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <11/19/2022>
-- Description: <Selects Total Users of each Organization with Name>
-- Code Reviewer: <P******o A***s d*s S****s>

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer:
-- Note:
-- =============================================

CREATE PROC [dbo].[Organizations_Select_TotalUsers]

AS

/*

    EXECUTE [dbo].[Organizations_Select_TotalUsers]

*/

BEGIN

    SELECT      uor.[OrgId]
                ,o.[Name] AS OrganizationName
                ,[TotalUsers] = COUNT(*)
    FROM        [dbo].[Organizations] AS o 
    INNER JOIN  [dbo].[UserOrgRoles] AS uor 
    ON          o.[Id] = uor.[OrgId]
    GROUP BY    uor.[OrgId]
                ,o.[Name]
    ORDER BY    OrganizationName ASC

END

GO
