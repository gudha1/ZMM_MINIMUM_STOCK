@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_MINIMUM_STOCK_FINAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MINIMUM_STOCK_FINAL
  as select from    ZMM_MINIMUM_STOCK_CDS  as a
    left outer join ZMM_LAST_PUR_ORD_FINAL as b on(
      b.Material = a.Product
    )
{
       @UI.lineItem             : [{ position: 10 }]
       @EndUserText.label       : 'Item'
       @UI.selectionField       : [{position: 10 }]
       @Consumption.valueHelpDefinition: [
         { entity:  { name:    'ZMM_MINIMUM_STOCK_F4',
                     element: 'Product' }
        }]
  key  a.Product,

       @UI.lineItem             : [{ position: 80 }]
       @EndUserText.label       : 'Item Name'
       a.ProductDescription,

       @UI.lineItem             : [{ position: 20 }]
       @EndUserText.label       : 'MRPType'
       a.MRPType,

       //       @UI.lineItem             : [{ position: 30 }]
       //       @EndUserText.label       : 'BaseUnit'
       //       BaseUnit,

       @UI.lineItem             : [{ position: 30 }]
       @EndUserText.label       : 'BaseUnit'
       a.UnitOfMeasure_E,


       @UI.lineItem             : [{ position: 40 }]
       @EndUserText.label       : 'Min Stock'
       //  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       @Aggregation.default: #SUM
       cast( a.ReorderThresholdQuantity as abap.dec( 23, 3 ) )     as MinStock,
       // ReorderThresholdQuantity,

       @UI.lineItem             : [{ position: 50 }]
       @EndUserText.label       : 'Max Stock'
       // @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       @Aggregation.default: #SUM
       cast( a.MaximumStockQuantity as abap.dec( 23, 3 ) )         as MaxStock,
       //  MaximumStockQuantity,

       @UI.lineItem             : [{ position: 60 }]
       @EndUserText.label       : 'Current Stock'
       // @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       @Aggregation.default: #SUM
       cast( a.MatlWrhsStkQtyInMatlBaseUnit as abap.dec( 23, 3 ) ) as CurrentStock,
       // MatlWrhsStkQtyInMatlBaseUnit,

       //       @UI.lineItem             : [{ position: 70 }]
       //       @EndUserText.label       : 'BaseUnit'
       //       UnitOfMeasure_E,

       @UI.lineItem             : [{ position: 80 }]
       @EndUserText.label       : 'On Order Quantity '
       @Aggregation.default: #SUM
       //     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       //     cast(OrderQuantity as abap.dec( 20, 2 ) ) as OrderQuantity
       cast( a.Pendingqty1 as abap.dec( 20, 3 ) )                  as Pendingqty1,

       @UI.lineItem             : [{ position: 90 }]
       @EndUserText.label       : 'Last purchase order'
       b.PurchaseOrder,
       @UI.lineItem             : [{ position: 100 }]
       @EndUserText.label       : 'Last purchase order Date'
       b.PurchaseOrderDate


}
