*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_06
*&---------------------------------------------------------------------*
*& Trash Compactor
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_06.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lt_zeile                TYPE TABLE OF string,
      lt_zeile_tab            LIKE TABLE OF lt_zeile,
      lt_zeile_rechenzeichen  TYPE TABLE OF string,
      lv_rechenzeichen        TYPE c LENGTH 1,
      lv_rechenzeichen_merk   TYPE c LENGTH 1,
      lv_tabix                LIKE sy-tabix,
      lv_zahl                 TYPE int8,
      lv_zahl_string          TYPE string,
      lv_result               TYPE int8,
      lv_summe                TYPE int8,
      lv_rechenzeichen_string TYPE string,
      lv_offset               TYPE i,
      lv_offset_start         TYPE i,
      lv_string               TYPE string.

lv_filename = 'I:\Advent_of_Code\Tag_06.txt'.

CALL METHOD cl_gui_frontend_services=>gui_upload
  EXPORTING
    filename = lv_filename
    codepage = '1100'
  CHANGING
    data_tab = lt_data
  EXCEPTIONS
    OTHERS   = 1.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
           WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.

*****************************************************************************
* Part 1
*****************************************************************************

LOOP AT lt_data INTO lv_data.

  CONDENSE lv_data.
  SPLIT lv_data AT ' ' INTO TABLE lt_zeile.
  APPEND lt_zeile TO lt_zeile_tab.

ENDLOOP.

READ TABLE lt_zeile_tab INDEX lines( lt_zeile_tab ) INTO lt_zeile_rechenzeichen.
DELETE lt_zeile_tab INDEX lines( lt_zeile_tab ).

LOOP AT lt_zeile_rechenzeichen INTO lv_rechenzeichen.

  lv_tabix = sy-tabix.
  CLEAR lv_result.

  LOOP AT lt_zeile_tab INTO lt_zeile.

    READ TABLE lt_zeile INDEX lv_tabix INTO lv_zahl.

    IF lv_rechenzeichen = '+'.
      lv_result = lv_result + lv_zahl.
    ELSEIF lv_rechenzeichen = '*'.
      IF lv_result IS INITIAL.
        lv_result = lv_zahl.
      ELSE.
        lv_result = lv_result * lv_zahl.
      ENDIF.
    ENDIF.

  ENDLOOP.

  lv_summe = lv_summe + lv_result.

ENDLOOP.

WRITE: / lv_summe.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR: lv_summe.

READ TABLE lt_data INDEX lines( lt_data ) INTO lv_rechenzeichen_string.
DELETE lt_data INDEX lines( lt_data ).

DO strlen( lv_rechenzeichen_string ) TIMES.

  lv_rechenzeichen = lv_rechenzeichen_string+lv_offset(1).

  IF lv_rechenzeichen IS NOT INITIAL.

    IF lv_rechenzeichen_merk IS NOT INITIAL.

      CLEAR: lv_result.

* neues Rechenzeichen -> Abarbeitung vorherige Rechnung
      WHILE lv_offset_start < lv_offset - 1.

        CLEAR: lv_zahl,
               lv_zahl_string.

        LOOP AT lt_data INTO lv_string.
          lv_zahl_string = lv_zahl_string && lv_string+lv_offset_start(1).
        ENDLOOP.

        lv_zahl = lv_zahl_string.

        IF lv_rechenzeichen_merk = '+'.
          lv_result = lv_result + lv_zahl.
        ELSEIF lv_rechenzeichen_merk = '*'.
          IF lv_result IS INITIAL.
            lv_result = lv_zahl.
          ELSE.
            lv_result = lv_result * lv_zahl.
          ENDIF.
        ENDIF.

        lv_offset_start = lv_offset_start + 1.

      ENDWHILE.

      lv_summe = lv_summe + lv_result.

    ENDIF.

    lv_rechenzeichen_merk = lv_rechenzeichen.
    lv_offset_start = lv_offset.

  ENDIF.

  lv_offset = lv_offset + 1.

ENDDO.

CLEAR: lv_result.

* letzte Rechnung
WHILE lv_offset_start < strlen( lv_rechenzeichen_string ).

  CLEAR: lv_zahl,
         lv_zahl_string.

  LOOP AT lt_data INTO lv_string.
    lv_zahl_string = lv_zahl_string && lv_string+lv_offset_start(1).
  ENDLOOP.

  lv_zahl = lv_zahl_string.

  IF lv_rechenzeichen_merk = '+'.
    lv_result = lv_result + lv_zahl.
  ELSEIF lv_rechenzeichen_merk = '*'.
    IF lv_result IS INITIAL.
      lv_result = lv_zahl.
    ELSE.
      lv_result = lv_result * lv_zahl.
    ENDIF.
  ENDIF.

  lv_offset_start = lv_offset_start + 1.

ENDWHILE.

lv_summe = lv_summe + lv_result.

WRITE: / lv_summe.
