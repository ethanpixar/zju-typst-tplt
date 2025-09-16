#import "support/basic-settings.typ": *



// ------------------- Main template ---------------------
#let RP(
  course: "课程",
  proj-name: "Project",
  english: false,
  doc,
) = {
  // header & footer
  set page(
    header: context if counter(page).get().first() > 1 {
      zju-header(
        course: course,
        proj-name: proj-name,
      )
    },
    footer: context basic-footer(english: english),
  )
  set-lang(english, first-line-indent-all: false, doc)
}
