#include <File.au3>

$Count = 7 ; ���������� ���������� ������ ��� ��������
$DLfolder = @ScriptDir & "\CureIT\"; ����� ��� �������� ( " \ " � ����� �����������)
$FileName = "CureIT"

HttpSetProxy(0); ��������� ������
			   ; 0 = (�� ���������) ���������� ������� ��������� Internet Explorer ��� ������.
			   ; 1 = �� ���������� ������ (������ ������)
			   ; 2 = ���������� ��������� ������ ( 2,"proxy:port" [, "username" [, "password" ]]])

If FileExists(@ScriptDir & "\CureIT\") == 0  Then
    DirCreate ( @ScriptDir & "\CureIT" )
EndIf


InetGet("https://free.drweb.ru/download+cureit/gr/?lng=ru", $DLfolder & $FileName & " " & @YEAR & "." & @MON & "." & @MDAY & ".exe", 1)
If @error Then ; ���� ��������� �� ������ ��������� ��� �� ������
    MsgBox(4096, "CureIT downloader", "������ ����������")
	Exit
Else
   ; MsgBox(4096, "CureIT downloader", "���� ��������")
EndIf


$aFiles = _FileListToArray($DLfolder, $FileName & ' *.exe', 1)
If IsArray($aFiles) Then ;���� ������ ������ 0 (�������� ���������� �� ��������� �������)
   ;MsgBox(0, '', "���������� ������: " & $aFiles[0])
   If $aFiles[0] > $Count Then  ; ���� ������ ������ 7
	 $i=$aFiles[0] - $Count
	 For $j=1 To $i
		 ;MsgBox(0, '', $DLfolder & $aFiles[$j]) ;��� ���������� �����
         FileSetAttrib($DLfolder & $aFiles[$j] , "-RASH"); ����� ��������� ������� ��� ������ ��������, ����� �� ������
         FileDelete($DLfolder & $aFiles[$j]);������� ������� ������
     Next
  EndIf
EndIf