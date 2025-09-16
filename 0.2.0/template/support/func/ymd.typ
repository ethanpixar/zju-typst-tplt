
// ymd
// ymd formatter
#let parse-date(date-str) = {
  // Split the string at "-"
  let parts = date-str.split("-")
  // Convert each part to an integer
  let year = int(parts.at(0))
  let month = int(parts.at(1))
  let day = int(parts.at(2))
  // Return as an array
  (year, month, day)
}
// format YYYY/M/D
#let insert-ymd-slash(ymd) = {
  if ymd == "today" {
    [#datetime.today().display("[year]/[month padding:none]/[day padding:none]")]
  } else {
    // Parse the date string
    let ymd = parse-date(ymd)
    let date = datetime(year: ymd.at(0), month: ymd.at(1), day: ymd.at(2))
    [#date.display("[year]/[month padding:none]/[day padding:none]")]
  }
}
// format YYYY -- MM -- DD
#let insert-ymd-hyphen(ymd) = {
  if ymd == "today" {
    [#datetime.today().display("[year] – [month padding:none] – [day padding:none]")]
  } else {
    // Parse the date string
    let ymd = parse-date(ymd)
    let date = datetime(year: ymd.at(0), month: ymd.at(1), day: ymd.at(2))
    [#date.display("[year] – [month padding:none] – [day padding:none]")]
  }
}
#let insert-ymd-cn(ymd) = {
  if ymd == "today" {
    [#datetime.today().display("[year]年[month padding:none]月[day padding:none]日")]
  } else {
    // Parse the date string
    let ymd = parse-date(ymd)
    let date = datetime(year: ymd.at(0), month: ymd.at(1), day: ymd.at(2))
    [#date.display("[year]年[month padding:none]月[day padding:none]日")]
  }
}
#let insert-ymd-en(ymd) = {
  if ymd == "today" {
    [#datetime.today().display("[year], [month repr:short] [day padding:none]")]
  } else {
    // Parse the date string
    let ymd = parse-date(ymd)
    let date = datetime(year: ymd.at(0), month: ymd.at(1), day: ymd.at(2))
    [#date.display("[year], [month repr:short] [day padding:none]")]
  }
}
#let insert-date(english: false, condensed: false, delimiter: "/", ymd, filler: none) = if ymd == none {
  filler
} else if condensed {
  if delimiter == "/" { insert-ymd-slash(ymd) } else if delimiter == "-" { insert-ymd-hyphen(ymd) }
} else if english {
  insert-ymd-en(ymd)
} else {
  insert-ymd-cn(ymd)
}
