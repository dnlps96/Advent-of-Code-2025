*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_02.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lt_range              TYPE TABLE OF string,
      ls_range              TYPE string,
      lv_min_char           TYPE string,
      lv_max_char           TYPE string,
      lv_min                TYPE int8,
      lv_max                TYPE int8,
      lv_length_zahl        TYPE i,
      lv_length_max         TYPE i,
      lv_length_akt         TYPE i,
      lv_offset_akt         TYPE i,
      lv_offset_plus_length TYPE i,
      lv_pruefzahl_1        TYPE string,
      lv_pruefzahl_2        TYPE string,
      lv_summe              TYPE int8,
      lv_treffer            TYPE c LENGTH 1.

lv_filename = 'I:\Advent_of_Code\Tag_02.txt'.

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

READ TABLE lt_data INDEX 1 INTO lv_data.

SPLIT lv_data AT ',' INTO TABLE lt_range.

LOOP AT lt_range INTO ls_range.

  SPLIT ls_range AT '-' INTO lv_min_char lv_max_char.

  lv_min = lv_min_char.
  lv_max = lv_max_char.

  WHILE lv_min <= lv_max.

* Zahl prüfen
    lv_min_char = lv_min.
    CONDENSE lv_min_char NO-GAPS.
    lv_length_zahl = strlen( lv_min_char ).

    IF CONV f( lv_length_zahl ) MOD 2 = 0. "nur Zahlen mit gerader Länge
      lv_length_akt = CONV f( lv_length_zahl ) / 2.

      lv_pruefzahl_1 = lv_min_char(lv_length_akt).
      lv_pruefzahl_2 = lv_min_char+lv_length_akt(lv_length_akt).

* Treffer
      IF lv_pruefzahl_1 = lv_pruefzahl_2.

        lv_summe = lv_summe + lv_min.

      ENDIF.
    ENDIF.

    lv_min = lv_min + 1.

  ENDWHILE.

ENDLOOP.

WRITE: / lv_summe.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR: lv_summe.

LOOP AT lt_range INTO ls_range.

  SPLIT ls_range AT '-' INTO lv_min_char lv_max_char.

  lv_min = lv_min_char.
  lv_max = lv_max_char.

  WHILE lv_min <= lv_max.

* Zahl prüfen
    lv_min_char = lv_min.
    CONDENSE lv_min_char NO-GAPS.
    lv_length_zahl = strlen( lv_min_char ).
    lv_length_max = trunc( CONV f( lv_length_zahl ) / 2 ). "ohne Nachkommastellen
    lv_length_akt = 1.

    WHILE lv_length_akt <= lv_length_max.

      IF CONV f( lv_length_zahl ) MOD lv_length_akt = 0. "nur Zahlen in die der Suchstring x-fach rein passt

        lv_offset_akt = 0.
        lv_treffer = 'X'.

        WHILE lv_offset_akt + ( 2 * lv_length_akt ) <= lv_length_zahl.

          lv_pruefzahl_1 = lv_min_char+lv_offset_akt(lv_length_akt).
          lv_offset_plus_length = lv_offset_akt + lv_length_akt.
          lv_pruefzahl_2 = lv_min_char+lv_offset_plus_length(lv_length_akt).

          IF lv_pruefzahl_1 <> lv_pruefzahl_2.
            CLEAR lv_treffer.
          ENDIF.

          lv_offset_akt = lv_offset_akt + lv_length_akt.

        ENDWHILE.

        IF lv_treffer = 'X'.
          lv_summe = lv_summe + lv_min.
          EXIT.
        ENDIF.

      ENDIF.

      lv_length_akt = lv_length_akt + 1.

    ENDWHILE.

    lv_min = lv_min + 1.

  ENDWHILE.

ENDLOOP.

WRITE: / lv_summe.
