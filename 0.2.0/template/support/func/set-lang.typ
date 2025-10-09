#import "@preview/numbly:0.1.0": numbly

#let set-lang(english, first-line-indent-all: true, first-line-indent-amount: 2em, doc) = if english {
  set heading(
    numbering: numbly(
      "{1:I}.",
      "{1}.{2}",
      "{1}.{2}.{3}",
      "{1}.{2}.{3}.{4}",
      "{1}.{2}.{3}.{4}.{5}",
      "{1}.{2}.{3}.{4}.{5}.{6}",
    ),
  )
  set par(
    first-line-indent: (
      amount: first-line-indent-amount,
    ),
  )
  set outline(depth: 2)
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
      "{1}.{2}.{3} ",
      "{1}.{2}.{3}.{4} ",
      "{1}.{2}.{3}.{4}.{5} ",
      "{1}.{2}.{3}.{4}.{5}.{6} ",
    ),
  )
  set par(
    justify: true,
    first-line-indent: (
      amount: first-line-indent-amount,
      all: first-line-indent-all,
    ),
  )
  set text(lang: "zh", region: "cn")
  set figure.caption(separator: [ -- ])
  show outline.entry: it => {
    show "、": "、" + h(-0.5em)
    show " ": none
    it
  }
  set outline(depth: 2, title: [目　录])
  doc
}

