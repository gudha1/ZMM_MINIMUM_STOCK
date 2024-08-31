@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_MINIMUM_STOCK_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MINIMUM_STOCK_CDS
  as select from    I_ProductSupplyPlanning    as A
    left outer join I_StockQuantityValueByType as B on(
      B.Material                         = A.Product
      and B.Plant                        = A.Plant
      and B.ValuationAreaType            = '1'
      and B.MatlWrhsStkQtyInMatlBaseUnit > 0
    )
    left outer join I_ProductDescription_2     as C on(
      C.Product      = A.Product
      and C.Language = 'E'
    )
//    left outer join I_PurchaseOrderItemAPI01   as D on(
//      D.Material = C.Product
    
    left outer join ZMM_PENDING_PO_SUM_QTY     as e on(
      e.material = A.Product
    )
    
    left outer join I_UnitOfMeasure as F on ( F.UnitOfMeasure = A.BaseUnit  )

{
  key A.Product,
      A.MRPType,
      A.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      A.ReorderThresholdQuantity ,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      A.MaximumStockQuantity  ,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'

      sum(B.MatlWrhsStkQtyInMatlBaseUnit) as MatlWrhsStkQtyInMatlBaseUnit,
      B.MaterialBaseUnit,
      C.ProductDescription,
//      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
//      D.OrderQuantity,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        e.Pendingqty1 ,
       F.UnitOfMeasure_E




}
where
  A.MRPType = 'VB'

group by
  A.Product,
  A.MRPType,
  A.BaseUnit,
  A.ReorderThresholdQuantity,
  A.MaximumStockQuantity,
  B.MaterialBaseUnit,
  C.ProductDescription,
//  D.OrderQuantity,
  e.Pendingqty1,
  F.UnitOfMeasure_E
