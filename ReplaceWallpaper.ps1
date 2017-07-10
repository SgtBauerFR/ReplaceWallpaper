param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Check-Admin) -eq $false)  {
if ($elevated)
{
# could not elevate, quit
}
 
else {

Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}

$folder = "C:\windows\WEB\wallpaper\Windows"
takeown /F $folder /R /D O
$acl = Get-Acl -Path $folder
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder
icacls $folder /inheritance:e /t /c
Remove-Item c:\windows\WEB\wallpaper\Windows\Q_FONDECRAN_V11.jpg
Copy-Item $PSScriptRoot\Q_FONDECRAN_V11.jpg c:\windows\WEB\wallpaper\Windows\Q_FONDECRAN_V11.jpg
$userbureau = [Environment]::GetFolderPath("Desktop")
$domainUser = "DLM\$env:USERNAME"
$folderDest = "C:\windows\WEB\wallpaper\Windows"
$folderSource = "C:\windows\WEB\wallpaper\Windows"
takeown /F $folder /R /D O
$acl = Get-Acl -Path $folder
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder
icacls $folder /inheritance:e /t /c
takeown /F $folderDest /R /D O
$acl = Get-Acl -Path $folderDest
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folderDest
icacls $folderDest /inheritance:e /t /c
takeown /F $folder /R /D O
$acl = Get-Acl -Path $folder
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder
icacls $folder /inheritance:e /t /c

Stop-Process -ProcessName explorer

Function Set-ScreenResolution { 
param ( 
[Parameter(Mandatory=$true, 
  Position = 0)] 
[int] 
$Width, 
[Parameter(Mandatory=$true, 
  Position = 1)] 
[int] 
$Height 
) 
$pinvokeCode = @" 
using System; 
using System.Runtime.InteropServices; 
namespace Resolution 
{ 
  [StructLayout(LayoutKind.Sequential)] 
  public struct DEVMODE1 
  { 
  [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] 
  public string dmDeviceName; 
  public short dmSpecVersion; 
  public short dmDriverVersion; 
  public short dmSize; 
  public short dmDriverExtra; 
  public int dmFields; 
  public short dmOrientation; 
  public short dmPaperSize; 
  public short dmPaperLength; 
  public short dmPaperWidth; 
  public short dmScale; 
  public short dmCopies; 
  public short dmDefaultSource; 
  public short dmPrintQuality; 
  public short dmColor; 
  public short dmDuplex; 
  public short dmYResolution; 
  public short dmTTOption; 
  public short dmCollate; 
  [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)] 
  public string dmFormName; 
  public short dmLogPixels; 
  public short dmBitsPerPel; 
  public int dmPelsWidth; 
  public int dmPelsHeight; 
  public int dmDisplayFlags; 
  public int dmDisplayFrequency; 
  public int dmICMMethod; 
  public int dmICMIntent; 
  public int dmMediaType; 
  public int dmDitherType; 
  public int dmReserved1; 
  public int dmReserved2; 
  public int dmPanningWidth; 
  public int dmPanningHeight; 
  }; 
  class User_32 
  { 
  [DllImport("user32.dll")] 
  public static extern int EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE1 devMode); 
  [DllImport("user32.dll")] 
  public static extern int ChangeDisplaySettings(ref DEVMODE1 devMode, int flags); 
  public const int ENUM_CURRENT_SETTINGS = -1; 
  public const int CDS_UPDATEREGISTRY = 0x01; 
  public const int CDS_TEST = 0x02; 
  public const int DISP_CHANGE_SUCCESSFUL = 0; 
  public const int DISP_CHANGE_RESTART = 1; 
  public const int DISP_CHANGE_FAILED = -1; 
  } 
  public class PrmaryScreenResolution 
  { 
  static public string ChangeResolution(int width, int height) 
  { 
  DEVMODE1 dm = GetDevMode1(); 
  if (0 != User_32.EnumDisplaySettings(null, User_32.ENUM_CURRENT_SETTINGS, ref dm)) 
  { 
  dm.dmPelsWidth = width; 
  dm.dmPelsHeight = height; 
  int iRet = User_32.ChangeDisplaySettings(ref dm, User_32.CDS_TEST); 
  if (iRet == User_32.DISP_CHANGE_FAILED) 
  { 
  return "Unable To Process Your Request. Sorry For This Inconvenience."; 
  } 
  else 
  { 
  iRet = User_32.ChangeDisplaySettings(ref dm, User_32.CDS_UPDATEREGISTRY); 
  switch (iRet) 
  { 
  case User_32.DISP_CHANGE_SUCCESSFUL: 
  { 
  return "Success"; 
  } 
  case User_32.DISP_CHANGE_RESTART: 
  { 
  return "You Need To Reboot For The Change To Happen.\n If You Feel Any Problem After Rebooting Your Machine\nThen Try To Change Resolution In Safe Mode."; 
  } 
  default: 
  { 
  return "Failed To Change The Resolution"; 
  } 
  } 
  } 
  } 
  else 
  { 
  return "Failed To Change The Resolution."; 
  } 
  } 
  private static DEVMODE1 GetDevMode1() 
  { 
  DEVMODE1 dm = new DEVMODE1(); 
  dm.dmDeviceName = new String(new char[32]); 
  dm.dmFormName = new String(new char[32]); 
  dm.dmSize = (short)Marshal.SizeOf(dm); 
  return dm; 
  } 
  } 
} 
"@ 
Add-Type $pinvokeCode -ErrorAction SilentlyContinue 
[Resolution.PrmaryScreenResolution]::ChangeResolution($width,$height) 
}

Set-ScreenResolution 1024 768
Stop-Process -ProcessName explorer

$folder = "C:\windows\WEB\wallpaper\Windows"
takeown /F $folder /R /D O
$acl = Get-Acl -Path $folder
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder
icacls $folder /inheritance:e /t /c
Remove-Item c:\windows\WEB\wallpaper\Windows\Q_FONDECRAN_V11.jpg
Copy-Item $PSScriptRoot\Q_FONDECRAN_V11.jpg c:\windows\WEB\wallpaper\Windows\Q_FONDECRAN_V11.jpg
$userbureau = [Environment]::GetFolderPath("Desktop")
$domainUser = "DLM\$env:USERNAME"
$folderDest = "C:\windows\WEB\wallpaper\Windows"
$folderSource = "C:\windows\WEB\wallpaper\Windows"
takeown /F $folder /R /D O
$acl = Get-Acl -Path $folder
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder
icacls $folder /inheritance:e /t /c
takeown /F $folderDest /R /D O
$acl = Get-Acl -Path $folderDest
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folderDest
icacls $folderDest /inheritance:e /t /c
takeown /F $folder /R /D O
$acl = Get-Acl -Path $folder
$permission = "$domainUser", "FullControl", "ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder
icacls $folder /inheritance:e /t /c
rundll32.exe user32.dll, UpdatePerUserSystemParameters
rundll32.exe user32.dll,LockWorkStation
Set-ScreenResolution 1920 1080
rundll32.exe user32.dll, UpdatePerUserSystemParameters
rundll32.exe user32.dll, UpdatePerUserSystemParameters

$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("-ByLio- Opération finie avec succès",0,"Fond Ecran",0x1)

exit



