#import "support/basic-settings.typ": *

#let info = json("../info.json")

// 课程论文封面
#let zju-paper-cover(
  title: none,
  miname: info.name-cn,
  student-id: info.student-id,
  major: info.major-cn,
  school: info.school-cn,
  course: [课程名称],
  teacher: none,
  ymd: "today",
  english: false,
) = {
  set text(font: serif, top-edge: 0.65em)
  set page(
    paper: "a4",
    margin: (x: 0pt, top: 115pt, bottom: 60pt),
  )
  if english {
    // none for now
  } else {
    set align(center)
    image("zju.svg", height: 70pt)
    v(43pt)
    sec(sans--h(size: 30pt, course))
    v(40pt)
    image("求是黑.svg", height: 185pt)

    set align(bottom)
    set text(16pt)
    set grid(
      columns: 2,
      row-gutter: 10pt,
      align: center + horizon,
    )

    let zju-cover-grid(a, b, width: 256pt) = {
      grid(
        a,
        underlined-rect(width: width, b),
      )
      v(-9pt)
    }


    zju-cover-grid([论文题目：], title)

    zju-cover-grid([姓名学号：], miname + [　] + student-id)
    zju-cover-grid([学　　院：], school)
    zju-cover-grid([专　　业：], major)
    zju-cover-grid([指导教师：], teacher)

    v(39pt)
    set text(size: 12pt)
    insert-date(ymd)
    counter(page).update(0)
  }
}

// --------- View the Cover ---------

#zju-paper-cover()
