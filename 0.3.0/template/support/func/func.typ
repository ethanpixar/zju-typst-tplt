// section = empty wide block
// this is only used for specific layouting, where the default 1.2em spacing is not expected, and it's required to assign a v(x) space
#let sec(body) = block(
  spacing: 1em,
  above: 1em,
  below: 1em,
  width: 100%,
  body,
)
#let secenter(body) = sec({
  set align(center)
  body
})

// layouting
#let d2 = h(-2em)
#let s2 = h(2em)
#let h0(
  outlined: false,
  lvl: 1,
  centent,
) = heading(
  outlined: outlined,
  level: lvl,
  numbering: none,
  centent,
)

// MATH
// math vertical spacing used with
// #show math.equation.where(block: false): math.display
#let mv = v(10pt)
// cases in display mode, not recommended though
#let dcase(..args) = math.cases(..args.pos().map(math.display))

// underlined box
#let underlined-rect(width: auto, stroke: 0.6pt, content) = rect(width: width, stroke: (bottom: stroke), content)
// underlined box with text
#let box-2grid(a, b) = box(
  grid(
    inset: (y: -6pt),
    columns: 2,
    align: center + horizon,
    a, underlined-rect(width: 100%, b),
  ),
)

// Add a blank page
#let blankpage(content, margin: (x: 0cm, y: 0cm), flipped: false) = page(
  flipped: flipped,
  margin: (x: margin.x, y: margin.y),
  header: [],
  footer: [],
  content,
)
