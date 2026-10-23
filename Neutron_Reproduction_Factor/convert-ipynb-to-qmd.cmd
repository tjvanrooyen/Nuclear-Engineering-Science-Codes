@verify on
@echo off
REM Converts abc.ipynb to abc.qmd using Quarto

quarto convert Neutron_Reproduction_Factor_Fuels.ipynb  --output  Neutron_Reproduction_Factor_Fuels.qmd

IF ERRORLEVEL 1 (
    echo Quarto conversion failed.
    exit /b 1
)

echo Successfully converted abc.ipynb to abc.qmd

