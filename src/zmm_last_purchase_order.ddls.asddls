@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Last Purchase Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_LAST_PURCHASE_ORDER
  as select from I_PurchaseOrderItemAPI01 as a
    inner join   I_PurchaseOrderAPI01     as b on(
      b.PurchaseOrder = a.PurchaseOrder
    )
{
  key a.Material,
      max( b.PurchaseOrderDate ) as PurchaseOrderDate
}
where
  a.IsCompletelyDelivered = ''
group by
  a.Material
