#import "support/basic-settings.typ": *

#let info = json("../info.json")

#let exp-info-chart(
  titled: true,
  course: "课程名称",
  exp-cate: "实验类型",
  teacher: "指导老师",
  exp-name: "试验名称",
  miname: info.name-cn,
  student-id: info.student-id,
  major: info.major-cn,
  student-count: 1,
  is-student-titled: false,
  students: none,
  classmate-count: 0,
  classmates: none,
  where: "玉泉创客空间",
  ymd: "today",
) = {
  v(-0.6cm)
  set text(font: sans)
  set align(center)
  if titled {
    v(0.1cm)
    grid(
      columns: 2,
      column-gutter: 8pt,
      align: (horizon),
      image("zju.svg", height: 30pt), K(size: 24pt)[*实验报告*],
    )
    v(-0.1cm)
  }

  grid(
    align: center + horizon,
    columns: (1fr, 1fr, 1fr),
    column-gutter: 5pt,
    box-2grid("课程名称：", course), box-2grid("实验类型：", exp-cate), box-2grid("指导老师：", teacher),
  )
  box-2grid("实验名称：", exp-name)

  if student-count != 1 {
    if is-student-titled {
      let n = 1
      while n <= student-count {
        grid(
          align: center + horizon,
          columns: (1fr, 1fr, 1fr),
          column-gutter: 5pt,
          box-2grid(students.at(n - 1).at(0) + "：", students.at(n - 1).at(1)),
          box-2grid("学　　号：", students.at(n - 1).at(2)),
          box-2grid("专　　业：", students.at(n - 1).at(3)),
        )
        n += 1
      }
    } else {
      let n = 1
      while n <= student-count {
        grid(
          align: center + horizon,
          columns: (1fr, 1fr, 1fr),
          column-gutter: 5pt,
          box-2grid([学#h(0.5em)生#h(0.5em)#numbering("一", n)：], students.at(n - 1).at(0)),
          box-2grid("学　　号：", students.at(n - 1).at(1)),
          box-2grid("专　　业：", students.at(n - 1).at(2)),
        )
        n += 1
      }
    }
  } else {
    grid(
      align: center + horizon,
      columns: (1fr, 1fr, 1fr),
      column-gutter: 5pt,
      box-2grid("姓　　名：", miname), box-2grid("学　　号：", student-id), box-2grid("专　　业：", major),
    )
  }

  if classmates != none {
    if classmate-count >= 3 {
      box-2grid("同组学生姓名：", classmates)
      grid(
        align: center + horizon,
        columns: (1fr, 1fr),
        column-gutter: 5pt,
        box-2grid("实验地点：", where),
        box-2grid(
          "日　　期：",
          insert-date(ymd, filler: [　]),
        ),
      )
    } else {
      grid(
        align: center + horizon,
        columns: (1fr, 1fr, 1fr),
        column-gutter: 5pt,
        box-2grid("同组学生：", classmates),
        box-2grid("实验地点：", where),
        box-2grid(
          "日　　期：",
          insert-date(condensed: true, ymd, filler: [　]),
        ),
      )
    }
  } else {
    grid(
      align: center + horizon,
      columns: (1fr, 1fr),
      column-gutter: 5pt,
      box-2grid("实验地点：", where),
      box-2grid(
        "日　　期：",
        insert-date(ymd, filler: [　]),
      ),
    )
  }
  v(3pt)
}
