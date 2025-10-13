#import "support/basic-settings.typ": *

#let info = json("../info.json")

#let zju-cover(
  title: none,
  proj-name: none,
  miname: info.name-cn,
  student-id: info.student-id,
  major: info.major-cn,
  school: info.school-cn,
  course: [课程名称],
  teacher: [指导老师],
  ymd: "today",
  english: false,
  student-count: 1,
  leader: none,
  students: none,
) = {
  set text(font: serif, top-edge: 0.65em)
  set page(
    paper: "a4",
    margin: (x: 0pt, top: 135pt, bottom: 60pt),
  )
  if english {
    // none for now
  } else {
    set align(center)
    image("zju.svg", height: 56pt)
    v(10pt)
    image("求是蓝.svg", height: 152pt)
    v(50pt)
    sec(sans--h(size: 32pt, if proj-name != none {
      if title != none { title } else { course + [实验报告] }
    } else [本科实验报告]))

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

    if proj-name != none {
      zju-cover-grid([项目名称：], proj-name)
    }
    if student-count == 1 {
      zju-cover-grid([姓　　名：], miname)
      zju-cover-grid([学　　号：], student-id)
    } else if student-count == 2 {
      zju-cover-grid([学#h(0.5em)生#h(0.5em)一：], students.at(0))
      zju-cover-grid([学#h(0.5em)生#h(0.5em)二：], students.at(1))
    } else {
      zju-cover-grid([组　　长：], leader)
      zju-cover-grid([成　　员：], students)
    }
    zju-cover-grid([学　　院：], school)
    zju-cover-grid([专　　业：], major)
    if proj-name == none {
      zju-cover-grid([课程名称：], course)
    }
    zju-cover-grid([指导老师：], teacher)

    v(39pt)
    set text(size: 12pt)
    insert-date(ymd)
    counter(page).update(0)
  }
}

// --------- View the Cover ---------

#zju-cover(
  proj-name: [项目名称],
  student-count: 3,
  leader: [龚玉传],
  students: [华宇杰, 包博文],
)
