// Databricks notebook source
// MAGIC %md
// MAGIC ### Parameters declaration.
// MAGIC 1. Connection parameters for SQL Server Data Warehouse.
// MAGIC 2. Paths to Azure Data Lake raw data
// MAGIC 3. Paths to Azure Data Lake bronze layer (parquet files converted from CSV and JSON )

// COMMAND ----------

// Connection parameters for SQL Server Data Warehouse.
val jdbcUrl = "jdbc:sqlserver://uwbigdata.database.windows.net:1433;database=bigdata530"
val sqlServerUser = dbutils.secrets.get("sql-server", "user")
val sqlServerPassword = dbutils.secrets.get("sql-server", "password")

// Paths to Azure Data Lake
val abfssStorageAccount = "bd510fall23"
val bd530StorageContainer = "bd530"
val dataSourceDirRoot = "raw-data"
val abfssSourceDirPath = s"abfss://${bd530StorageContainer}@${abfssStorageAccount}.dfs.core.windows.net/raw-data/"
// display(dbutils.fs.ls(abfssSourceDirPath))

//Paths to a group directory (parquet files converted from CSV and JSON )
val groupDContainer = "retail-data-lake-group-4"
val abfssBronzeFiles = s"abfss://${groupDContainer}@${abfssStorageAccount}.dfs.core.windows.net/bronze-layer/"
// display(dbutils.fs.ls(abfssParquetFiles))



// COMMAND ----------

// Printing the schema of a data warehouse table.
def printSchema(url: String, user: String, password: String, table: String): Unit = {
  val df = spark.read.format("jdbc").option("url", url)
                                    .option("user", user)
                                    .option("password", password)
                                    .option("dbtable", table)
                                    .load()
  println(s"Table name: $table")
  println("Number of rows: " + df.count())
  df.printSchema()
}

//Convert CSV to PARQUET
def convertCsvToParquet(csvPath: String, parquetPath: String, fileName: String): Unit = {
  val csvDF = spark.read.option("header", "true")
      .option("inferschema", "true")
      .csv(csvPath + fileName)

  csvDF.write.mode("overwrite").parquet(parquetPath + fileName)
}

//Convert JSON to PARQUET
def convertJsonToParquet(jsonPath: String, parquetPath: String, fileName: String): Unit = {
  val jsonDF = spark.read
      .option("inferschema", "true")
      .json(jsonPath + fileName)

  jsonDF.write.mode("overwrite").parquet(parquetPath + fileName)
}

//Print PARQUET schema
def printParquetSchema(path: String, fileName: String, numberOfRowsToShow: Integer): Unit = {
  val parquetDF = spark.read.parquet(path + fileName)

  println(s"File name: $fileName")
  println("Number of rows: " + parquetDF.count)
  parquetDF.printSchema()
  parquetDF.show(numberOfRowsToShow)
}


// COMMAND ----------

// MAGIC %md
// MAGIC ### Arrays of entity names from the data warehouse and raw-data directories

// COMMAND ----------

val dataWarehouseEntities = Array("call_center", "catalog_page", "catalog_returns", "catalog_sales", "customer", "customer_address", "customer_demographics", "reason")

val parquetEntities = Array("catalog_page", "catalog_sales", "customer_demographics", "household_demographics", "inventory", "store_returns", "store_sales", "web_sales")

val csvEntities = Array("catalog_page", "catalog_returns", "catalog_sales", "customer", "customer_address", "customer_demographics", "household_demographics", "inventory", "store_returns", "store_sales", "web_sales")

val jsonEntities = Array("call_center", "catalog_page", "catalog_sales", "customer_demographics", "date_dim", "household_demographics", "income_band", "inventory", "item", "promotion", "reason", "ship_mode", "store", "store_returns", "store_sales", "time_dim", "warehouse", "web_page", "web_returns", "web_sales", "web_site")


// COMMAND ----------

// MAGIC %md
// MAGIC ### Retrieving the schemas of data warehouse tables.
// MAGIC The names of the data warehouse tables were found using a connection from Azure Data Studio.

// COMMAND ----------


dataWarehouseEntities.foreach(entity => printSchema(jdbcUrl, sqlServerUser, sqlServerPassword, "dbo." + entity))

// COMMAND ----------

// MAGIC %md
// MAGIC ### Print schema of the original PARQUET files

// COMMAND ----------

