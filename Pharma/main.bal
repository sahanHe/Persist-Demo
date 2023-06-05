import ballerina/io;

public type ManufacturerRecieved record {|
    int companyId;
    string companyName;
    Product[] products;
|};

Product product1 = {
    productId: 1,
    productName: "Comirnaty",
    manufacturerCompanyId: 1,
    recommendedRetailPrice: 10
};

Product product2 = {
    productId: 2,
    productName: "Prevnar 20",
    manufacturerCompanyId: 1,
    recommendedRetailPrice: 20
};

Manufacturer manufacturer1 = {
    companyName: "Pfizer",
    companyId: 1
};

public function main() returns error? {
    //initialise clients
    Client persistClient = check new ();
    // products to the table
    int[] ids = check persistClient->/products.post([product1, product2]);
    io:print(`Created Prodct Record Ids :`);
    io:println(ids);
    ids = check persistClient->/manufacturers.post([manufacturer1]);
    io:print(`Created Manufacturer Records Ids :`);
    io:println(ids);
    // get manufacuturer details
    ManufacturerRecieved recieved = check persistClient->/manufacturers/[1]();
    io:println(`Recieved Manufacturers :`);
    io:println(recieved);

    // update products
    ProductUpdate product2Updated = {
        recommendedRetailPrice: 24
    };

    Product productUpdated = check persistClient->/products/[2].put(product2Updated);
    io:print("Updated Product : ");
    io:println(productUpdated);

    //delete prodcts
    Product deletedProduct = check persistClient->/products/[1].delete();
    io:print(`Deleted Product : `);
    io:println(deletedProduct);
    // get manufacuters
    ManufacturerRecieved recievedAfterChanges = check persistClient->/manufacturers/[1]();
    io:print(`Recieved Manufacturer details after delete and update : `);
    io:println(recievedAfterChanges);

}
