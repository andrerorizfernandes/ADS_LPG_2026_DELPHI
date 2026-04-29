```bat id="rqrmwb"
@echo off
title Criar Banco Firebird LOJA.FDB

echo ==========================================
echo   CRIANDO BANCO FIREBIRD
echo ==========================================
echo.

REM Cria pasta destino se nao existir
if not exist "C:\Users\Andre Roriz\Downloads\ADS_LPG_2026_DELPHI\Loja\database" (
    mkdir "C:\Users\Andre Roriz\Downloads\ADS_LPG_2026_DELPHI\Loja\database"
)

REM Vai para pasta correta do Firebird
cd /d "C:\Program Files (x86)\Firebird\Firebird_5_0"

REM Cria script temporario
echo CREATE DATABASE 'C:\Users\Andre Roriz\Downloads\ADS_LPG_2026_DELPHI\Loja\database\LOJA.FDB' > create_tmp.sql
echo USER 'SYSDBA' >> create_tmp.sql
echo PASSWORD '18071988' >> create_tmp.sql
echo PAGE_SIZE 8192 >> create_tmp.sql
echo DEFAULT CHARACTER SET UTF8; >> create_tmp.sql
echo QUIT; >> create_tmp.sql

REM Executa ISQL
isql.exe -user SYSDBA -password 18071988 -q -i create_tmp.sql

REM Remove temporario
del create_tmp.sql

echo.
echo ==========================================
echo Processo concluido.
echo Verifique se o arquivo foi criado:
echo C:\Users\Andre Roriz\Downloads\ADS_LPG_2026_DELPHI\Loja\database\LOJA.FDB
echo ==========================================
pause
```
