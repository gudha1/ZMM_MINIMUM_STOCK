@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_MINIMUM_STOCK_F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MINIMUM_STOCK_F4 as select from I_Product as A
left outer join I_ProductDescription_2 as B on (B.Product = A.Product)
left outer join I_ProductSupplyPlanning as C on (C.Product = A.Product)

{
 key A.Product as Material,
 key B.ProductDescription as MaterialDescription
 
    
}
where 
    C.MRPType = 'VB'
