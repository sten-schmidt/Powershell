function Function1 {

   $command = "cmd /c dir $HOME";
   if($PSVersionTable.PSVersion.Major -ge 6 -and ($IsLinux -or $IsMacOS)) {
      $command = "ls -l $HOME";
   }

   $output = java -jar StartProcess.jar $command;
   $output | ForEach-Object {
      Write-Host "Function1: $_"     #send to host
      Write-Output $_                #send to pipe
      start-Sleep -seconds 1
   }
}

function Function2 {

   Begin { 
      write-Host "Function2: Start"
   }
   Process {
      write-host "Function2: $_"
   }
   End { 
      write-Host "Function2: End"
   }
}

Clear-Host;
Function1 | Function2;