*&---------------------------------------------------------------------*
*& Report Z_AOC25_TAG_03
*&---------------------------------------------------------------------*
*& Lobby
*&---------------------------------------------------------------------*
REPORT z_aoc25_tag_03.

TYPES: BEGIN OF ty_zahl,
         ziffer TYPE c LENGTH 1,
         max    TYPE c LENGTH 1,
         pos    TYPE i,
       END OF ty_zahl.

DATA: lv_filename TYPE string,
      lt_data     TYPE TABLE OF string,
      lv_data     TYPE string.

DATA: lv_length            TYPE i,
      lv_offset            TYPE i,
      lv_max_ziffer        TYPE c LENGTH 1,
      lv_max_ziffer_offset TYPE i,
      lv_max_ziffer_pos    TYPE i,
      lv_temp_ziffer       TYPE c LENGTH 1,
      lv_ziffer_zwei       TYPE c LENGTH 1,
      lv_result            TYPE c LENGTH 12,
      lv_summe             TYPE int8,
      lt_zahl              TYPE TABLE OF ty_zahl,
      ls_zahl              TYPE ty_zahl.

FIELD-SYMBOLS <fs_zahl> TYPE ty_zahl.

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

WRITE: / lv_summe.

*****************************************************************************
* Part 2
*****************************************************************************

CLEAR: lv_summe.

LOOP AT lt_data INTO lv_data.

  CLEAR: lv_max_ziffer,
         lv_max_ziffer_pos,
         lv_ziffer_zwei,
         lv_offset,
         lv_result,
         lt_zahl,
         ls_zahl.

  CONDENSE lv_data NO-GAPS.
  lv_length = strlen( lv_data ).

* erste Ziffer suchen
  WHILE lv_offset < lv_length.

    lv_temp_ziffer = lv_data+lv_offset(1).

    IF lv_temp_ziffer > lv_max_ziffer.
      lv_max_ziffer = lv_temp_ziffer.
      lv_max_ziffer_pos = lv_offset + 1.
    ENDIF.

    ls_zahl-ziffer = lv_temp_ziffer.
    ls_zahl-pos = sy-index.
    APPEND ls_zahl TO lt_zahl.

    lv_offset = lv_offset + 1.

  ENDWHILE.

  READ TABLE lt_zahl ASSIGNING <fs_zahl> WITH KEY pos = lv_max_ziffer_pos.
  <fs_zahl>-max = 'X'.

  SORT lt_zahl BY pos DESCENDING.

* weitere Ziffern suchen
  DO 11 TIMES.

    CLEAR: lv_max_ziffer,
           lv_max_ziffer_pos.

    LOOP AT lt_zahl INTO ls_zahl.

      IF lv_max_ziffer IS NOT INITIAL AND ls_zahl-max = 'X'.
        exit.
      ENDIF.

      IF ls_zahl-ziffer >= lv_max_ziffer and ls_zahl-max <> 'X'.
        lv_max_ziffer = ls_zahl-ziffer.
        lv_max_ziffer_pos = ls_zahl-pos.
      ENDIF.

    ENDLOOP.

    READ TABLE lt_zahl ASSIGNING <fs_zahl> WITH KEY pos = lv_max_ziffer_pos.
    <fs_zahl>-max = 'X'.

  ENDDO.

* Ergebnis zusammenbauen
  SORT lt_zahl BY pos ASCENDING.
  LOOP AT lt_zahl INTO ls_zahl WHERE max = 'X'.
    lv_result = lv_result && ls_zahl-ziffer.
  ENDLOOP.

  lv_summe = lv_summe + lv_result.

ENDLOOP.

WRITE: / lv_summe.
