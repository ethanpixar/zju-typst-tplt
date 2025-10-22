#import "support/basic-settings.typ": *

#let entry(a, b, c) = {
  v(2pt)
  set text(weight: 600, 11pt)
  grid(
    columns: (1fr, 80pt, 100pt),
    align: (left + horizon, center + horizon, right + horizon),
    a, b, c,
  )
  v(-2pt)
}

#let entry2(a, b) = {
  v(2pt)
  set text(weight: 600, 11pt)
  grid(
    columns: (1fr, 100pt),
    align: (left + horizon, right + horizon),
    a, b,
  )
  v(-2pt)
}

#let out-image(image, height, extra-space: 0em) = box(inset: -height / 2, image, height: extra-space, width: height)

#let mm = text(font: "PingFang SC")["]

// ------------------- Main template ---------------------
// Even if the name is CV, it is actually a template for work resume.
#let CV(
  name: "姓名",
  phone: "123-4567-8910",
  email: "example@example.com",
  job: "意向岗位",
  english: false,
  description: none,
  doc,
) = {
  set text(size: 10pt, font: sans-nt)

  show heading.where(level: 1): it => {
    set text(font: sans-nt, 14pt, rgb("#020e269f"), weight: 600)
    it
    v(-5pt)
    line(length: 100%, stroke: (thickness: 2pt, paint: rgb("#8c93b5af"), cap: "round"))
  }

  // header & footer

  set page(
    margin: (x: 1.1cm, top: 1cm, bottom: 0.5cm),
    header: context if counter(page).get().first() == 1 {
      v(53pt)
      grid(
        columns: 2,
        align: horizon,
        column-gutter: 7pt,
        box(
          image("求是蓝.svg", height: 3em),
        ),
        box(
          image("zju.svg", height: 1.7em),
        ),
      )
    },
  )
  v(2pt)
  if description != none { v(-15pt) }
  grid(
    columns: (16%, auto, 16%),
    align: (left, horizon + center, right),
    [],
    secenter[
      #v(-15pt)
      #text(
        font: if english { "SF Pro" } else { "MiSans" },
        size: 20pt,
        name,
      )\
      #if description == none { v(3pt) }
      #text(12pt)[#email;#h(10pt)#phone]

      #text(13pt, weight: 600, if description == none {
        if english [#text(rgb("#020e269f"))[Applying for:] #job] else [#text(rgb("#020e269f"))[应聘意向：]#job]
      } else [　])
    ],
    if description == none { image("profile-cv-transparent.png") } else { image("profile-cv.png") },
  )
  v(-30pt)
  if description != none {
    v(-40pt)
    text(14pt, weight: 600, if english [#text(rgb("#020e269f"))[Applying for:] #job] else [#text(
        rgb("#020e269f"),
      )[应聘意向：]#job])
    box(description, width: 83%)
  }
  doc
}
