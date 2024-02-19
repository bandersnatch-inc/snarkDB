import NodeSQLParser from "node-sql-parser";

import { execute_insert_query } from "./insert.js";
import { execute_select_query } from "./select.js";
import { execute_create_table_query } from "./create.js";
export { retrieve_query_result } from "./result.js";

import { display_error } from "utils/errors.js";


export const execute_query = async (query) => {
  query = String(query)
  const parser = new NodeSQLParser.Parser();
  let ast;
  let sql;
  try {
    ast = parser.astify(query);
    console.log("Executing query:");
    sql = parser.sqlify(ast);
    console.log(sql);
    console.log();
  } catch (e) {
    console.log("/!\\ Error parsing query: ");
    display_error(e);
    return;
  }
  try {
    await execute_parsed_query(ast, sql);
  } catch (e) {
    console.log("/!\\ Error executing query: ");
    display_error(e);
    return;
  }
};


const execute_parsed_query = async (query, sql) => {
  if (query.type === "insert")
    throw new Error("INSERT queries are not supported yet.");// return await execute_insert_query(query);
  if (query.type === "select")
    return await execute_select_query(query, sql);
  if (query.type === "create") {
    if (query.keyword === "table")
      throw new Error("CREATE TABLE queries are not supported yet.");// return await execute_create_table_query(query);
    if (query.keyword === "database")
      throw Error(
        "A database is an Aleo account. "
        + "Create one by using 'snarkos account new'"
      );
    throw Error(`Unsupported 'create' query: '${query.keyword}'.`);
  }
  throw Error(`Unsupported query: ${query.type}`);
};



export const list_queries = async (incoming, outgoing, all) => {

}