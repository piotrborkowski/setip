@echo off 
echo Choose: 
echo [A] Set static IP VERA 111
echo [B] Set DHCP
echo. 
:choice 
SET /P C=[A,B]? 
for %%? in (A) do if /I "%C%"=="%%?" goto A 
for %%? in (B) do if /I "%C%"=="%%?" goto B 
goto choice 
:A 
@echo off
echo Setting IP...
netsh interface ip set address name = "Local Area Connection" static 192.168.12.111 255.255.254.0 192.168.12.1
timeout 5
netsh interface ip set dns name = "Local Area Connection" static 192.168.12.23
netsh interface ip add dns name = "Local Area Connection" 192.168.12.24 index = 2

ECHO ipconfig %computername% Local Area Connection:
netsh int ip show config name = "Local Area Connection"
pause 
goto end

:B 
@ECHO off
ECHO Setting DHCP...
netsh int ip set address name = "Local Area Connection" source = dhcp
netsh interface ip set dns name = "Local Area Connection" source = dhcp 

::ipconfig /renew

ECHO ipconfig %computername% Local Area Connection:
timeout 5
netsh int ip show config name = "Local Area Connection"

pause 
goto end 
:end