parquetEntities.foreach(entity => printParquetSchema(abfssSourceDirPath + "data-parquet/", entity, 1))

// COMMAND ----------

// MAGIC %md
// MAGIC ### Converting CSV files to PARQUET files
// MAGIC The CSV files are dumped to Azure Data Lake path 'abfss://retail-data-lake-group-4@bd510fall23.dfs.core.windows.net/bronze-layer/' in order to optimize further operations.

// COMMAND ----------

csvEntities.foreach(entity => convertCsvToParquet(abfssSourceDirPath + "data-csv/", abfssBronzeFiles + "parquet-from-csv/", entity))

// COMMAND ----------

// MAGIC %md
// MAGIC ### Print schema of the original CSV files
// MAGIC As the CSV files are converted to PARQUET files the schema is read from PARQUET (much faster solution)

// COMMAND ----------

csvEntities.foreach(entity => printParquetSchema(abfssBronzeFiles + "parquet-from-csv/", entity, 1))

// COMMAND ----------

// MAGIC %md
// MAGIC ### Converting JSON files to PARQUET files
// MAGIC The CSV files are dumped to Azure Data Lake path 'abfss://retail-data-lake-group-4@bd510fall23.dfs.core.windows.net/bronze-layer/' in order to optimize further operations.

// COMMAND ----------

jsonEntities.foreach(entity => convertJsonToParquet(abfssSourceDirPath + "data-json/", abfssBronzeFiles + "parquet-from-json/", entity))

// COMMAND ----------

// MAGIC %md
// MAGIC ### Print schema of the original JSON files
// MAGIC As the JSON files are converted to PARQUET files the schema is read from PARQUET (much faster solution)

// COMMAND ----------

jsonEntities.foreach(entity => printParquetSchema(abfssBronzeFiles + "parquet-from-json/", entity, 1))


// COMMAND ----------

// MAGIC %md
// MAGIC ### Show all entities in the system
// MAGIC 1. Combining the arrays of all entities and converting to a set
// MAGIC 2. Showing where the entities exist

// COMMAND ----------

val uniqueEntities = (dataWarehouseEntities ++ parquetEntities ++ csvEntities ++ jsonEntities).toSet

for (entity <- uniqueEntities){
  print(s"$entity: | ")
  if (dataWarehouseEntities.contains(entity)) print("DATA WAREHOUSE | ")
  if (parquetEntities.contains(entity)) print("PARQUET | ")
  if (csvEntities.contains(entity)) print("CSV | ")
  if (jsonEntities.contains(entity)) print("JSON | ")
  println("\n")
}

// COMMAND ----------

// MAGIC %md
// MAGIC # Retrieving schemas
// MAGIC Individual approach to each entity

// COMMAND ----------

// MAGIC %python
// MAGIC
// MAGIC jdbc_url = "jdbc:sqlserver://uwbigdata.database.windows.net:1433;database=bigdata530"
// MAGIC sql_server_user = dbutils.secrets.get("sql-server", "user")
// MAGIC sql_server_password = dbutils.secrets.get("sql-server", "password")
// MAGIC
// MAGIC # Paths to Azure Data Lake
// MAGIC abfss_storage_account = "bd510fall23"
// MAGIC bd530_storage_container = "bd530"
// MAGIC data_source_dir_root = "raw-data"
// MAGIC abfss_source_dir_path = f"abfss://{bd530_storage_container}@{abfss_storage_account}.dfs.core.windows.net/raw-data/"
// MAGIC
// MAGIC # Paths
// MAGIC
// MAGIC group_d_container = "retail-data-lake-group-4"
// MAGIC abfss_bronze_files = f"abfss://{group_d_container}@{abfss_storage_account}.dfs.core.windows.net/bronze-layer/"
// MAGIC
// MAGIC # Functions
// MAGIC def printSampleSummary(path, file_name):
// MAGIC     df = (spark.read
// MAGIC                     .format("parquet")
// MAGIC                     .load(path + file_name).sample(False, .1, seed=10))
// MAGIC     print(df.count())
// MAGIC     df.summary().display()
// MAGIC     df.printSchema()
// MAGIC     df.display()
// MAGIC
// MAGIC def print_schema(url, user, password, table):
// MAGIC     df = (spark.read.format("jdbc").option("url", url)
// MAGIC                                     .option("user", user)
// MAGIC                                     .option("password", password)
// MAGIC                                     .option("dbtable", table)
// MAGIC                                     .load())
// MAGIC     print(f"Table name: {table}")
// MAGIC     print("Number of rows: " + str(df.count()))
// MAGIC     df.printSchema()
// MAGIC   

