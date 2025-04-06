/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.tests.connectionhelper;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

/**
 * Helper for managing test connections
 *
 * @internal
 */
class DConnectionHelper {
    /**
     * Adds `test_<connection name>` aliases for all non-test connections.
     *
     * This forces all models to use the test connection instead. For example,
     * if a model is confused to use connection `files` then it will be aliased
     * to `test_files`.
     *
     * The `default` connection is aliased to `test`.
     */
    void addTestAliases() {
        // TODO
        /*
        ConnectionManager.alias("test", "default");
        ConnectionManager.configured()
            .filter!(connection => !(aConnection == "test" || aConnection == "default"))
            .each!(connection => ConnectionManager.alias(connection, 
                startsWith(connection, "test_")
                ? subString(connection, 5) // original
                : "test_" ~ aConnection
           ));
        } */
    }
    
    /**
     * Enables query logging for all database connections.
     * Params:
     * array<int, string>|null aConnections Connection names or null for all.
     */
    void enableQueryLogging(Json[string] connections = null) {
        // TODO
        /* connections = connections.ifEmpyt(ConnectionManager.configured());
        foreach (connection; connections) {
            connection = ConnectionManager.get(connection);
            string message = "--Starting test run " ~ date("Y-m-d H:i:s");
            if (
                cast(DConnection)connection &&
                connection.getDriver().log(message) == false
           ) {
                connection.getDriver().setLogger(new QueryLogger());
                connection.getDriver().log(message);
            }
        } */
    }
    
    // Drops all tables.
    // TODO 
    /* 
    void dropTables(string connectionName, string[] tableNames = null) {
        auto connection = ConnectionManager.get(aConnectionName);
        assert(cast(DConnection)aConnection);
        collection = connection.getSchemaCollection();
        allTables = collection.listTablesWithoutViews();

        tableNames = tableNames !is null ? intersect(tableNames, allTables): allTables;
        TableSchema[] schemas = array_map(fn (aTable) : collection.describe(aTable), tableNames);

        dialect = connection.getDriver().schemaDialect();
        schemas.each!((tableSchema) {
            dialect.dropConstraintSql(tableSchema).each!(statement => connection.execute(statement));
        });
        schemas.each!(tableSchema => dialect.dropTableSql(tableSchema).each!(statement => connection.execute(statement)));
    } */
    
    // Truncates all tables.
    void truncateTables(string connectionName, Json[string] tableNames = null) {
         // TODO auto connection = ConnectionManager.get(aConnectionName);
        // TODO assert(cast(DConnection)connection);
         // TODO auto collection = connection.getSchemaCollection();

         // TODO auto allTables = collection.listTablesWithoutViews();
         // TODO auto tableNames = tableNames !is null ? intersect(tableNames, allTables): allTables;
        /** @var array<\UIM\Database\Schema\TableSchema> schemas Specify type for psalm */
        // TODO schemas = array_map(fn (aTable): collection.describe(aTable), tableNames);

        /* this.runWithoutConstraints(connection, void (Connection connection) use (schemas) {
            dialect = connection.getDriver().schemaDialect();
            tableSchema.each!(schema => 
                dialect.truncateTableSql(schema)
                    .each!(statement => connection.execute(statement));
           );
        }); */ 
    }
    
    // Runs callback with constraints disabled correctly per-database
    // TODO
    /* void runWithoutConstraints(DConnection dbConnection, DClosure aCallback) {
        // TODO if (dbConnection.getDriver().supports(DriverFeatures.DISABLE_CONSTRAINT_WITHOUT_TRANSACTION)) {
        dbConnection.disableConstraints(fn (Connection configName): aCallback(configName));
        } else {
            dbConnection.transactional(void (Connection aConnection) use (aCallback) {
                dbConnection.disableConstraints(fn (Connection aConnection): aCallback(aConnection));
            });
        } 
    } */
}
