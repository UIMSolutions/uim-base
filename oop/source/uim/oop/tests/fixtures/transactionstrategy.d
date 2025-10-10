/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.oop.tests.fixtures.transactionstrategy;

mixin(Version!"test_uim_oop");

import uim.oop;
@safe:

/*
/**
 * Fixture strategy that wraps fixtures in a transaction that is rolled back
 * after each test.
 *
 * Any test that calls Connection.rollback(true) will break this strategy.
 */
class DTransactionStrategy : IFixtureStrategy {
    mixin TConfigurable;

    this() {
        initialize;
    }

    this(Json[string] initData) {
        initialize(initData);
    }

    this(string name) {
        this().name(name);
    }

    // Hook method
    bool initialize(Json[string] initData = null) {
        configuration(MemoryConfiguration);
        configuration.entries(initData);

        return true;
    }

    mixin(TProperty!("string", "name"));
    
    protected DFixtureHelper helper;

    // TODO protected IFixture[] fixtures;

    // TODO 
    /* this() {
        _helper = new DFixtureHelper();
    } */
 
    // TODO 
    /*
    void setupTest(string[] fixtureNames) {
        if (isEmpty(fixtureNames)) {
            return;
        }
        _fixtures = _helper.loadFixtures(fixtureNames);

        _helper.runPerConnection(void (aConnection) {
            if (cast(DConnection)aConnection) {
                assert(
                    aConnection.inTransaction() == false,
                    "Cannot start transaction strategy inside a transaction. "~
                    "Ensure you have closed all open transactions."
               );
                aConnection.enableSavePoints();
                if (!aConnection.isSavePointsEnabled()) {
                    throw new DatabaseException(
                        "Could not enable save points for the `{aConnection.configName()}` connection. "~
                            "Your database needs to support savepoints in order to use "~
                            "TransactionStrategy."
                   );
                }
                aConnection.begin();
                aConnection.createSavePoint("__fixtures__");
            }
        }, _fixtures);

        _helper.insert(_fixtures);
    }
 
    void teardownTest() {
        _helper.runPerConnection(void (Connection aConnection) {
            if (aConnection.inTransaction()) {
                aConnection.rollback(true);
            }
        }, _fixtures);
    } */ 
}
