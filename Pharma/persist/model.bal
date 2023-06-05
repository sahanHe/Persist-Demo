import ballerina/persist as _;

public type Manufacturer record {|
    readonly int companyId;
    string companyName;
    Product[] products;
|};

public type Product record {|
    readonly int productId;
    string productName;
    int recommendedRetailPrice;
    Manufacturer manufacturer;
|};
