#let ensans = "SF Pro Display"
#let ensans-h = "SF Pro Display"
#let enserif = "New Computer Modern"
#let enserif-h = "EB Garamond"
#let enserif-c = "Charter"
#let hei = "FZHei-B01"
#let dh = "FZDaHei-B02"
#let song = "FZShuSong-Z01"
#let fangsong = "FZFangSong-Z02S"
#let xbs = "FZXiaoBiaoSong-B05"
#let kai = "FZKai-Z03"

// font func dh: 大黑，h: 黑体，bt: 标宋，k: 楷体
#let DH(size: 12pt, body) = text(font: dh, size: size, body)
#let H(size: 12pt, body) = text(font: hei, size: size, body)
#let BT(size: 12pt, body) = text(font: xbs, size: size, body)
#let K(size: 12pt, body) = text(font: kai, size: size, body)

#let DH0(body) = text(font: dh, body)
#let H0(body) = text(font: hei, body)
#let BT0(body) = text(font: xbs, body)
#let K0(body) = text(font: kai, body)

// font Groups
#let sans = (ensans, hei)
#let sans-nt = (ensans, "PingFang SC")
#let serif = (enserif, song)
#let sans-h = (ensans-h, dh)
#let serif-h = (enserif-h, xbs)
#let mono = ("SF Mono", "PingFang SC")

#let Sans(size: 12pt, body) = text(font: sans, size: size, body)
#let Serif(size: 12pt, body) = text(font: serif, size: size, body)

#let Sans0(body) = text(font: sans, body)
#let Serif0(body) = text(font: serif, body)

// title
#let SansH(size, weight: "semibold", body) = text(font: sans-h, size: size, weight: weight, body)
#let SerifH(size, body) = text(font: serif-h, size: size, weight: "medium", body)
// stretched title
#let sans--h(tracking: 5pt, size: 12pt, body) = text(
  tracking: tracking,
  font: sans-h,
  size: size,
  weight: "semibold",
  body,
)
#let serif--h(tracking: 5pt, size: 12pt, body) = text(
  tracking: tracking,
  font: serif-h,
  size: size,
  weight: "medium",
  body,
)
