*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_04
*&---------------------------------------------------------------------*
*& Printing Department
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_04.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lv_length       TYPE i,
      lv_counter      TYPE i,
      lv_zeichen      TYPE c LENGTH 1,
      lv_zeichen_such TYPE c LENGTH 1,
      lt_zeile        LIKE TABLE OF lv_zeichen,
      lt_zeile_such   LIKE TABLE OF lv_zeichen,
      lt_zeile_tab    LIKE TABLE OF lt_zeile,
      lv_such_string  TYPE string,
      lv_x            TYPE i,
      lv_y            TYPE i,
      lv_x_start      TYPE i,
      lv_y_start      TYPE i,
      lv_summe        TYPE i,
      lv_result       TYPE i,
      lv_merk_result  TYPE i.

FIELD-SYMBOLS: <fs_zeichen> TYPE c,
               <fs_zeile>   TYPE table.

lv_filename = 'I:\Advent_of_Code\Tag_04.txt'.

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

  lv_x_start = sy-tabix.

  LOOP AT lt_zeile INTO lv_zeichen.

    CLEAR lv_summe.

    lv_y_start = sy-tabix.

    IF lv_zeichen = '@'.

      lv_x = lv_x_start + 1.
      lv_y = lv_y_start + 1.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start + 1.
      lv_y = lv_y_start.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start + 1.
      lv_y = lv_y_start - 1.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start - 1.
      lv_y = lv_y_start + 1.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start - 1.
      lv_y = lv_y_start.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start - 1.
      lv_y = lv_y_start - 1.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start.
      lv_y = lv_y_start + 1.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      lv_x = lv_x_start.
      lv_y = lv_y_start - 1.

      IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( lt_zeile ).

        READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
        READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

        IF lv_zeichen_such = '@'.
          lv_summe = lv_summe + 1.
        ENDIF.
      ENDIF.

      IF lv_summe < 4.
        lv_result = lv_result + 1.
      ENDIF.

    ENDIF.
  ENDLOOP.
ENDLOOP.

WRITE: / lv_result.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR lv_result.

DO.

  LOOP AT lt_zeile_tab ASSIGNING <fs_zeile>.

    lv_x_start = sy-tabix.

    LOOP AT <fs_zeile> ASSIGNING <fs_zeichen>.

      CLEAR lv_summe.

      lv_y_start = sy-tabix.

      IF <fs_zeichen> = '@'.

        lv_x = lv_x_start + 1.
        lv_y = lv_y_start + 1.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start + 1.
        lv_y = lv_y_start.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start + 1.
        lv_y = lv_y_start - 1.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start - 1.
        lv_y = lv_y_start + 1.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start - 1.
        lv_y = lv_y_start.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start - 1.
        lv_y = lv_y_start - 1.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start.
        lv_y = lv_y_start + 1.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        lv_x = lv_x_start.
        lv_y = lv_y_start - 1.

        IF lv_x > 0 AND lv_y > 0 AND lv_x <= lines( lt_zeile_tab ) AND lv_y <= lines( <fs_zeile> ).

          READ TABLE lt_zeile_tab  INDEX lv_x INTO lt_zeile_such.
          READ TABLE lt_zeile_such INDEX lv_y INTO lv_zeichen_such.

          IF lv_zeichen_such = '@'.
            lv_summe = lv_summe + 1.
          ENDIF.
        ENDIF.

        IF lv_summe < 4.
          lv_result = lv_result + 1.
          <fs_zeichen> = 'X'.
        ENDIF.

      ENDIF.
    ENDLOOP.
  ENDLOOP.

  IF lv_result = lv_merk_result.
    EXIT.
  ELSE.
    lv_merk_result = lv_result.
  ENDIF.

ENDDO.

WRITE: / lv_result.
