public with sharing class ProductsSelector extends fflib_SObjectSelector {
  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Product2.Description,
      Product2.Id,
      Product2.IsActive,
      Product2.Name,
      Product2.ProductCode
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Product2.sObjectType;
  }

  public List<Product2> selectById(Set<ID> idSet) {
    return (List<Product2>) selectSObjectsById(idSet);
  }
}
