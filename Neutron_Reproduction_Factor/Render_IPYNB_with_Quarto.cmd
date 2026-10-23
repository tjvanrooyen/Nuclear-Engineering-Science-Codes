@echo off
setlocal EnableExtensions
REM ===========================================================================
REM  Render_with_Quarto.cmd
REM
REM  Renders Neutron_Reproduction_Factor_Fuels.ipynb to HTML, PDF and DOCX.
REM
REM    (1) three formats                                   -> one call each
REM        HTML / PDF : body text ~14 pt, code ~11 pt      -> notebook YAML
REM        DOCX       : body 16 pt, tables 12 pt, code 10 pt
REM                     -> Rendering_Template_read\reference_for_rendering.docx
REM    (2) all output written to "Rendered_Quarto_write"   -> --output-dir
REM    (3) the HTML is self-contained (embed-resources: true in the YAML)
REM    (4) the notebook is executed on every render        -> --execute
REM    (5) DOCX styling comes from reference_for_rendering.docx (YAML)
REM
REM  The PDF is typeset with Typst (--to typst), which ships inside Quarto,
REM  so no LaTeX installation is needed.
REM
REM  Each format is rendered by its own call so that a failure is reported
REM  per format.  --no-clean is required on EVERY call: without it Quarto
REM  empties the output folder before writing, which would delete the
REM  output of the previous call and any other file kept there (SKILLS.md).
REM  "call" is required because quarto is itself a .cmd script - without it
REM  control would never return to this script.
REM ===========================================================================

cd /d "%~dp0"

set "NOTEBOOK=Neutron_Reproduction_Factor_Fuels.ipynb"
set "OUTDIR=Rendered_ipynb_Quarto_write"
set "REFDOC=Rendering_Template_read\reference_for_rendering.docx"
set "BASENAME=Neutron_Reproduction_Factor_Fuels"

if not exist "%NOTEBOOK%" (
    echo [ERROR] Cannot find "%NOTEBOOK%" in "%CD%".
    goto :failed
)
if not exist "%REFDOC%" (
    echo [ERROR] Cannot find the DOCX reference document "%REFDOC%".
    goto :failed
)
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

echo.
echo ===========================================================
echo  1/3  HTML   ^(self-contained, single file^)
echo ===========================================================
call quarto render "%NOTEBOOK%" --to html --execute --no-cache --no-clean --output-dir "%OUTDIR%"
if errorlevel 1 goto :failed

echo.
echo ===========================================================
echo  2/3  PDF    ^(Typst, A3, 14 pt text / 11 pt code^)
echo ===========================================================
call quarto render "%NOTEBOOK%" --to typst --no-cache --no-clean --output-dir "%OUTDIR%"
if errorlevel 1 goto :failed

echo.
echo ===========================================================
echo  3/3  DOCX   ^(A3, 16 pt text / 12 pt tables / 10 pt code^)
echo ===========================================================
call quarto render "%NOTEBOOK%" --to docx --no-cache --no-clean --output-dir "%OUTDIR%"
if errorlevel 1 goto :failed

echo.
echo ===========================================================
echo  Done.  Output written to "%CD%\%OUTDIR%":
echo ===========================================================
dir /b "%OUTDIR%\%BASENAME%.html" "%OUTDIR%\%BASENAME%.pdf" "%OUTDIR%\%BASENAME%.docx"
echo.
pause
endlocal
exit /b 0

:failed
echo.
echo *** RENDER FAILED ^(exit code %ERRORLEVEL%^) - see the messages above. ***
echo.
pause
endlocal
exit /b 1
