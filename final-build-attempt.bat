@echo off
echo ========================================
echo    FINAL LOCAL BUILD ATTEMPT
echo ========================================
echo.

echo Trying with minimal Gradle configuration...
echo.

REM Clean everything
echo [1/5] Cleaning all cache...
if exist ".gradle" rmdir /s /q ".gradle"
if exist "app\build" rmdir /s /q "app\build"
if exist "%USERPROFILE%\.gradle\daemon" rmdir /s /q "%USERPROFILE%\.gradle\daemon"

echo [2/5] Setting minimal JVM options...
set GRADLE_OPTS=-Xmx512m -XX:MaxMetaspaceSize=128m -Dfile.encoding=UTF-8

echo [3/5] Using Gradle 8.4 with minimal config...
echo Downloading and running with no-daemon mode...

echo [4/5] Attempting build...
gradlew.bat --no-daemon --no-build-cache --no-configure-on-demand clean
if errorlevel 1 goto :failed

gradlew.bat --no-daemon --no-build-cache --no-configure-on-demand --max-workers=1 assembleDebug
if errorlevel 1 goto :failed

echo [5/5] Success! Checking output...
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo ✅ DEBUG APK CREATED!
    echo Location: app\build\outputs\apk\debug\app-debug.apk
    echo File size:
    dir "app\build\outputs\apk\debug\app-debug.apk"
    goto :success
) else (
    echo ❌ APK file not found
    goto :failed
)

:success
echo.
echo ========================================
echo           BUILD SUCCESSFUL!
echo ========================================
echo.
echo Your APK is ready at:
echo app\build\outputs\apk\debug\app-debug.apk
echo.
echo You can install this on your Android device!
echo.
goto :end

:failed
echo.
echo ========================================
echo        LOCAL BUILD FAILED
echo ========================================
echo.
echo Don't worry! Use the GitHub Actions method:
echo.
echo 1. Run: .\github-build-setup.ps1
echo 2. Follow the instructions to upload to GitHub
echo 3. GitHub will build your APK automatically
echo.
echo This is actually better because:
echo ✅ No local environment issues
echo ✅ Professional CI/CD pipeline  
echo ✅ Always builds with latest Android tools
echo ✅ Free and reliable
echo.

:end
pause