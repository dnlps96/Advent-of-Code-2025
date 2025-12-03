*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_03
*&---------------------------------------------------------------------*
*& Lobby
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_03.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lv_length            TYPE i,
      lv_offset            TYPE i,
      lv_max_ziffer        TYPE c LENGTH 1,
      lv_max_ziffer_offset TYPE i,
      lv_temp_ziffer       TYPE c LENGTH 1,
      lv_ziffer_zwei       TYPE c LENGTH 1,
      lv_result            TYPE c LENGTH 2,
      lv_summe             TYPE i.

lv_filename = 'I:\Advent_of_Code\Tag_03.txt'.

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

  CLEAR: lv_max_ziffer,
         lv_max_ziffer_offset,
         lv_ziffer_zwei,
         lv_offset.

  CONDENSE lv_data NO-GAPS.
  lv_length = strlen( lv_data ).

*    max Ziffer suchen
  WHILE lv_offset < lv_length.

    lv_temp_ziffer = lv_data+lv_offset(1).

    IF lv_temp_ziffer > lv_max_ziffer.
      lv_max_ziffer = lv_temp_ziffer.
      lv_max_ziffer_offset = lv_offset.
    ENDIF.

    lv_offset = lv_offset + 1.

  ENDWHILE.

* maximale Ziffer ist ganz rechts
  IF lv_max_ziffer_offset + 1 = lv_length.

    lv_offset = 0.

*    zweite Ziffer suchen
    WHILE lv_offset < lv_max_ziffer_offset.

      lv_temp_ziffer = lv_data+lv_offset(1).

      IF lv_temp_ziffer > lv_ziffer_zwei.
        lv_ziffer_zwei = lv_temp_ziffer.
      ENDIF.

      lv_offset = lv_offset + 1.

    ENDWHILE.

    lv_result = lv_ziffer_zwei && lv_max_ziffer.

* maximale Ziffer ist irgendwo in der Mitte oder ganz links
  ELSE.

    lv_offset = lv_max_ziffer_offset + 1.

*    zweite Ziffer suchen
    WHILE lv_offset < lv_length.

      lv_temp_ziffer = lv_data+lv_offset(1).

      IF lv_temp_ziffer > lv_ziffer_zwei.
        lv_ziffer_zwei = lv_temp_ziffer.
      ENDIF.

      lv_offset = lv_offset + 1.

    ENDWHILE.

    lv_result = lv_max_ziffer && lv_ziffer_zwei.

  ENDIF.

  lv_summe = lv_summe + lv_result.

ENDLOOP.

write: / lv_summe.

*****************************************************************************
* Part 2
*****************************************************************************

clear: lv_summe.

LOOP AT lt_data INTO lv_data.



ENDLOOP.
