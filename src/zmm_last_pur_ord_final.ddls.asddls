@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Last Purchase Order Final'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_LAST_PUR_ORD_FINAL

  as select from I_PurchaseOrderItemAPI01 as a

    inner join   ZMM_LAST_PURCHASE_ORDER  as b on(
      b.Material = a.Material
    )
    inner join   I_PurchaseOrderAPI01     as c on(
      c.PurchaseOrder         = a.PurchaseOrder
      and c.PurchaseOrderDate = b.PurchaseOrderDate
    )
{
  key a.Material,
      b.PurchaseOrderDate,
      max( c.PurchaseOrder ) as PurchaseOrder
}
where
  a.IsCompletelyDelivered = ''
group by
  a.Material,
  b.PurchaseOrderDate
