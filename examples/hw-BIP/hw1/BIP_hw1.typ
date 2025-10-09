#import "@local/tplt:0.2.0": *

#show: BL.with(is-table-cell-stroked: false)
#let ymd = "today"
#let course = "Biomedical Image Processing"
#let proj-name = "Homework 1"

#show: HW.with(
  course: course,
  proj-name: proj-name,
  english: true,
  ymd: ymd,
)

#problem(1)[
  Given the histogram of a grayscale image, apply the histogram equalization algorithm to enhance the image's contrast.
  #figure(image("pics/1.png"))
]
#SOLUTION
According to that $ s_k = T(r_k) = (L-1)∑^k_(j=0)p_r (r_j) $
For this picture, $M times N = 638+377+721+1860+2481+2941+882+100 = 10000$, which gives $p_r (r_k) = n_k\/M N$ as follows:
#figure(
  table(
    columns: 3,
    table.header($r_k$, $n_k$, $p_r (r_k) = n_k\/M N$),
    [0], [638], [0.0638],
    [1], [377], [0.0377],
    [2], [721], [0.0721],
    [3], [1860], [0.186],
    [4], [2481], [0.2481],
    [5], [2941], [0.2941],
    [6], [882], [0.0882],
    [7], [100], [0.01],
    table.hline(),
  ),
)
Then $s_k = T(r_k) = 7 times ∑^k_(j=0)p_r (r_j)$, which gives:
$
  s_0 & = 7 times 0.0638 = 0.447 -> 0, \
  s_1 & = 7 times (0.0638+0.0377) = 0.711 -> 1, \
  s_2 & = 7 times (0.0638+0.0377+0.0721) = 1.215 -> 1, \
  s_3 & = 7 times (0.0638+0.0377+0.0721+0.186) = 2.517 -> 3, \
  s_4 & = 7 times (0.0638+0.0377+0.0721+0.186+0.2481) = 4.254 -> 4, \
  s_5 & = 7 times (0.0638+0.0377+0.0721+0.186+0.2481+0.2941) = 6.313 ->6, \
  s_6 & = 7 times (0.0638+0.0377+0.0721+0.186+0.2481+0.2941+0.0882) = 6.93 -> 7, \
  s_7 & = 7 times (0.0638+0.0377+0.0721+0.186+0.2481+0.2941+0.0882+0.01) = 7 -> 7 \
$
Eventually giving:
#figure(
  table(
    columns: 2,
    table.header($s_k "(rounded)"$, $n_k$),
    [0], [638],
    [1], [1098],
    [3], [1860],
    [4], [2481],
    [6], [2941],
    [7], [982],
    table.hline(),
  ),
)
which is a histogram equalized image as followed:
#figure(image("code/1.svg"))

#problem(2)[
  Given two random variables R and Z with the following probability density functions (PDFs):
  - R has a PDF: $p_r (r) = 2r$
  - Z has a PDF: $p_z (z) = 3z^2$
  Find the transformation (expressed in terms of $r$ and $z$) that will accomplish this.
  #figure(image("pics/2.png"))
]
#SOLUTION According to the equality of probabilities:

$ p_s (s)dot abs(dif s) = p_r (r)dot abs(dif r) $

For $p_r (r) = 2r$ and $p_z (z) = 3z^2$ would give:
$ 3z^2 dot abs(dif z) & = 2r dot abs(dif r) $
Since both $r$ and $z$ are positive, we can remove the absolute value signs, which gives:
$
     && 3z^2 dif z & = 2r dif r \
  => && ∫3z^2dif z & = ∫2r dif r \
  => &&        z^3 & = r^2 + C
$
when $z=0$, $r=0$, $C=0$, which gives $ z = r^(2/3) $

#problem(3)[
  Triangle A's vertices are in the position $(1,0)$, $(2,0)$ and $(2,0.5)$, design a list of affine transformation matrices to transform the triangle A to triangle B, which's vertices are in $(1,1.5)$, $(2,0.5)$ and $(2.5,1)$ respectively.
  #figure(image("pics/3.png"))
  After that, give the inverse transformation matrices list to transform the triangle B to triangle A.
]
#SOLUTION
Let the transform matrix from A to B be $bM = mat(a, b, t_x; c, d, t_y; 0, 0, 1)$, $a, b, c, d, t_x, t_y$ should be solved by the following equations:
$
  bM vec(1, 0, 1) = vec(1, 1.5, 1), quad
  bM vec(2, 0, 1) = vec(2, 0.5, 1), quad
  bM vec(2, 0.5, 1) = vec(2.5, 1, 1)
$
which gives the following system of equations:
$
    a⋅1+b⋅0+t_x & = 1  & => &&       a+t_x & = 1 \
    c⋅1+d⋅0+t_y & =1.5 & => &&       c+t_y & = 1.5 \
    a⋅2+b⋅0+t_x & =2   & => &&      2a+t_x & = 2 \
    c⋅2+d⋅0+t_y & =0.5 & => &&      2c+t_y & = 0.5 \
  a⋅2+b⋅0.5+t_x & =2.5 & => && 2a+0.5b+t_x & = 2.5 \
  c⋅2+d⋅0.5+t_y & =1   & => && 2c+0.5d+t_y & = 1 \
$
this gives:
$
  a=1, b=1, t_x=0\
  c=-1, d=1, t_y=2.5
$
So, the transformation matrix from A to B is $ bM = mat(1, 1, 0; -1, 1, 2.5; 0, 0, 1) $

#mv

For matrix $bM = mat(bA, bt; b0, 1)$, where $bA = mat(1, 1; -1, 1)$ and $bt = vec(0, 2.5)$, the inverse is $bM^(-1) = mat(bA^(-1), -bA^(-1)bt; b0, 1)$

#mv

First, find $bA^(-1)$:
$ det(bA) = 2 => bA^(-1) = 1 / 2 mat(1, -1; 1, 1) = mat(0.5, -0.5; 0.5, 0.5) $
Then calculate
$ -bA^(-1)bt = - mat(0.5, -0.5; 0.5, 0.5) vec(0, 2.5) = vec(1.25, -1.25) $
So, the inverse transformation matrix from B to A is $ bM^(-1) = mat(0.5, -0.5, 1.25; 0.5, 0.5, -1.25; 0, 0, 1) $
