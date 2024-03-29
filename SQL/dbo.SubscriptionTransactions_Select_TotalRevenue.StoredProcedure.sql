﻿USE [Immersed]
GO
/****** Object:  StoredProcedure [dbo].[SubscriptionTransactions_Select_TotalRevenue]    Script Date: 12/27/2022 11:54:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Augustus Chong>
-- Create date: <12/14/2022>
-- Description: <Selects Total Revenue for Weeks, Months, Year>
-- Code Reviewer: <H*i S***e Jr.>

-- MODIFIED BY: author
-- MODIFIED DATE: mm/dd/yyyy
-- Code Reviewer:
-- Note:
-- =============================================

CREATE proc [dbo].[SubscriptionTransactions_Select_TotalRevenue]

/*

    EXECUTE [dbo].[SubscriptionTransactions_Select_TotalRevenue]

*/

AS

BEGIN

    SELECT      CONVERT(DATE, DATEADD(dd, 0 - (@@DATEFIRST + 6 + DATEPART(dw, [PurchaseDate])) % 7, [PurchaseDate])) AS PurchaseWeek
                ,SUM([Amount]) - ISNULL(SUM([RefundedAmount]),0) AS TotalRevenue
    FROM        [dbo].[SubscriptionTransactions]
    GROUP BY    CONVERT(DATE, DATEADD(dd, 0 - (@@DATEFIRST + 6 + DATEPART(dw, [PurchaseDate])) % 7, [PurchaseDate]))

    SELECT      DATEADD(MONTH, DATEDIFF(MONTH, 0, [PurchaseDate]), 0) AS PurchaseMonth
                ,SUM([Amount]) - ISNULL(SUM([RefundedAmount]),0) AS TotalRevenue
    FROM        [dbo].[SubscriptionTransactions]
    GROUP BY    DATEADD(MONTH, DATEDIFF(MONTH, 0, [PurchaseDate]), 0)

    SELECT      DATEADD(YEAR, DATEDIFF(YEAR, 0, [PurchaseDate]), 0) AS PurchaseYear
                ,SUM([Amount]) - ISNULL(SUM([RefundedAmount]),0) AS TotalRevenue
    FROM        [dbo].[SubscriptionTransactions]
    GROUP BY    DATEADD(Year, DATEDIFF(YEAR, 0, [PurchaseDate]), 0)

END

GO
