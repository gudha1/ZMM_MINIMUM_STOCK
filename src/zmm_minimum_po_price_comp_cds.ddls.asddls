@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MINIMUM_PO_PRICE_COMP_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MINIMUM_PO_PRICE_COMP_CDS
  as select from    I_PurchaseOrderItemAPI01 as A
    left outer join I_PurchaseOrderItemAPI01 as B on(
      B.Material = A.Material
    )
    left outer join I_MaterialDocumentItem_2 as C on(
      C.Material              = B.Material
      and C.PurchaseOrder     = B.PurchaseOrder
      and C.PurchaseOrderItem = B.PurchaseOrderItem
    )

    inner join      ZMM_PENDING_PO_SUM_QTY   as D on(
      D.material = A.Material
    )
{
  key

        A.PurchaseOrder,
        A.PurchaseOrderItem,
        A.Material,
        //               @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        //               case when A.Material = D.Material
        //               then
        //               sum(D.Pendingqty1)    end  as Pendingqty1,

        B.BaseUnit,
        cast(C.QuantityInBaseUnit as abap.dec( 15, 3 ) )                                                                                                           as QuantityInBaseUnit,


        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        case when B.IsCompletelyDelivered  = ' '   and    B.PurchasingDocumentDeletionCode = ''       then sum(B.OrderQuantity)  end                               as OrderQuantity,

        cast(coalesce(cast( C.QuantityInBaseUnit as abap.dec( 20, 2 ) ) ,0 )  -  coalesce(cast( B.OrderQuantity as abap.dec( 20, 2 ) ) ,0 ) as abap.dec( 15, 2 ) ) as QTY,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        D.Pendingqty1
}

where
      C.GoodsMovementType        = '101'
  and C.GoodsMovementIsCancelled = ''

//and A.IsCompletelyDelivered = '' and A.PurchasingDocumentDeletionCode = ''
group by

  A.PurchaseOrder,
  A.PurchaseOrderItem,
  A.Material,
  C.QuantityInBaseUnit,
  B.OrderQuantity,
  B.BaseUnit,
  B.IsCompletelyDelivered,
  B.PurchasingDocumentDeletionCode,
  //  A.Material,
  //  D.Material

  //  D.PurchaseOrderItem,
  D.Pendingqty1,
  D.material
