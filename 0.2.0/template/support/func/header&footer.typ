#import "../list/fonts.typ": *

// headers
#let zju-header(
  course: "课程",
  is-course-in-header: true,
  proj-name: "Project",
  is-proj-name-in-header: true,
) = {
  set text(10pt)
  box(baseline: 25%, image("zju.svg", height: 1.7em))
  text(10pt)[　]
  h(-1em)
  if is-course-in-header {
    h(7pt)
    Sans(size: 10pt)[*#course*]
  }
  h(1fr)
  if is-proj-name-in-header {
    text(style: "italic", font: ("Charter", kai), proj-name)
  }
}
// footers
#let basic-footer(english: false) = {
  set text(10pt)
  set text(weight: "bold", font: "Charter")
  counter(page).display(
    if english { "1 of 1" } else { "1 – 1" },
    both: true,
  )
}
