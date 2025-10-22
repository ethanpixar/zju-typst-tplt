#import "@preview/numbly:0.1.0": numbly

#let set-lang-nt(english, doc) = if english {
  set heading(
    numbering: numbly(
      "{1:I}.",
      "{1}.{2}",
      "{3:A}",
      "{3:A}{4}",
      "{3:A}{4}-{5}",
      "{6:a}.",
    ),
  )
  set par(
    first-line-indent: (
      amount: 1.5em,
    ),
  )
  doc
} else {
  show heading: it => {
    show h.where(amount: 0.3em): none
    it
  }
  set heading(
    numbering: numbly(
      "{1:一}、",
      "{1}.{2} ",
      "{3:A} ",
      "{3:A}{4} ",
      "{3:A}{4}-{5} ",
      "{6:a}. ",
    ),
  )
  set par(
    justify: true,
    first-line-indent: (
      amount: 2em,
    ),
  )
  set text(lang: "zh", region: "cn")
  set figure.caption(separator: [ -- ])
  show outline.entry: it => {
    show "、": "、" + h(-0.5em)
    show " ": none
    it
  }
  doc
}
