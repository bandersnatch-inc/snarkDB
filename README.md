# snarkDB

snarkDB is a tool for exposing any RDBMS to zero knowledge SQL queries. Allowing a wide range of usecases as private set intersection, proof of data origin/processing, and more.

## Install

```bash
npm install
```

## Datasources

Supported RDBMS are:

- mysql
- postgres
- cockroachdb
- sap
- spanner
- mariadb
- sqlite
- cordova
- react-native
- nativescript
- sqljs
- oracle
- mssql
- mongodb
- aurora-mysql
- aurora-postgres
- expo
- better-sqlite3
- capacitor

For more information, see [typeorm datasources documentation](https://github.com/typeorm/typeorm/blob/master/docs/data-source-options.md#what-is-datasourceoptions).

## Environment variables

Duplicate `.env.local.example` file and rename it to `.env.local`.
Update it with your own Aleo private key.

## Create Table

```bash
snarkdb execute "\
CREATE TABLE table2 \
(
    col_2_1 INT,
    col_2_2 INT,
    col_2_3 BOOLEAN
)
"
```

## Insert row

```bash
node . execute "\
INSERT INTO table2 \
  (col_2_1, col_2_2, col_2_3) \
VALUES \
  (\
    1,\
    123,\
    true
  )\
"
```

## Select request

```bash
node . execute "\
SELECT column1 as col1 \
FROM aleo103nyxgwktwavyv4l06mns6cqze3s9l6dwu7w8hvfkasrzrs4k5pscv370h.first_table
"
```

## Table name format rules

- 25 characters maximum
- First character : lowercase letter
- Other characters : lowercase letter | underscore | digit

## Implemented

- CREATE TABLE
- INSERT
- JOIN
- Single table WHERE

## Left to implement

- DELETE
- JOIN
- UPDATE
- INSERT TABLE
- Multiple table WHERE
- JOIN

## Accounts

table2 owner :
  Private Key  APrivateKey1zkpHkJ47qxn8FjHgYhKotRv9cJxeGCLg42tezqhd6xZNWYD
      Address  aleo1386l43hhduwmh7jdpnsfg7twwnkhzmjfp2zg89qadqq5al2d8sgsw96584

select owner :
  Private Key  APrivateKey1zkpEUzXebwrhENw2EpDwvfW1Y6n42HUpwpDnD65jGx3aQ2r
      Address  aleo1l96m5aqndzqm6253xee2j887xxh4c6w6h9ksdaknst9mq3xrfv8senek7g

nested_select owner :
  Private Key  APrivateKey1zkp8ynLk3wcRb4XzZ3C72mnt5fe8bNcpJ9MVxuBH4kqcvVf
      Address  aleo15wktn0yr8vhxfzh9td7zhnrge9u6hra8tg4qtv2p9dumwc9mwgzqq63rlg

##
