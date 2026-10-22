# Neutron Reproduction Factors of Nuclear Fuels

A Jupyter notebook that calculates the **neutron reproduction factor η**, the
average number of fission neutrons released per neutron absorbed in the fuel,
for the uranium and plutonium isotopes. It uses **JEFF-4.0 (2025)** evaluated
nuclear data.

It was written for an introductory course for nuclear reactor operators, where
η is the fuel factor of the four-factor formula k∞ = η f p ε.

## What the notebook covers

- The four- and six-factor formulae, reactivity, and what the operator changes.
- Fission cross sections σ_f(E), capture cross sections σ_γ(E) and fission-neutron
  yields ν̄(E) for U-232, U-233, U-234, U-235, U-236, U-238, Pu-238, Pu-239,
  Pu-240 and Pu-241.
- η(E) as a function of neutron energy, and η of enriched uranium.
- Spectrum-averaged ⟨η⟩ in a thermal reactor spectrum and in a fast fission
  spectrum. The integrals are split decade by decade and reported with a 1σ error.
- A worked example of k∞ and reactivity in pcm, and η against moderator temperature.
- Why η must exceed 2 for breeding, and the special case of Pu-238.

## Folder layout

| Folder / file | Contents |
| --- | --- |
| `Neutron_Reproduction_Factor_Fuels.ipynb` | The notebook: the source of everything else |
| `Neutron_Reproduction_Factor_Fuels.qmd` | Quarto copy of the notebook, made by `Render_QMD_with_Quarto.cmd` |
| `Data_read/` | Input data: cross sections, fission-neutron yields, neutron spectra (`.xlsx`) |
| `GraphBank_write/` | Graphs written by the notebook (`.pdf`, `.svg`; `.png` at 1200 dpi is also written locally) |
| `Rendering_Template_read/` | Word template for the `.docx` output |
| `Rendered_QMD_Quarto_write/` | The notebook rendered to HTML, PDF and DOCX |
| `Render_QMD_with_Quarto.cmd` | Converts the notebook to `.qmd`, executes it and renders HTML, PDF and DOCX |
| `Render_IPYNB_with_Quarto.cmd` | Renders the notebook directly, into `Rendered_IPYNB_Quarto_write/` |

Folders ending in `_read` are input only. Folders ending in `_write` are written
by the notebook or the render scripts.

## Running the notebook

Prerequisites:

- Python 3.12 or higher
- VS Code with the Python, Jupyter and Quarto extensions
- [Quarto](https://quarto.org) 1.11 or higher, only needed for rendering. The PDF
  is typeset with Typst, which ships with Quarto, so no LaTeX is needed.

```bash
git clone https://github.com/tjvanrooyen/Nuclear-Engineering-Science-Codes.git
cd Nuclear-Engineering-Science-Codes/Neutron_Reproduction_Factor
pip install -r requirements.txt
```

Open `Neutron_Reproduction_Factor_Fuels.ipynb` in VS Code, select a Python 3
kernel and choose **Run All**.

## Rendering to HTML, PDF and DOCX

On Windows, double-click `Render_QMD_with_Quarto.cmd`. It:

1. converts the notebook to `Neutron_Reproduction_Factor_Fuels.qmd`;
2. executes it and renders a self-contained HTML file, a PDF (Typst, A3) and a
   DOCX (styled by `Rendering_Template_read/reference_for_rendering.docx`) into
   `Rendered_QMD_Quarto_write/`.

The notebook is executed once per format, so a full render takes about 7 minutes.
Close the DOCX and PDF before you start: Windows cannot overwrite a file that is
open in another program, and the script checks this first.

## License

MIT, see [LICENSE](../LICENSE).
