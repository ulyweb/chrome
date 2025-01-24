# Define the path to the executable
$exePath = "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\Microsoft.ConfigurationManagement.exe"

# Prompt for the credentials of the user you want to run the program as
$credential = Get-Credential -Message "Enter the credentials for the user to run this program as."

# Start the process as the specified user with elevated privileges
Start-Process -FilePath "cmd.exe" -ArgumentList "/c runas /user:$($credential.UserName) `"`"$exePath`"" -NoNewWindow -Wait
