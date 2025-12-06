*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_05
*&---------------------------------------------------------------------*
*& Cafeteria
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_05.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lv_kz_input_part_2      TYPE c LENGTH 1,
      lt_fresh_ingredient     TYPE RANGE OF int8,
      ls_fresh_ingredient     LIKE LINE OF lt_fresh_ingredient,
      lt_available_ingredient TYPE TABLE OF int8,
      lv_zahl_1               TYPE string,
      lv_zahl_2               TYPE String,
      lv_zahl                 TYPE int8,
      lv_summe                TYPE int8.

lv_filename = 'I:\Advent_of_Code\Tag_05.txt'.

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

  IF lv_data IS INITIAL.
    lv_kz_input_part_2 = 'X'.
  ELSE.

    IF lv_kz_input_part_2 = 'X'.

      APPEND lv_data TO lt_available_ingredient.

    ELSE.

      SPLIT lv_data AT '-' INTO lv_zahl_1 lv_zahl_2.

      ls_fresh_ingredient-sign = 'I'.
      ls_fresh_ingredient-option = 'BT'.
      ls_fresh_ingredient-low = lv_zahl_1.
      ls_fresh_ingredient-high = lv_zahl_2.

      APPEND ls_fresh_ingredient TO lt_fresh_ingredient.

    ENDIF.
  ENDIF.
ENDLOOP.

LOOP AT lt_available_ingredient INTO lv_zahl WHERE table_line IN lt_fresh_ingredient.

  lv_summe = lv_summe + 1.

ENDLOOP.

WRITE: / lv_summe.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR: lv_summe,
       lv_zahl.

SORT lt_fresh_ingredient BY low.

LOOP AT lt_fresh_ingredient INTO ls_fresh_ingredient.

  IF ls_fresh_ingredient-low > lv_zahl.

    lv_summe = lv_summe + ls_fresh_ingredient-high - ls_fresh_ingredient-low + 1.
    lv_zahl = ls_fresh_ingredient-high.

  ELSEIF ls_fresh_ingredient-high > lv_zahl.

    lv_summe = lv_summe + ls_fresh_ingredient-high - lv_zahl.
    lv_zahl = ls_fresh_ingredient-high.

  ENDIF.

ENDLOOP.

WRITE: / lv_summe.
