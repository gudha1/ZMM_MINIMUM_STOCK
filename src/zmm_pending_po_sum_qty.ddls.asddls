@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PENDING PO QTY SUM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_PENDING_PO_SUM_QTY
  as select from ZMM_PENDING_PURCHASE_FINAL
{
  key Material         as material,
      sum(Pendingqty1) as Pendingqty1
}
group by
  Material
