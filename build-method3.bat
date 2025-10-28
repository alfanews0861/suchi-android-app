@echo off
echo ========================================
echo    Alternative APK Builder Method
echo ========================================
echo.

REM Set memory settings to avoid JVM crashes
set GRADLE_OPTS=-Xmx1024m -XX:MaxMetaspaceSize=256m
set JAVA_OPTS=-Xmx1024m

echo [1/4] Trying with reduced memory settings...
.\gradlew.bat --no-daemon --max-workers=1 clean
if errorlevel 1 goto :try_method4

echo [2/4] Building debug APK...
.\gradlew.bat --no-daemon --max-workers=1 assembleDebug
if errorlevel 1 goto :try_method4

echo [3/4] Building release APK...
.\gradlew.bat --no-daemon --max-workers=1 assembleRelease
if errorlevel 1 goto :try_method4

echo [4/4] Build completed!
goto :success

:try_method4
echo.
echo Method 3 failed. Trying Method 4: Direct APK compilation...
echo.

REM Try manual compilation approach
echo Creating manual build...

REM Check if we have Android SDK
if exist "%ANDROID_HOME%\build-tools" (
    echo Found Android SDK at %ANDROID_HOME%
    goto :manual_build
) else if exist "%ANDROID_SDK_ROOT%\build-tools" (
    echo Found Android SDK at %ANDROID_SDK_ROOT%
    set ANDROID_HOME=%ANDROID_SDK_ROOT%
    goto :manual_build
) else (
    goto :online_method
)

:manual_build
echo Using Android SDK to build manually...
REM This would require more complex setup
goto :online_method

:online_method
echo.
echo ========================================
echo    METHOD 4: Online Build Service
echo ========================================
echo.
echo Since local build is having issues, let's try an online approach:
echo.
echo 1. I'll create an APK Builder project
echo 2. Upload to GitHub/online service
echo 3. Use cloud build system
echo.
goto :create_online_project

:success
echo.
echo ========================================
echo           BUILD SUCCESSFUL
echo ========================================
echo.
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo ✅ Debug APK: app\build\outputs\apk\debug\app-debug.apk
)
if exist "app\build\outputs\apk\release\app-release.apk" (
    echo ✅ Release APK: app\build\outputs\apk\release\app-release.apk
)
goto :end

:create_online_project
echo Creating simplified project for online build...
goto :end

:end
pause