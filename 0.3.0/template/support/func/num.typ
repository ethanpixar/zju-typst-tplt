// number format functions
// ①
#let cir(number) = numbering("①", number)

// 1.1º
#let qf(sequence) = underline(
  stroke: 1pt,
  offset: 2.3pt,
  text(weight: "semibold")[#sequence°],
)

// (1.1)_underlined
#let eqp(sequence) = underline(
  stroke: 0.5pt,
  offset: 3.3pt,
  [(#sequence)],
)
