// styling functions
// wavy underline
#let draw-wavy-line(color: black) = pattern(
  size: (4pt, 3pt),
  path(
    stroke: color + 0.5pt,
    ((0%, 10%), (-20%, 0%)),
    ((50%, 40%), (-20%, 0%)),
    ((100%, 10%), (-20%, 0%)),
  ),
)

#let wavy(color: black, content) = {
  underline(
    stroke: (thickness: 3pt, paint: draw-wavy-line(color: color)),
    evade: false,
    offset: 2pt,
    content,
  )
}

// double underline
// offset is set for english and Chinese
#let u2e(offset: 3.6pt, content) = underline(underline(offset: offset), content)
#let u2z(offset: 4pt, content) = underline(underline(offset: offset), content)