// COMMAND ----------

// MAGIC %md
// MAGIC ## time_dim 
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'time_dim')

// COMMAND ----------

// MAGIC %md
// MAGIC ## inventory
// MAGIC | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_source_dir_path + 'data-parquet/', 'inventory')

// COMMAND ----------

// MAGIC %md
// MAGIC ##web_page
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'web_page')

// COMMAND ----------

// MAGIC %md
// MAGIC ## customer_demographics
// MAGIC | DATA WAREHOUSE | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "customer_demographics")

// COMMAND ----------

// MAGIC %md
// MAGIC ## store_returns
// MAGIC | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_source_dir_path + 'data-parquet/', 'store_returns')

// COMMAND ----------

// MAGIC %md
// MAGIC ## web_site:
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'web_site')

// COMMAND ----------

// MAGIC %md
// MAGIC ## catalog_sales
// MAGIC | DATA WAREHOUSE | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "catalog_sales")

// COMMAND ----------

// MAGIC %md
// MAGIC ## ship_mode
// MAGIC | JSON |

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'ship_mode')

// COMMAND ----------

// MAGIC %md
// MAGIC ## web_sales
// MAGIC | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_source_dir_path + 'data-parquet/', 'web_sales')

// COMMAND ----------

// MAGIC %md
// MAGIC ## store
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'store')

// COMMAND ----------

// MAGIC %md
// MAGIC ## customer_address
// MAGIC | DATA WAREHOUSE | CSV |

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "customer_address")

// COMMAND ----------

// MAGIC %md
// MAGIC ## ship_mode
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'ship_mode')

// COMMAND ----------

// MAGIC %md
// MAGIC ## web_sales
// MAGIC | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_source_dir_path + 'data-parquet/', 'web_sales')

// COMMAND ----------

// MAGIC %md
// MAGIC ## store
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'store')

// COMMAND ----------

// MAGIC %md
// MAGIC ## customer_address
// MAGIC | DATA WAREHOUSE | CSV |

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "customer_address")

// COMMAND ----------

// MAGIC %md
// MAGIC ## reason
// MAGIC | DATA WAREHOUSE | JSON | 

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "reason")

// COMMAND ----------

// MAGIC %md
// MAGIC ## catalog_page
// MAGIC | DATA WAREHOUSE | PARQUET | CSV | JSON | 

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "catalog_page")

// COMMAND ----------

// MAGIC %md
// MAGIC ## promotion
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python
// MAGIC printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'promotion')

// COMMAND ----------

// MAGIC %md
// MAGIC ## customer
// MAGIC | DATA WAREHOUSE | CSV | 

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "customer")

// COMMAND ----------

// MAGIC %md
// MAGIC ## catalog_returns
// MAGIC | DATA WAREHOUSE | CSV |

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "catalog_returns")

// COMMAND ----------

// MAGIC %md
// MAGIC ## call_center
// MAGIC | DATA WAREHOUSE | JSON | 

// COMMAND ----------

// MAGIC %python print_schema(jdbc_url, sql_server_user, sql_server_password, "dbo." + "call_center")

// COMMAND ----------

// MAGIC %md
// MAGIC ## web_returns
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'web_returns')

// COMMAND ----------

// MAGIC %md
// MAGIC ## store_sales
// MAGIC | PARQUET | CSV | JSON | 
// MAGIC

// COMMAND ----------

// MAGIC
// MAGIC %python printSampleSummary(abfss_source_dir_path + 'data-parquet/', 'store_sales')

// COMMAND ----------

// MAGIC %md
// MAGIC ## household_demographics
// MAGIC | PARQUET | CSV | JSON |

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_source_dir_path + 'data-parquet/', 'household_demographics')

// COMMAND ----------

// MAGIC %md
// MAGIC ## date_dim
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'date_dim')

// COMMAND ----------

// MAGIC %md
// MAGIC ## income_band
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'income_band')

// COMMAND ----------

// MAGIC %md
// MAGIC ## warehouse
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'warehouse')

// COMMAND ----------

// MAGIC %md
// MAGIC ## item
// MAGIC | JSON | 

// COMMAND ----------

// MAGIC %python printSampleSummary(abfss_bronze_files + 'parquet-from-json/', 'item')
