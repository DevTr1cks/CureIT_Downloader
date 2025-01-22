#include <File.au3>

$Count = 7 ; количество предыдущих версий для хранения
$DLfolder = @ScriptDir & "\CureIT\"; Папка для загрузки ( " \ " в конце обязательно)
$FileName = "CureIT"

HttpSetProxy(0); настройки прокси
			   ; 0 = (по умолчанию) Использует текущие настройки Internet Explorer для прокси.
			   ; 1 = Не использует прокси (прямой доступ)
			   ; 2 = Использует указанный прокси ( 2,"proxy:port" [, "username" [, "password" ]]])

If FileExists(@ScriptDir & "\CureIT\") == 0  Then
    DirCreate ( @ScriptDir & "\CureIT" )
EndIf


InetGet("https://free.drweb.ru/download+cureit/gr/?lng=ru", $DLfolder & $FileName & " " & @YEAR & "." & @MON & "." & @MDAY & ".exe", 1)
If @error Then ; если скачалось то выдать сообщение что всё готово
    MsgBox(4096, "CureIT downloader", "Ошибка соединения")
	Exit
Else
   ; MsgBox(4096, "CureIT downloader", "Файл загружен")
EndIf


$aFiles = _FileListToArray($DLfolder, $FileName & ' *.exe', 1)
If IsArray($aFiles) Then ;Если файлов больше 0 (проверка переменной на содержани массива)
   ;MsgBox(0, '', "Количество файлов: " & $aFiles[0])
   If $aFiles[0] > $Count Then  ; Если файлов больше 7
	 $i=$aFiles[0] - $Count
	 For $j=1 To $i
		 ;MsgBox(0, '', $DLfolder & $aFiles[$j]) ;имя удаляемого файла
         FileSetAttrib($DLfolder & $aFiles[$j] , "-RASH"); перед удалением убираем все лишние атрибуты, иначе не удалит
         FileDelete($DLfolder & $aFiles[$j]);удаляем прошлые версии
     Next
  EndIf
EndIf