@echo off
setlocal EnableExtensions
::  ===========================================================================
::
::   Render_QMD_with_Quarto.cmd
::
::     (1) converts  Neutron_Reproduction_Factor_Fuels.ipynb
::         to        Neutron_Reproduction_Factor_Fuels.qmd     -> quarto convert
::     (2) executes the QMD and renders it to HTML, PDF and DOCX,
::         all written to "Rendered_QMD_Quarto_write"          -> quarto render
::
::         HTML / PDF : body text ~14 pt, code ~11 pt          -> YAML header
::         DOCX       : body 16 pt, tables 12 pt, code 10 pt
::                      -> Rendering_Template_read\reference_for_rendering.docx
::         the HTML is self-contained (embed-resources: true in the YAML)
::         the QMD is executed on every render                 -> --execute
::
::   The YAML header lives in the first cell of the notebook and is copied
::   into the QMD by quarto convert.  The QMD is overwritten on every run,
::   so make all edits in the notebook, never in the QMD.
::
::   The PDF is typeset with Typst (--to typst), which ships inside Quarto,
::   so no LaTeX installation is needed.
::
::   Each format is rendered by its own call so that a failure is reported
::   per format.  --no-clean is required on EVERY call: without it Quarto
::   empties the output folder before writing, which would delete the
::   output of the previous call and any other file kept there (SKILLS.md).
::   "call" is required because quarto may resolve to quarto.cmd, itself a
::   batch script - without "call" control would never return to this script.
::  ===========================================================================

cd /d "%~dp0"

set "NOTEBOOK=Neutron_Reproduction_Factor_Fuels.ipynb"
set "QMD=Neutron_Reproduction_Factor_Fuels.qmd"
set "OUTDIR=Rendered_QMD_Quarto_write"
set "REFDOC=Rendering_Template_read\reference_for_rendering.docx"
set "BASENAME=Neutron_Reproduction_Factor_Fuels"

where quarto >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Quarto is not on the PATH - install it from https://quarto.org
    goto :failed
)
if not exist "%NOTEBOOK%" (
    echo [ERROR] Cannot find "%NOTEBOOK%" in "%CD%".
    goto :failed
)
if not exist "%REFDOC%" (
    echo [ERROR] Cannot find the DOCX reference document "%REFDOC%".
    goto :failed
)
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

:: A rendered file that is open in another program (the DOCX in Word, the
:: PDF in Acrobat) cannot be overwritten, and Quarto would only fail at the
:: end of a long render.  Check this before starting.  Opening a file for
:: append without writing anything leaves it unchanged.
for %%F in (html pdf docx) do (
    if exist "%OUTDIR%\%BASENAME%.%%F" (
        2>nul (>>"%OUTDIR%\%BASENAME%.%%F" echo off) || (
            echo [ERROR] "%OUTDIR%\%BASENAME%.%%F" is open in another program.
            echo         Close it and run this script again.
            goto :failed
        )
    )
)

echo.
echo ===========================================================
echo  1/4  Convert   ipynb  -^>  qmd
echo ===========================================================
call quarto convert "%NOTEBOOK%" --output "%QMD%"
if errorlevel 1 goto :failed
if not exist "%QMD%" (
    echo [ERROR] quarto convert did not write "%QMD%".
    goto :failed
)

echo.
echo ===========================================================
echo  2/4  HTML   ^(self-contained, single file^)
echo ===========================================================
call quarto render "%QMD%" --to html --execute --no-cache --no-clean --output-dir "%OUTDIR%"
if errorlevel 1 goto :failed

echo.
echo ===========================================================
echo  3/4  PDF    ^(Typst, A3, 14 pt text / 11 pt code^)
echo ===========================================================
call quarto render "%QMD%" --to typst --execute --no-cache --no-clean --output-dir "%OUTDIR%"
if errorlevel 1 goto :failed

echo.
echo ===========================================================
echo  4/4  DOCX   ^(A3, 16 pt text / 12 pt tables / 10 pt code^)
echo ===========================================================
call quarto render "%QMD%" --to docx --execute --no-cache --no-clean --output-dir "%OUTDIR%"
if errorlevel 1 goto :failed

for %%F in (html pdf docx) do (
    if not exist "%OUTDIR%\%BASENAME%.%%F" (
        echo [ERROR] "%OUTDIR%\%BASENAME%.%%F" was not written.
        goto :failed
    )
)

echo.
echo ===========================================================
echo  Done.  Output written to "%CD%\%OUTDIR%":
echo ===========================================================
for %%F in ("%OUTDIR%\%BASENAME%.html" "%OUTDIR%\%BASENAME%.pdf" "%OUTDIR%\%BASENAME%.docx") do echo   %%~tF   %%~nxF
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
