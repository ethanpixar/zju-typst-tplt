#import "support/basic-settings.typ": *

#import "@preview/cheq:0.3.0": checklist

// FUNCTION

#let insert-date-nt0(ymd, fill: rgb("#2d115676")) = if ymd != none {
  set text(fill: fill, weight: "semibold")
  insert-date(condensed: true, delimiter: "-", ymd, filler: none)
}

#let insert-date-nt(ymd, fill: rgb("#2d115676")) = if ymd != none { secenter(insert-date-nt0(ymd, fill: fill)) }


#let note-title(title: none, ymd: none) = {
  // Title
  if title != none {
    v(10pt)
    secenter(text(20pt, rgb("#2d1156d0"), weight: "semibold", title))
  }
  // date
  insert-date-nt(ymd)
}


#let h1(outlined: false, content) = {
  show heading: it => {
    show line: none
    it
  }
  heading(
    outlined: outlined,
    level: 1,
    numbering: none,
    content,
  )
}

#let printer(english: false, doc) = {
  set text(size: 12pt)
  set page(
    margin: (x: 1.2cm, top: 1.2cm, bottom: 1.8cm),
    footer-descent: 30%,
    paper: "a3",
    flipped: true,
    columns: 2,
    footer: context basic-footer(english: english),
  )
  set columns(gutter: 1.2cm)
  doc
}

// ------------------- Main template ---------------------
#let NT(
  title: none,
  ymd: none,
  width: 17.6cm,
  english: false,
  show-printer: false,
  optimized: false, // To optimize the page size for content
  minimum-width: 21cm, // Default minimum width (an A4 paper)
  doc,
) = {
  set text(font: sans-nt)
  set page(
    margin: (x: 20pt, top: 20pt, bottom: if optimized { 20pt } else { 150pt }),
    width: if optimized { if minimum-width == none { auto } else { minimum-width } } else { width },
    height: auto,
  )

  // heading styles
  show heading: set text(font: sans-nt, weight: "medium", number-width: "tabular")

  // level 1
  show heading.where(level: 1): set text(font: sans-nt, weight: "regular")

  show heading.where(level: 1): it => {
    v(-5pt)
    line(length: 100%, stroke: (thickness: 2pt, paint: rgb("#a18cb5af"), cap: "round"))
    v(-8pt)
    set text(rgb("#0b08349f"), weight: "semibold")
    it
    v(5pt)
  }

  // level 2
  show heading.where(level: 2): it => {
    v(-5pt)
    line(
      length: 100%,
      stroke: (
        thickness: 1.8pt,
        cap: "round",
        dash: (0pt, 3.6pt),
        paint: rgb("#18365393"),
      ),
    )
    v(-10pt)
    set text(rgb("#183653b3"), weight: "semibold")
    it
  }

  show heading: it => {
    set block(above: 0.8em)
    it
  }

  // level 3
  show heading.where(level: 3): it => {
    set block(above: 1.25em)
    set text(weight: "bold", fill: rgb("#556698"))
    block(
      fill: rgb("#dce5fa"),
      stroke: 1.8pt + rgb("#416db990"),
      radius: 5pt,
      outset: 4.5pt,
      it,
    )
    v(12pt, weak: true)
  }

  // level 4
  show heading.where(level: 4): it => {
    set block(above: 1.25em)
    set text(rgb("#49683b"))
    block(
      fill: rgb("#c6f1c7"),
      radius: 3.5pt,
      outset: 3.5pt,
      it,
    )
    v(12pt, weak: true)
  }

  // level 5
  show heading.where(level: 5): it => {
    set text(rgb("#aca831"))
    underline(
      offset: 4pt,
      stroke: (
        paint: rgb("#f5e8ac"),
        thickness: 1.8pt,
        cap: "round",
      ),
      it,
    )
  }

  // level 6
  show heading.where(level: 6): it => {
    underline(
      offset: 3pt,
      stroke: (
        paint: rgb("#de9a34"),
        thickness: 1.5pt,
        cap: "round",
      ),
      it,
    )
  }

  show: checklist


  if show-printer {
    set text(size: 12pt)
    set page(
      margin: (x: 1.2cm, top: 1.2cm, bottom: 1.8cm),
      footer-descent: 30%,
      paper: "a3",
      flipped: true,
      columns: 2,
      footer: context basic-footer(english: english),
    )
    set columns(gutter: 1.2cm)

    note-title(title: title, ymd: ymd)
    set-lang-nt(english, doc)
  } else {
    note-title(title: title, ymd: ymd)
    set-lang-nt(english, doc)
  }
}
