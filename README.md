# <img src="https://github.com/ulyweb/chrome/blob/b73cc833d1c97d393c41bffd769ea953241f5874/assets/ChromeFolder.png" width="86" height="86" orientation="180" > **Chrome Browser**
<!--
## ***_<sub>How to force sync-up update</sup>_***
 TO DO: add more details about me later -->



> [!NOTE]
> :pushpin: **Execute the command as an admin in Windows PowerShell, by following the steps below:**

> [!TIP]
> :desktop_computer: Press   ****<img src="https://github.com/ulyweb/chrome/blob/b73cc833d1c97d393c41bffd769ea953241f5874/assets/WinX.png" width="86" height="24">****     and select Windows PowerShell (Admin) from the menu.
> 
> > > :scissors: ***press the copy button below and, :pencil: paste the command into the ***`PowerShell`*** window and press enter:***
> 
> ```
> powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb https://raw.githubusercontent.com/ulyweb/chrome/refs/heads/main/ps/chromeupdate.ps1 | iex\"' -Verb RunAs"
> ```


> > > ##### Run Active Directory User and Computers as Admin.
```
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb https://raw.githubusercontent.com/ulyweb/chrome/refs/heads/main/ps/AD_as_A_Account.ps1 | iex\"' -Verb RunAs"
```

> > > ##### Run PowerShell command another user account.
```
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb https://raw.githubusercontent.com/ulyweb/chrome/refs/heads/main/ps/runas_prompt.ps1 | iex\"' -Verb RunAs"
```

> > > ##### Backup/Restore Wi-Fi connectivities
```
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb https://raw.githubusercontent.com/ulyweb/chrome/refs/heads/main/ps/Manage-WifiProfiles.ps1 | iex\"' -Verb RunAs"
```

> > > ##### Export/Import Chrome bookmarks
```
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb https://raw.githubusercontent.com/ulyweb/chrome/refs/heads/main/ps/Manage-ChromeBookmarks.ps1 | iex\"' -Verb RunAs"
```

> > > ##### Export/Import Microsoft Outlook Signatures
```
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb https://raw.githubusercontent.com/ulyweb/chrome/refs/heads/main/ps/Manage-OutlookSignatures.ps1 | iex\"' -Verb RunAs"
```


> > > ##### How convert Youtube video to full URL
> > > ##### NOTE: requirement are yt-dlp needs to be install
> > > ##### use winget search yt-dlp
```
yt-dlp -f b Youtube URL here --get-url
```
