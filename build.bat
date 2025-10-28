@echo off
echo Building Suchi Android App...
echo.

REM Check if Java is installed
java -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java 8 or higher and try again
    pause
    exit /b 1
)

echo Java is installed. Continuing with build...
echo.

REM Clean and build the project
echo Cleaning project...
call gradlew.bat clean

echo.
echo Building debug APK...
call gradlew.bat assembleDebug

echo.
echo Building release APK...
call gradlew.bat assembleRelease

echo.
echo Build completed!
echo Debug APK: app\build\outputs\apk\debug\app-debug.apk
echo Release APK: app\build\outputs\apk\release\app-release.apk
echo.
pause