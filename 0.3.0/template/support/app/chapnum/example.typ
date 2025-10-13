#import "chapnum.typ": chap-num
#show: chap-num.with(
  config: (
    // by default
    (figure.where(kind: image), figure, "1-1"),
    (figure.where(kind: table), figure, "1-1"),
    (figure.where(kind: raw), figure, "1-1"),
    (math.equation, math.equation, "(1-1)"),
    // add your own with
    // (counter key, settable function, numbering pattern)
  ),
  unnumbered-label: "-",
)

#set heading(numbering: "1.")

= Introduction
This chapter introduces basic concepts and equations.

@newton-2nd-law is a numbered equation:
$ F = m a $ <newton-2nd-law>

And this equation has no number:
$ E = m c^2 $ <->

Here's another numbered equation:
$ p = m v $ <momentum>

#figure(
  rect(),
  caption: "A Rect",
)

= Methodology
In this chapter, we present our experimental setup.

The governing equation for our system is:
$ nabla^2 phi = rho / epsilon_0 $ <gauss-law>

#figure(
  circle(),
  caption: "A Circle",
)

Note that equation numbers reset in this new chapter.

This equation also has no number:
$ v = omega r $ <->

#figure(
  ellipse(),
  caption: "A Ellipse",
)
