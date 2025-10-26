@echo off
setlocal EnableDelayedExpansion
title %PROJECT_NAME% - Deploy Tool

:: ===== Load config.env =====
for /f "tokens=1,* delims==" %%A in ('type config.env') do (
    set "%%A=%%B"
)

echo ===========================================================
echo           %PROJECT_NAME% DEPLOY TOOL
echo ===========================================================
echo.
echo 1. Pull latest from GitHub
echo 2. Push local code to GitHub
echo 3. Push Apps Script (clasp push)
echo 4. Create NEW Apps Script Deployment
echo 5. Deploy to EXISTING Deployment ID
echo.

set /p choice=Choose an option [1/2/3/4/5]: 
set "choice=%choice: =%"

if "%choice%"=="1" ( git pull origin main & goto end )
if "%choice%"=="2" ( git add -A & git commit -m "Update %PROJECT_NAME%" & git push origin main & goto end )
if "%choice%"=="3" ( clasp push & goto end )
if "%choice%"=="4" ( clasp deploy -d "Auto deploy %DATE% %TIME%" & echo NOTE: Update DEPLOYMENT_ID in config.env & goto end )
if "%choice%"=="5" (
    if "%DEPLOYMENT_ID%"=="" ( echo ERROR: DEPLOYMENT_ID not set in config.env & goto end )
    clasp deploy --deploymentId %DEPLOYMENT_ID%
    goto end
)

echo Invalid option.
:end
echo Done.