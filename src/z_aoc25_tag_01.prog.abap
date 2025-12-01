*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_01
*&---------------------------------------------------------------------*
*& Secret Entrance
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_01.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lv_akt_zahl TYPE i,
      lv_length   TYPE i,
      lv_dial     TYPE i VALUE 50,
      lv_count    TYPE i.

lv_filename = 'I:\Advent_of_Code\Tag_01.txt'.

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

  lv_length = strlen( lv_data ) - 1.

  lv_akt_zahl = lv_data+1(lv_length).

  CASE lv_data(1).

    WHEN 'R'.
      lv_dial = lv_dial + lv_akt_zahl.

    WHEN 'L'.
      lv_dial = lv_dial - lv_akt_zahl.

  ENDCASE.

  WHILE lv_dial < 0 OR lv_dial > 99.
    IF lv_dial < 0.
      lv_dial = lv_dial + 100.
    ELSEIF lv_dial > 99.
      lv_dial = lv_dial - 100.
    ENDIF.
  ENDWHILE.

  IF lv_dial = 0.
    lv_count = lv_count + 1.
  ENDIF.

ENDLOOP.

WRITE: / lv_count.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR lv_count.
lv_dial = 50.

LOOP AT lt_data INTO lv_data.

  lv_length = strlen( lv_data ) - 1.

  lv_akt_zahl = lv_data+1(lv_length).

  CASE lv_data(1).

    WHEN 'R'.

      lv_dial = lv_dial + lv_akt_zahl.

      WHILE lv_dial > 99.
        lv_dial = lv_dial - 100.
        lv_count = lv_count + 1.
      ENDWHILE.

    WHEN 'L'.

      IF lv_dial = 0.
        lv_count = lv_count - 1.
      ENDIF.

      lv_dial = lv_dial - lv_akt_zahl.

      WHILE lv_dial < 0.
        lv_dial = lv_dial + 100.
        lv_count = lv_count + 1.
      ENDWHILE.

      IF lv_dial = 0.
        lv_count = lv_count + 1.
      ENDIF.

  ENDCASE.

ENDLOOP.

WRITE: / lv_count.
