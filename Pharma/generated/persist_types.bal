// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type Manufacturer record {|
    readonly int companyId;
    string companyName;
|};

public type ManufacturerOptionalized record {|
    int companyId?;
    string companyName?;
|};

public type ManufacturerWithRelations record {|
    *ManufacturerOptionalized;
    ProductOptionalized[] products?;
|};

public type ManufacturerTargetType typedesc<ManufacturerWithRelations>;

public type ManufacturerInsert Manufacturer;

public type ManufacturerUpdate record {|
    string companyName?;
|};

public type Product record {|
    readonly int productId;
    string productName;
    int recommendedRetailPrice;
    int manufacturerCompanyId;
|};

public type ProductOptionalized record {|
    int productId?;
    string productName?;
    int recommendedRetailPrice?;
    int manufacturerCompanyId?;
|};

public type ProductWithRelations record {|
    *ProductOptionalized;
    ManufacturerOptionalized manufacturer?;
|};

public type ProductTargetType typedesc<ProductWithRelations>;

public type ProductInsert Product;

public type ProductUpdate record {|
    string productName?;
    int recommendedRetailPrice?;
    int manufacturerCompanyId?;
|};

