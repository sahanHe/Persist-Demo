// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/jballerina.java;
import ballerinax/persist.inmemory;

const MANUFACTURER = "manufacturers";
const PRODUCT = "products";
final isolated table<Manufacturer> key(companyId) manufacturersTable = table [];
final isolated table<Product> key(productId) productsTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [MANUFACTURER] : {
                keyFields: ["companyId"],
                query: queryManufacturers,
                queryOne: queryOneManufacturers,
                associationsMethods: {"products": queryManufacturerProducts}
            },
            [PRODUCT] : {
                keyFields: ["productId"],
                query: queryProducts,
                queryOne: queryOneProducts
            }
        };
        self.persistClients = {
            [MANUFACTURER] : check new (metadata.get(MANUFACTURER).cloneReadOnly()),
            [PRODUCT] : check new (metadata.get(PRODUCT).cloneReadOnly())
        };
    }

    isolated resource function get manufacturers(ManufacturerTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get manufacturers/[int companyId](ManufacturerTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post manufacturers(ManufacturerInsert[] data) returns int[]|persist:Error {
        int[] keys = [];
        foreach ManufacturerInsert value in data {
            lock {
                if manufacturersTable.hasKey(value.companyId) {
                    return <persist:AlreadyExistsError>error("Duplicate key: " + value.companyId.toString());
                }
                manufacturersTable.put(value.clone());
            }
            keys.push(value.companyId);
        }
        return keys;
    }

    isolated resource function put manufacturers/[int companyId](ManufacturerUpdate value) returns Manufacturer|persist:Error {
        lock {
            if !manufacturersTable.hasKey(companyId) {
                return <persist:NotFoundError>error("Not found: " + companyId.toString());
            }
            Manufacturer manufacturer = manufacturersTable.get(companyId);
            foreach var [k, v] in value.clone().entries() {
                manufacturer[k] = v;
            }
            manufacturersTable.put(manufacturer);
            return manufacturer.clone();
        }
    }

    isolated resource function delete manufacturers/[int companyId]() returns Manufacturer|persist:Error {
        lock {
            if !manufacturersTable.hasKey(companyId) {
                return <persist:NotFoundError>error("Not found: " + companyId.toString());
            }
            return manufacturersTable.remove(companyId).clone();
        }
    }

    isolated resource function get products(ProductTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get products/[int productId](ProductTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post products(ProductInsert[] data) returns int[]|persist:Error {
        int[] keys = [];
        foreach ProductInsert value in data {
            lock {
                if productsTable.hasKey(value.productId) {
                    return <persist:AlreadyExistsError>error("Duplicate key: " + value.productId.toString());
                }
                productsTable.put(value.clone());
            }
            keys.push(value.productId);
        }
        return keys;
    }

    isolated resource function put products/[int productId](ProductUpdate value) returns Product|persist:Error {
        lock {
            if !productsTable.hasKey(productId) {
                return <persist:NotFoundError>error("Not found: " + productId.toString());
            }
            Product product = productsTable.get(productId);
            foreach var [k, v] in value.clone().entries() {
                product[k] = v;
            }
            productsTable.put(product);
            return product.clone();
        }
    }

    isolated resource function delete products/[int productId]() returns Product|persist:Error {
        lock {
            if !productsTable.hasKey(productId) {
                return <persist:NotFoundError>error("Not found: " + productId.toString());
            }
            return productsTable.remove(productId).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryManufacturers(string[] fields) returns stream<record {}, persist:Error?> {
    table<Manufacturer> key(companyId) manufacturersClonedTable;
    lock {
        manufacturersClonedTable = manufacturersTable.clone();
    }
    return from record {} 'object in manufacturersClonedTable
        select persist:filterRecord({
            ...'object
        }, fields);
}

isolated function queryOneManufacturers(anydata key) returns record {}|persist:NotFoundError {
    table<Manufacturer> key(companyId) manufacturersClonedTable;
    lock {
        manufacturersClonedTable = manufacturersTable.clone();
    }
    from record {} 'object in manufacturersClonedTable
    where persist:getKey('object, ["companyId"]) == key
    do {
        return {
            ...'object
        };
    };
    return <persist:NotFoundError>error("Invalid key: " + key.toString());
}

isolated function queryProducts(string[] fields) returns stream<record {}, persist:Error?> {
    table<Product> key(productId) productsClonedTable;
    lock {
        productsClonedTable = productsTable.clone();
    }
    table<Manufacturer> key(companyId) manufacturersClonedTable;
    lock {
        manufacturersClonedTable = manufacturersTable.clone();
    }
    return from record {} 'object in productsClonedTable
        outer join var manufacturer in manufacturersClonedTable on ['object.manufacturerCompanyId] equals [manufacturer?.companyId]
        select persist:filterRecord({
            ...'object,
            "manufacturer": manufacturer
        }, fields);
}

isolated function queryOneProducts(anydata key) returns record {}|persist:NotFoundError {
    table<Product> key(productId) productsClonedTable;
    lock {
        productsClonedTable = productsTable.clone();
    }
    table<Manufacturer> key(companyId) manufacturersClonedTable;
    lock {
        manufacturersClonedTable = manufacturersTable.clone();
    }
    from record {} 'object in productsClonedTable
    where persist:getKey('object, ["productId"]) == key
    outer join var manufacturer in manufacturersClonedTable on ['object.manufacturerCompanyId] equals [manufacturer?.companyId]
    do {
        return {
            ...'object,
            "manufacturer": manufacturer
        };
    };
    return <persist:NotFoundError>error("Invalid key: " + key.toString());
}

isolated function queryManufacturerProducts(record {} value, string[] fields) returns record {}[] {
    table<Product> key(productId) productsClonedTable;
    lock {
        productsClonedTable = productsTable.clone();
    }
    return from record {} 'object in productsClonedTable
        where 'object.manufacturerCompanyId == value["companyId"]
        select persist:filterRecord({
            ...'object
        }, fields);
}

