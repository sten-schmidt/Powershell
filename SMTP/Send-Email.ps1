#
# Send email using SMTP
#

$smtp = "mystmpserver.example.local"
$user = "mystmpuser"
$pass = "mysmtppassword" | ConvertTo-SecureString -asPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($user, $pass)

Send-MailMessage -From sender@example.local `
    -Subject "Test Email from Powershell" -To recipient@example.local `
    -Body "Hallo, this is a Test" -Port 587 -SmtpServer $smtp `
    -Credential $cred -UseSsl
    