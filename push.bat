@echo off
echo Initializing Git...
git init
echo Adding remote origin...
git remote add origin https://github.com/piksks/xuesos1.git
if %errorlevel% neq 0 (
    echo Remote already exists, updating URL...
    git remote set-url origin https://github.com/piksks/xuesos1.git
)
echo Adding files...
git add .
echo Committing...
git commit -m "Initial commit: R7 Casino Website"
echo Setting branch to main...
git branch -M main
echo Pushing to GitHub...
git push -u origin main
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Push failed. Try running 'git push -f origin main' if the repo is not empty.
)
echo.
echo Done! If you saw no errors, your site is on GitHub.
pause
