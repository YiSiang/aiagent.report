@echo off
echo [1/2] Building image...
docker build -t 172.16.72.102:5000/report-web:latest .
if %errorlevel% neq 0 (
    echo BUILD FAILED
    exit /b %errorlevel%
)

echo [2/2] Pushing image...
docker push 172.16.72.102:5000/report-web:latest
if %errorlevel% neq 0 (
    echo PUSH FAILED
    exit /b %errorlevel%
)

echo [3/3] Deploying to remote VM...
ssh -tt itt2@172.16.72.102 "cd ./docker-ai-report && docker compose down && docker image rm 127.0.0.1:5000/report-web && docker compose pull && docker compose up -d --force-recreate"
if %errorlevel% neq 0 (
    echo DEPLOY FAILED
    exit /b %errorlevel%
)

echo Done.