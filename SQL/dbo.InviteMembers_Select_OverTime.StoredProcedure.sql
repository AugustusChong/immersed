﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[InviteMembers_Select_OverTime]    Script Date: 12/17/2022 11:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <12/02/2022>
-- Description: <Selects the amount of Pending Users over time>
-- Code Reviewer: <E**n D****e>

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer: 
-- Note:
-- =============================================

CREATE proc [dbo].[InviteMembers_Select_OverTime]

AS

/*

    EXECUTE [dbo].[InviteMembers_Select_OverTime]

*/

BEGIN

    SELECT      DATEADD(MONTH, DATEDIFF(MONTH, 0, [DateCreated]), 0) AS DateCreated
                ,COUNT([Id]) AS PendingUsers
    FROM        [dbo].[InviteMembers]
    GROUP BY    DATEADD(MONTH, DATEDIFF(MONTH, 0, [DateCreated]), 0)

END

GO
