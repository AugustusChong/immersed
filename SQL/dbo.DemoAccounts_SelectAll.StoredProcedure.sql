﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[DemoAccounts_SelectAll]    Script Date: 12/17/2022 11:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <11/23/2022>
-- Description: <Selects all Demo Accounts>
-- Code Reviewer: R****l L*****o

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer: 
-- Note:
-- =============================================

CREATE PROC [dbo].[DemoAccounts_SelectAll]

AS

/*

    EXECUTE dbo.DemoAccounts_SelectAll

*/

BEGIN

    SELECT   [Id]
            ,[CreatedBy]
            ,[OrgId]
            ,[StartDate]
            ,[ExpirationDate]
            ,[TotalCount] = COUNT(1) OVER()
    FROM    [dbo].[DemoAccounts]

    ORDER BY [Id]

END

GO
