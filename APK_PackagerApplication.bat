@echo off

:: AIR application packaging
:: More information:
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959

:: Path to AIR SDK binaries
set PATH=%PATH%;D:\bin\FlashDevelop\Tools\flexsdk\bin
:: Path to AIR SDK binaries
set PATH=%PATH%;D:\bin\android-sdk-windows\platform-tools
:: Path to air on android installer
set AIR_INSTALLER=D:\bin\FlashDevelop\Tools\flexsdk\runtimes\air\android\emulator\Runtime.apk

:: Signature (see 'CreateCertificate.bat')
set CERTIFICATE=SelfSigned.p12
set SIGNING_OPTIONS=-storetype pkcs12 -keystore %CERTIFICATE%
if not exist %CERTIFICATE% goto certificate

:: Output
if not exist apk md apk
set APK_FILE=apk\HitHint.apk

:: Input
set APP_XML=application.xml 
set FILE_OR_DIR=-C bin .

echo Signing AIR setup using certificate %CERTIFICATE%.
call adt -package -target apk %SIGNING_OPTIONS% %APK_FILE% %APP_XML% %FILE_OR_DIR%
if errorlevel 1 goto failed

echo.
echo the program will deploy %APK_FILE% on the Xperia arc
echo.
pause
echo.
copy /Y %APK_FILE% C:\Users\Seacolor\Dropbox
goto end

:certificate
echo Certificate not found: %CERTIFICATE%
echo.
echo Troubleshotting: 
echo A certificate is required, generate one using 'CreateCertificate.bat'
echo.
goto end

:failed
echo AIR setup creation FAILED.
echo.
echo Troubleshotting: 
echo did you configure the Flex SDK path in this Batch file?
echo.
goto end

:androidFailed
echo Only one android emulator should be running
echo.
goto end

:end
pause