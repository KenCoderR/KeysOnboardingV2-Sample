
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/16/2018 14:34:27
-- Generated from EDMX file: C:\Users\allam\Downloads\KeysOnboardingV2-Sample\KeysOnboardingV2\Models\KeysOnboardingV2.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [TempMVP];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ProductSold_Customer]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductSold] DROP CONSTRAINT [FK_ProductSold_Customer];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductSold_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductSold] DROP CONSTRAINT [FK_ProductSold_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductSold_Store]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductSold] DROP CONSTRAINT [FK_ProductSold_Store];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Customer]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customer];
GO
IF OBJECT_ID(N'[dbo].[Product]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Product];
GO
IF OBJECT_ID(N'[dbo].[ProductSold]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductSold];
GO
IF OBJECT_ID(N'[dbo].[Store]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Store];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [ProductName] nvarchar(100)  NOT NULL,
    [Price] decimal(19,4)  NOT NULL
);
GO

-- Creating table 'Stores'
CREATE TABLE [dbo].[Stores] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [StoreName] nvarchar(100)  NOT NULL,
    [Address] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [CustomerName] nvarchar(100)  NOT NULL,
    [Age] int  NOT NULL,
    [Address] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'ProductSolds'
CREATE TABLE [dbo].[ProductSolds] (
    [Id] bigint IDENTITY(1,1) NOT NULL,
    [ProductId] bigint  NOT NULL,
    [CustomerId] bigint  NOT NULL,
    [StoreId] int  NOT NULL,
    [DateSold] datetime  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Stores'
ALTER TABLE [dbo].[Stores]
ADD CONSTRAINT [PK_Stores]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ProductSolds'
ALTER TABLE [dbo].[ProductSolds]
ADD CONSTRAINT [PK_ProductSolds]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CustomerId] in table 'ProductSolds'
ALTER TABLE [dbo].[ProductSolds]
ADD CONSTRAINT [FK_ProductSold_Customer]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductSold_Customer'
CREATE INDEX [IX_FK_ProductSold_Customer]
ON [dbo].[ProductSolds]
    ([CustomerId]);
GO

-- Creating foreign key on [ProductId] in table 'ProductSolds'
ALTER TABLE [dbo].[ProductSolds]
ADD CONSTRAINT [FK_ProductSold_Product]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductSold_Product'
CREATE INDEX [IX_FK_ProductSold_Product]
ON [dbo].[ProductSolds]
    ([ProductId]);
GO

-- Creating foreign key on [StoreId] in table 'ProductSolds'
ALTER TABLE [dbo].[ProductSolds]
ADD CONSTRAINT [FK_ProductSold_Store]
    FOREIGN KEY ([StoreId])
    REFERENCES [dbo].[Stores]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductSold_Store'
CREATE INDEX [IX_FK_ProductSold_Store]
ON [dbo].[ProductSolds]
    ([StoreId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------