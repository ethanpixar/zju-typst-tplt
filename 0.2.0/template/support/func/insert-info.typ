#import "../list/fonts.typ": *
#import "ymd.typ": insert-date
#import "func.typ": *

#let info = json("../../../info.json")

#let insert-info(english, ymd, is-long-info) = secenter({
  let name = if english [#info.name; | ] else [#info.name-cn｜]

  v(5pt)
  if english {
    set text(font: enserif-c)
    if is-long-info { info.long-info } else { name + [*#info.major-short* #info.student-id] }
    linebreak()
    emph(insert-date(english: true, ymd))
  } else {
    if is-long-info {
      set text(font: sans)
      grid(
        align: center + horizon,
        columns: if ymd != none { (1fr, 1fr, 1fr, 1fr) } else { (1fr, 1fr, 1fr) },
        column-gutter: 5pt,
        box-2grid([姓#if ymd == none [　　]名：], info.name-cn),
        box-2grid([专#if ymd == none [　　]业：], info.major-cn),
        box-2grid([学#if ymd == none [　　]号：], info.student-id),
        if ymd != none { box-2grid("日期：", insert-date(condensed: true, ymd)) }
      )
    } else {
      name
      text(font: enserif-c)[*#info.major-short* #info.student-id]
      linebreak()
      insert-date(ymd)
    }
  }
  v(5pt)
})
