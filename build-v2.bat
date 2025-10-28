@echo off
setlocal enabledelayedexpansion

echo ========================================
echo    Suchi Android App Builder v2.0
echo ========================================
echo.

REM Check Java installation
echo [1/5] Checking Java installation...
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Java is not installed or not in PATH
    echo Please install Java JDK 8 or higher
    pause
    exit /b 1
)
echo ✅ Java is installed

REM Set environment variables
echo.
echo [2/5] Setting up environment...
set JAVA_OPTS=-Xmx2048m -Dfile.encoding=UTF-8
set GRADLE_OPTS=-Dorg.gradle.daemon=false

REM Clean any previous builds
echo.
echo [3/5] Cleaning previous builds...
if exist "app\build" (
    rmdir /s /q "app\build"
    echo ✅ Cleaned previous build files
)

REM Try Gradle wrapper first
echo.
echo [4/5] Building APK using Gradle Wrapper...
call gradlew.bat --no-daemon clean
if errorlevel 1 (
    echo ❌ Gradle wrapper failed, trying alternative method...
    goto :alternative_build
)

call gradlew.bat --no-daemon assembleDebug
if errorlevel 1 (
    echo ❌ Debug build failed, trying alternative method...
    goto :alternative_build
)

call gradlew.bat --no-daemon assembleRelease
if errorlevel 1 (
    echo ❌ Release build failed, trying alternative method...
    goto :alternative_build
)

goto :success

:alternative_build
echo.
echo [Alt] Trying alternative build method...
echo Downloading Gradle directly...

REM Create temp directory
if not exist "temp" mkdir temp

REM Download Gradle if not exists
if not exist "temp\gradle-8.4-bin.zip" (
    echo Downloading Gradle 8.4...
    powershell -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-8.4-bin.zip' -OutFile 'temp\gradle-8.4-bin.zip'"
    if errorlevel 1 (
        echo ❌ Failed to download Gradle
        goto :manual_instructions
    )
)

REM Extract Gradle
if not exist "temp\gradle-8.4" (
    echo Extracting Gradle...
    powershell -Command "Expand-Archive -Path 'temp\gradle-8.4-bin.zip' -DestinationPath 'temp'"
    if errorlevel 1 (
        echo ❌ Failed to extract Gradle
        goto :manual_instructions
    )
)

REM Use direct Gradle
echo Using direct Gradle installation...
set GRADLE_HOME=%cd%\temp\gradle-8.4
set PATH=%GRADLE_HOME%\bin;%PATH%

gradle clean assembleDebug assembleRelease
if errorlevel 1 (
    echo ❌ Direct Gradle also failed
    goto :manual_instructions
)

:success
echo.
echo [5/5] Build completed successfully! 🎉
echo.
echo ========================================
echo           BUILD SUCCESSFUL
echo ========================================
echo.
echo APK files generated:
if exist "app\build\outputs\apk\debug\app-debug.apk" (
    echo ✅ Debug APK: app\build\outputs\apk\debug\app-debug.apk
)
if exist "app\build\outputs\apk\release\app-release.apk" (
    echo ✅ Release APK: app\build\outputs\apk\release\app-release.apk
)
echo.
echo You can now install these APK files on your Android device!
echo.
goto :end

:manual_instructions
echo.
echo ========================================
echo        MANUAL BUILD INSTRUCTIONS
echo ========================================
echo.
echo Since automated build failed, try these steps:
echo.
echo 1. Install Android Studio from: https://developer.android.com/studio
echo 2. Open this project folder in Android Studio
echo 3. Let it sync and download dependencies
echo 4. Build → Generate Signed Bundle/APK
echo.
echo OR try online build services:
echo 1. Upload project to GitHub
echo 2. Use GitHub Actions or other CI/CD services
echo.

:end
echo.
pause