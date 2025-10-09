#import "support/basic-settings.typ": *

// FUNCTIONS

#let disclosure(title: [Disclosure], doc) = block(
  width: 100%,
  stroke: (thickness: 1.2pt, cap: "round", dash: (0pt, 4pt)),
  inset: 10pt,
  radius: 6pt,
  {
    if title != none { h0(lvl: 2, title) }
    doc
  },
)

#let problem-counter = counter("problems")
#let problem(order, body) = {
  problem-counter.step()
  context if problem-counter.get().at(0) != 1 { v(10pt) } else { v(1pt) }
  block(
    width: 100%,
    radius: 6pt,
    inset: 8pt,
    stroke: 2pt + luma(80%),
    if order == -1 {
      body
    } else if order == 0 {
      grid(
        columns: 2,
        column-gutter: 5pt,
        strong[#context { problem-counter.get().at(0) }], body,
      )
    } else {
      grid(
        columns: 2,
        column-gutter: 5pt,
        strong[#order], body,
      )
    },
  )
}
#let labeling(body) = {
  emph(
    text(
      font: enserif-c,
      size: 10pt,
      fill: rgb(83, 102, 193),
      weight: "black",
      body,
    ),
  )
  [　]
  h(-1em)
}

#let ans(mode) = {
  if mode == 1 {
    labeling("SOLUTION:")
  } else if mode == 0 {
    labeling("PROOF:")
  } else if mode == 2 {
    labeling("ANSWER:")
  }
}
#let SOLUTION = ans(1)
#let PROOF = ans(0)
#let ANSWER = ans(2)

// 证明结束符
#let done = [#h(1fr)■]
// part  // #let part(string) = align(center)[*_-- Part #string --_*]
#let part-counter = counter("parts")
#let part(is-Part-included: true, string) = {
  part-counter.step()
  context if part-counter.get().at(0) != 1 { v(15pt) }
  align(center, if is-Part-included [*_-- Part #string --_*] else [*_-- #string --_*])
  context if part-counter.get().at(0) != 1 { v(-10pt) } else { v(-1.3pt) }
}



// ------------------- Main template ---------------------
#let HW(
  course: "课程",
  course-short-name: none,
  proj-name: "Project",
  title-no-break: false, // Only for cn, en always break
  is-long-info: true,
  ymd: none,
  english: false,
  first-line-indent-all: false,
  doc,
) = {
  // header & footer
  set page(
    header: context {
      zju-header(
        course: if course-short-name != none { course-short-name } else { course },
        proj-name: proj-name,
        is-course-in-header: counter(page).get().first() > 1,
        is-proj-name-in-header: counter(page).get().first() > 1,
      )
    },
    footer: context basic-footer(english: english),
  )
  v(10pt)
  // Title
  if english {
    secenter(SansH(20pt, course))
    secenter(SansH(26pt, weight: "medium", proj-name))
  } else if title-no-break {
    secenter(SansH(24pt, course + " " + proj-name))
  } else {
    v(-5pt)
    secenter(SansH(26pt, proj-name))
    v(3pt)
    secenter(Sans(size: 18pt, course))
  }
  insert-info(english, ymd, is-long-info)
  set-lang(english, first-line-indent-all: false, first-line-indent-amount: 0pt, doc)
}
