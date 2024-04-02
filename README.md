<p align="center">
    <img alt="snarkVM" width="200" src="https://i.ibb.co/MVytBck/Capture-d-e-cran-2024-03-26-a-14-04-11.png"/>
</p>

snarkDB is a tool for exposing any RDBMS to zero knowledge SQL queries. Allowing a wide range of usecases such as private set intersection, proof of data origin or proof of conform processing over saved data.

## Table of Contents

- [1. Getting started](#1-getting-started)
- [2. Datasources](#2-datasources)
  - [2.1 Available datasources](#21-available-datasources)
  - [2.2 Add a datasource](#22-add-a-datasource)
  - [2.3 List datasources](#23-list-datasources)
- [3. Tables](#3-tables)

## 1. Getting started

### 1.1 Install

```bash
npm install
```

### 1.2 Setting up an account

Generate and save a new account:

```bash
node . account new | \
awk 'NR==4 {print "MNEMONIC="substr($0, 17)}' \
> .env.local
```

Verify it was generated correctly:

```bash
node . account test
```

## 2. Datasources

A datasource is a RDBMS connected to your snarkDB instance so you can expose its tables to ZK queries.

### 2.1 Available datasources

Supported RDBMS are:

| RDBMS | SELECT | JOIN | INSERT |
| :- | :-: |  :-: |  :-: |
| [mysql](./DATASOURCES.MD#mysql--mariadb-data-source-options) | ✅ | 🕑 | 🕑 |
| [postgres](./DATASOURCES.MD#postgres--cockroachdb-data-source-options) | ✅ | 🕑 | 🕑 |
| [oracle](./DATASOURCES.MD#oracle-data-source-options) | ✅ | 🕑 | 🕑 |
| [mongodb](./DATASOURCES.MD#mongodb-data-source-options) | ✅ | 🕑 | 🕑 |
| [sqlite](./DATASOURCES.MD#sqlite-data-source-options) | ✅ | 🕑 | 🕑 |
| [sap](./DATASOURCES.MD#) | ✅ | 🕑 | 🕑 |
| [mssql](./DATASOURCES.MD#mssql-data-source-options) | ✅ | 🕑 | 🕑 |
| [mariadb](./DATASOURCES.MD#mysql--mariadb-data-source-options) | ✅ | 🕑 | 🕑 |
| [cockroachdb](./DATASOURCES.MD#postgres--cockroachdb-data-source-options) | ✅ | 🕑 | 🕑 |
| [spanner](./DATASOURCES.MD#) | ✅ | 🕑 | 🕑 |
| [cordova](./DATASOURCES.MD#cordova-data-source-options) | ✅ | 🕑 | 🕑 |
| [react-native](./DATASOURCES.MD#react-native-data-source-options) | ✅ | 🕑 | 🕑 |
| [nativescript](./DATASOURCES.MD#nativescript-data-source-options) | ✅ | 🕑 | 🕑 |
| [sqljs](./DATASOURCES.MD#sqljs-data-source-options) | ✅ | 🕑 | 🕑 |
| [aurora-mysql](./DATASOURCES.MD#mysql--mariadb-data-source-options) | ✅ | 🕑 | 🕑 |
| [aurora-postgres](./DATASOURCES.MD#postgres--cockroachdb-data-source-options) | ✅ | 🕑 | 🕑 |
| [expo](./DATASOURCES.MD#expo-data-source-options) | ✅ | 🕑 | 🕑 |
| [better-sqlite3](./DATASOURCES.MD#better-sqlite3-data-source-options) | ✅ | 🕑 | 🕑 |
| [capacitor](./DATASOURCES.MD#capacitor-data-source-options) | ✅ | 🕑 | 🕑 |

For all available options for each datasource type, see [datasources documentation](./DATASOURCES.MD).

### 2.2 Add a datasource

To connect a RDBMS to your snarkDB instance:

```bash
node . datasource add \
  --identifier mysql_database \
  --datasourceJson '{
    "type": "mysql",
    "host": "127.0.0.1",
    "port": 3306,
    "username": "root",
    "password": "my-secret-pw",
    "database": "testdb"
  }'
```

### 2.3 List datasources

Check the datasource was correctly added:

```bash
node . datasource list
```

## 3. Tables

### 3.1 Expose a table

In snarkDB, exposing a table means sharing a subset of its columns names and types to a defined set of users (snarkDB IDs).

Exposed table can then be queried by those users. Those SQL queries are then accepted or not by from(s) table(s) owner(s).

Table data (its rows) **are NOT shared** when a table is exposed, only after a query is accepted. **Only query result is divulgated to querier, not intermediate results or origin table data.**

To expose a table:

```bash
node . table expose \
  --datasource mysql_database \
  --sourceTable consumers \
  --destinationTable users \
  --visibility 'public' \
  --capacity 10 \
  # --syncPeriod 3600 \
  # --columnsMapping 'user_id:id,age,is_activated' \
```

- `datasource` - Identifier of the datasource where table is located.
This option is **required**.

- `sourceTable` - Name of the table within this datasource.
This option is **required**.

- `destinationTable` - Identifier of the table within snarkDB.
This option is **required**.

- `visibility` - Who the table is exposed to, (ie: users who can see the exposed table column name and types as well as initiate query involving it).
Either `'public'` or a list of comma separated  snarkDB IDs (or peer identifiers) as: `'steve,db1l67vf81v2d78dc23hsk'`.
This option is **required**.

- `capacity` - Maximum amount of element in the table. It allows to obfuscate the amount of elements in source table.
This option is **required**.

- `syncPeriod` - Table state is commited publicly every period (in seconds).
Default is `3600`.

- `columnsMapping` - Optional filter on exposed columns formatted as list of comma separated mappings `source_column:exposed_column`. For instance, `'user_id:id,age,is_activated'` means source column with name `user_id` is exposed as `id`, and `age` as well as `is_activated` are exposed with the same name.
When not specified, all columns are exposed by default with the same name as in source.

### 3.2 List tables

Check the table was correctly exposed:

```bash
node . table list
```

## 4. Peers

Peers are other snarkDB instances you can connect to in order to query their exposed tables.

### 4.1 Add a peer

```bash
node . peer add \
  --identifier 'steve' \
  --snarkdbId 'db1f2jcvdca2tl8d7e8fdmpxarscrscxqx6gm277s6d9gepdx3pd58qqfqgqyfzq7hjngl6j93qte6uwurn2g9yeu07l06phpkjqmt9r9n4tt80ev8h366r0h' \
  --host '192.168.1.12' \
  --port 3020
```

### 4.2 List peers

Check the peer was correctly added:

```bash
node . peer list
```

### 4.3 List peer tables

To list tables exposed to your snarkDB account of a specific peer:

```bash
node . peer tables
  --peerId steve
```

## 5. Queries

### 5.1 Initiate a query

```bash
node . query execute '
SELECT column1 as col1
FROM peer_name.first_table
'
```

## 5.2 Start instance

A snarkDB instance receives, sends, executes, verifies queries.

```bash
npm run start
```

## 6. Build

### 6.1 Build for production

```bash
npm run build
```

### 6.2 Build during development

```bash
npm run dev
```

## 7. Roadmap

- Peer support in table expose
- Account new --save --overwrite
- String support
- Nested query (proof + verification)
- JOIN (mechanism is ready)
- Expressions for selected columns (Arithemtics + String manipulation)
- INSERT INTO support of query results
