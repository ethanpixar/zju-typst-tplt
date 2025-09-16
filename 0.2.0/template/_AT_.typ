#import "support/basic-settings.typ": *


// ------------------- Main template ---------------------
#let AT(
  course: "课程",
  title: "标题",
  subtitle: none,
  ymd: none,
  named: true,
  is-long-info: true,
  english: false,
  doc,
) = {
  // header & footer
  set page(
    header: context {
      zju-header(
        course: course,
        proj-name: title,
        is-proj-name-in-header: counter(page).get().first() > 1,
      )
    },
    footer: context basic-footer(english: english),
  )
  v(15pt)
  // Title
  secenter({
    if english {
      set par(leading: 0.5em)
      SerifH(24pt, title)
    } else { text(font: xbs, size: 24pt, title) }
  })

  v(5pt)

  if subtitle != none {
    secenter({
      if english {
        set par(leading: 0.5em)
        SerifH(18pt, subtitle)
      } else { text(font: fangsong, size: 18pt, subtitle) }
    })

    v(5pt)
  }

  if named { insert-info(english, ymd, is-long-info) }

  set-lang-at(english, doc)
}
