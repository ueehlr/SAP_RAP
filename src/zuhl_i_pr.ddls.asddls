@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZUHL-Purchase Requisition Interface View'
@Metadata.ignorePropagatedAnnotations: true

-- RAP Root Entity 선언 (Behavior Definition 연결을 위해 필수)
@UI.headerInfo: {
  typeName: 'Purchase Requisition',
  typeNamePlural: 'Purchase Requisitions',
  title: { type: #STANDARD, value: 'Prtit' }
}

@UI.presentationVariant: [{
  sortOrder: [{ by: 'Prnum', direction: #DESC }]
}]

define root view entity ZUHL_I_PR
  as select from zuhl_pr
{
      -- 키 필드
  key prnum          as Prnum,

      -- Fiori 목록 화면에 표시할 컬럼들 (@UI.lineItem)
      -- position = ALV의 컬럼 순서와 같은 개념
      @UI.lineItem: [{ position: 10 }]
      @UI.selectionField: [{ position: 10 }]  -- 검색 필터에도 표시
      prtit          as Prtit,

      @UI.lineItem: [{ position: 20 }]
      @UI.selectionField: [{ position: 20 }]
      empid          as Empid,

      @UI.lineItem: [{ position: 30 }]
      depid          as Depid,

      @UI.lineItem: [{ position: 40 }]
      erdat          as Erdat,

      @UI.lineItem: [{ position: 50 }]
      @Semantics.amount.currencyCode: 'Waers'  -- 금액 필드임을 Fiori에 알림
      htota          as Htota,

      waers          as Waers,

      @UI.lineItem: [{ position: 60 }]
      @UI.selectionField: [{ position: 30 }]
      astat          as Astat,

      appid          as Appid,
      apdat          as Apdat,
      rreason        as Rreason,

      -- RAP 어드민 필드 (Behavior Definition에서 자동관리함)
      created_by     as CreatedBy,
      created_at     as CreatedAt,
      last_changed_by    as LastChangedBy,
      last_changed_at    as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt
}
