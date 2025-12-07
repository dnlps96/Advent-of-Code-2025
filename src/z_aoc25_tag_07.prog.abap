*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_07
*&---------------------------------------------------------------------*
*& Laboratories
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_07.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lv_length    TYPE i,
      lv_counter   TYPE i,
      lv_zeichen   TYPE string,
      lt_zeile     LIKE TABLE OF lv_zeichen,
      lt_zeile_tab LIKE TABLE OF lt_zeile,
      lv_x         TYPE i,
      lv_y         TYPE i,
      lv_summe     TYPE int8.

FIELD-SYMBOLS: <fs_zeichen> TYPE string,
               <fs_zeile>   TYPE table.

lv_filename = 'I:\Advent_of_Code\Tag_07.txt'.

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

  CLEAR: lv_counter, lt_zeile.
  lv_length = strlen( lv_data ).

  DO lv_length TIMES.
    lv_zeichen = lv_data+lv_counter(1).
    APPEND lv_zeichen TO lt_zeile.
    lv_counter = lv_counter + 1.
  ENDDO.

  APPEND lt_zeile TO lt_zeile_tab. " Tabelle zusammenbauen, in der alle Zeichen einzeln sind

ENDLOOP.

LOOP AT lt_zeile_tab INTO lt_zeile.

  lv_x = sy-tabix.

  LOOP AT lt_zeile INTO lv_zeichen.

    lv_y = sy-tabix.

    IF lv_zeichen <> '.' AND lv_zeichen <> '^'.

      READ TABLE lt_zeile_tab INDEX lv_x + 1 ASSIGNING <fs_zeile>.
      IF sy-subrc = 0.
        READ TABLE <fs_zeile> INDEX lv_y ASSIGNING <fs_zeichen>.

        IF <fs_zeichen> = '.'.
          IF lv_zeichen = 'S'.
            <fs_zeichen> = 1.
          ELSE.
            <fs_zeichen> = lv_zeichen.
          ENDIF.

        ELSEIF <fs_zeichen> = '^'.
          lv_summe = lv_summe + 1.

          READ TABLE <fs_zeile> INDEX lv_y + 1 ASSIGNING <fs_zeichen>.
          IF sy-subrc = 0 AND <fs_zeichen> <> '^'.
            IF <fs_zeichen> = '.'.
              <fs_zeichen> = lv_zeichen.
            ELSE.
              <fs_zeichen> = CONV int8( <fs_zeichen> ) + CONV int8( lv_zeichen ).
            ENDIF.
          ENDIF.

          READ TABLE <fs_zeile> INDEX lv_y - 1 ASSIGNING <fs_zeichen>.
          IF sy-subrc = 0 AND <fs_zeichen> <> '^'.
            IF <fs_zeichen> = '.'.
              <fs_zeichen> = lv_zeichen.
            ELSE.
              <fs_zeichen> = CONV int8( <fs_zeichen> ) + CONV int8( lv_zeichen ).
            ENDIF.
          ENDIF.

        ELSE. " es steht schon eine Zahl da
          <fs_zeichen> = CONV int8( <fs_zeichen> ) + CONV int8( lv_zeichen ).

        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDLOOP.

WRITE: / lv_summe.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR: lv_summe.

READ TABLE lt_zeile_tab INDEX lines( lt_zeile_tab ) INTO lt_zeile.

LOOP AT lt_zeile INTO lv_zeichen WHERE table_line <> '.'.
  lv_summe = lv_summe + CONV int8( lv_zeichen ).
ENDLOOP.

WRITE: / lv_summe.
