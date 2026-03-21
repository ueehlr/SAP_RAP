CLASS lhc_PurchaseRequisition DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR PurchaseRequisition RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PurchaseRequisition RESULT result.

    METHODS ApprovePR FOR MODIFY
      IMPORTING keys FOR ACTION PurchaseRequisition~ApprovePR RESULT result.

    METHODS RejectPR FOR MODIFY
      IMPORTING keys FOR ACTION PurchaseRequisition~RejectPR RESULT result.

ENDCLASS.

CLASS lhc_PurchaseRequisition IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF ZUHL_I_PR IN LOCAL MODE
      ENTITY PurchaseRequisition
        FIELDS ( Astat )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_pr)
      FAILED failed.

    result = VALUE #( FOR pr IN lt_pr
      ( %tky                  = pr-%tky
        %action-ApprovePR     = COND #(
            WHEN pr-Astat = 'P'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled )
        %action-RejectPR      = COND #(
            WHEN pr-Astat = 'P'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled )
      ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD ApprovePR.
    MODIFY ENTITIES OF ZUHL_I_PR IN LOCAL MODE
      ENTITY PurchaseRequisition
        UPDATE FIELDS ( Astat Appid Apdat )
        WITH VALUE #( FOR key IN keys
          ( %tky  = key-%tky
            Astat = 'A'
            Appid = sy-uname
            Apdat = cl_abap_context_info=>get_system_date( ) ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF ZUHL_I_PR IN LOCAL MODE
      ENTITY PurchaseRequisition
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_pr).

    result = VALUE #( FOR pr IN lt_pr
      ( %tky   = pr-%tky
        %param = pr ) ).
  ENDMETHOD.

  METHOD RejectPR.
    MODIFY ENTITIES OF ZUHL_I_PR IN LOCAL MODE
      ENTITY PurchaseRequisition
        UPDATE FIELDS ( Astat )
        WITH VALUE #( FOR key IN keys
          ( %tky  = key-%tky
            Astat = 'R' ) )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF ZUHL_I_PR IN LOCAL MODE
      ENTITY PurchaseRequisition
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_pr).

    result = VALUE #( FOR pr IN lt_pr
      ( %tky   = pr-%tky
        %param = pr ) ).
  ENDMETHOD.

ENDCLASS.
