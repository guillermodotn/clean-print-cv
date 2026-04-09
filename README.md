# clean-print-cv

A clean, print-friendly CV template for [Typst](https://typst.app). YAML-driven content, zero color fills, works in B&W.

## Features

- **Print-friendly** -- no solid color blocks, minimal ink usage, looks identical in B&W
- **YAML-driven** -- edit `cv-data.yaml` with your content, the template handles the rest
- **No page breaks inside sections** -- certifications, education, projects, etc. never split across pages
- **ATS-compatible** -- single-column layout, standard section headings, clean PDF output
- **Self-contained** -- no external Typst packages required

## Quick start

1. [Install Typst](https://github.com/typst/typst#installation)
2. Clone this repo
3. Edit `cv-data.yaml` with your data
4. Compile:

```
typst compile cv.typ
```

Or use live reload while editing:

```
typst watch cv.typ
```

## Files

| File | Purpose |
|---|---|
| `cv.typ` | Entry point -- compile this. Controls section order. |
| `cv-template.typ` | The template -- all styling and layout logic. |
| `cv-data.yaml` | Your CV content. Edit this. |

## Sections

The template includes these sections, all optional (comment out any line in `cv.typ` to remove):

- Professional Summary
- Professional Experience
- Technical Skills
- Key Projects
- Certifications
- Education
- Languages (with proficiency dots)

Reorder them by moving lines in `cv.typ`.

## Customization

### Colors

Edit the variables at the top of `cv-template.typ`:

```typ
#let primary    = rgb("#2b4c7e")   // headings, name, accent bars
#let accent     = rgb("#3d6098")   // company names, bullets
#let body-color = rgb("#1a1a1a")   // body text
#let muted      = rgb("#666666")   // dates, locations
#let rule-color = rgb("#d0d0d0")   // hairline separators
```

### Font sizes

```typ
#let name-size       = 20pt
#let title-size      = 10pt
#let section-size    = 10.5pt
#let body-size       = 9.5pt
#let small-size      = 8.5pt
```

### Fonts

Change the font in the `cv-page-setup` function:

```typ
set text(font: "New Computer Modern", ...)
```

Replace `"New Computer Modern"` with any system font.
