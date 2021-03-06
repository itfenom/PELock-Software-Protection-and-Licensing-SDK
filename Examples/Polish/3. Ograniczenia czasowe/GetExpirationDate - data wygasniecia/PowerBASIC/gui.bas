'///////////////////////////////////////////////////////////////////////////////
'//
'// Przyklad jak odczytac dane o ograniczeniu czasowym (date wygasniecia)
'//
'// Wersja         : PELock v2.0
'// Jezyk          : PowerBASIC
'// Autor          : Bartosz W�jcik (support@pelock.com)
'// Strona domowa  : https://www.pelock.com
'//
'///////////////////////////////////////////////////////////////////////////////

#COMPILE EXE
%USEMACROS = 1

#INCLUDE "win32api.inc"
#INCLUDE "pelock.inc"

FUNCTION PBMAIN () AS LONG

    DIM stExpirationDate AS SYSTEMTIME
    DIM dwTrialStatus AS DWORD

    dwTrialStatus = %PELOCK_TRIAL_ABSENT

    CRYPT_START

    ' odczytaj status systemu ograniczenia czasowego
    dwTrialStatus = GetExpirationDate(stExpirationDate)

    SELECT CASE dwTrialStatus

    '
    ' system ograniczenia czasowego jest aktywny
    '
    CASE %PELOCK_TRIAL_ACTIVE:

        MSGBOX "Wersja ograniczona, data wygasniecia  " & LTRIM$(STR$(stExpirationDate.wDay)) & "-" & _
                                                          LTRIM$(STR$(stExpirationDate.wMonth)) & "-" & _
                                                          LTRIM$(STR$(stExpirationDate.wYear))

    '
    ' okres testowy wygasl, wyswietl wlasna informacje i zamknij aplikacje
    ' kod zwracany tylko jesli bedzie wlaczona byla opcja
    ' "Pozwol aplikacji na dzialanie po wygasnieciu" w przeciwnym wypadku
    ' aplikacja jest automatycznie zamykana
    '
    CASE %PELOCK_TRIAL_EXPIRED

        MSGBOX "Ta aplikacja wygasla i bedzie zamknieta!"

    '
    ' ograniczenia czasowe nie sa wlaczone dla tej aplikacji
    ' lub aplikacja zostala zarejestrowana
    '
    CASE ELSE ' wlaczajac %PELOCK_TRIAL_ABSENT

        MSGBOX "Brak ograniczen czasowych lub aplikacja zostala zarejestrowana."

    END SELECT

    CRYPT_END


END FUNCTION
