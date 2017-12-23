#
# Convert Audio-Files to mp3 using VLC
#

Param([Parameter(Mandatory=$true)][String]$InputFilesPath,
      [Parameter(Mandatory=$true)][String]$OutputFilesPath
)
           
[bool]$DEBUG = $false;

Function Start-AndWait() {
    Param ([String]$FileName,
           [String]$Arguments = "")

    $psi = New-Object "Diagnostics.ProcessStartInfo"
    $psi.FileName = $FileName 
    if (-NOT $DEBUG) {
        $psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
    }
    $psi.Arguments = $Arguments
    [Diagnostics.Process]$proc = [Diagnostics.Process]::Start($psi)
    $proc.WaitForExit();
    
    $proc.Dispose()
    $proc = $null
    $psi = $null
}

Function Convert-ToMp3() {
    Param ([String]$InputFilesPath,
           [String]$OutputFilesPath)

    $inputFiles = Get-ChildItem $InputFilesPath

    if(-Not (Test-Path $OutputFilesPath)) {
        New-Item -Path $OutputFilesPath -ItemType "Directory"
        Write-Host "Output-Directory created"
    }
    

    foreach ($inputFile in $inputFiles)
    {
        [String]$OutputFile = [IO.Path]::Combine($OutputFilesPath, [IO.Path]::GetFileNameWithoutExtension($inputFile.Name)) + ".mp3"

        Write-Host "processing " $OutputFile "..."

        [String]$cmd = ""
        [String]$vlcBin = "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe"
        # https://superuser.com/questions/388511/how-can-i-make-the-following-conversion-in-vlc-from-the-commandline
        if ($DEBUG) {
            [String]$params = "-I dummy """ + $inputFile.FullName + """ "":sout=#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}:std{dst='" + $OutputFile + "',access=file}"" "
            Write-Host "params: $params"
        } else {
            [String]$params = "-I dummy """ + $inputFile.FullName + """ "":sout=#transcode{vcodec=none,acodec=mp3,ab=128,channels=2,samplerate=44100}:std{dst='" + $OutputFile + "',access=file}"" vlc://quit"
        }
              

        Start-AndWait -FileName $vlcBin -Arguments $params
    }
}

Convert-ToMp3 -InputFilesPath $InputFilesPath -OutputFilesPath $OutputFilesPath
Write-Host "done"