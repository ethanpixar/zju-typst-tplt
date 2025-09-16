#import "@local/tplt:0.2.0": *

#show: BL

#let ymd = "2025-04-18"
#let course = "Biomedical Image Processing"
#let proj-name = "Homework 4"

#show: HW.with(
  proj-name: proj-name,
  course: course,
  english: true,
  ymd: ymd,
)

#disclosure[
  Gemini 2.0 Flash Thinking Experimental and Cursor are used to help writing this homework.
]

#problem(1)[
  A grayscale image has the following histogram:
  #image("image/1.png", width: 90%)
  Use Otsu's method to compute the optimal threshold that
  maximizes the between-class variance.
]
#SOLUTION From the histogram, we can find the number of pixels $h(i)$ for each gray level $i$:

$
  h(0) = 50,
  h(1) = 50,
  h(2) = 40,
  h(3) = 20,
  h(4) = 10,
  h(5) = 10,
  h(6) = 10,
  h(7) = 10\
  N = 50 + 50 + 40 + 20 + 10 + 10 + 10 + 10 = 200
$

Calculate Probability of Each Gray Level ($p_i$)

$
  p_i = h(i) \/ N\
  p_0 = 50 \/ 200 = 0.25\
  p_1 = 50 \/ 200 = 0.25\
  p_2 = 40 \/ 200 = 0.20\
  p_3 = 20 \/ 200 = 0.10\
  p_4 = 10 \/ 200 = 0.05\
  p_5 = 10 \/ 200 = 0.05\
  p_6 = 10 \/ 200 = 0.05\
  p_7 = 10 \/ 200 = 0.05
$

Apply Otsu's Method, the between-class variance
$ σ_B^2(T) = w_1(T) dot w_2(T) dot (μ_1(T) - μ_2(T))^2 $
where:
- $T$ is the threshold (ranging from 0 to 6, as it separates levels 0..T from T+1..7).
- $w_1(T)$ is the probability (weight) of Class 1 (pixels with gray level ≤ T). $ w_1(T) = sum_(i=0)^T p_i $
- $w_2(T)$ is the probability (weight) of Class 2 (pixels with gray level > T). $ w_2(T) = sum_(i=T+1)^7 p_i = 1 - w_1(T) $
- $μ_1(T)$ is the mean gray level of Class 1. $ μ_1(T) = (sum_(i=0)^T i dot p_i) /( w_1(T)) $
- $μ_2(T)$ is the mean gray level of Class 2. $ μ_2(T) = (sum_(i=T+1)^7 i dot p_i) / (w_2(T)) $

We can simplify calculations by pre-calculating the cumulative sum of probabilities $w_1(T)$ and the cumulative sum of $i dot p_i$, let's call it:
$ m(T) = sum_(i=0)^T i dot p_i $
The total mean:
$
  μ_G =& sum_(i=0)^7 i dot p_i \
  =& (0times 0.25) + (1times 0.25) + (2times 0.20) + (3times 0.10) + \ & (4times 0.05) + (5times 0.05) + (6times 0.05) + (7times 0.05) \
  =& 0 + 0.25 + 0.40 + 0.30 + 0.20 + 0.25 + 0.30 + 0.35 = 2.05
$
Then $μ_1(T) = m(T) /( w_1(T))$ and $μ_2(T) = (μ_G - m(T)) / (w_2(T))$

And
$ σ_B^2(T) = w_1(T) dot (μ_1(T) - μ_G)^2 + w_2(T) dot (μ_2(T) - μ_G)^2 $
which is easier to compute.

We iterate through possible thresholds T from 0 to 6:

$T = 0$:
$
  w_1(0) &= p_0 = 0.25\
  w_2(0) &= 1 - 0.25 = 0.75\
  m(0) &= 0 dot p_0 = 0\
  μ_1(0) &= m(0) / (w_1(0)) = 0 / 0.25 = 0\
  μ_2(0) &= (μ_G - m(0)) / (w_2(0)) = (2.05 - 0) / 0.75 ≈ 2.733\
  σ_B^2(0) &= 0.25 times 0.75 times (0 - 2.733)^2 ≈ 0.1875 times 7.470 ≈ 1.401
$

$T = 1$:
$
  w_1(1) &= p_0 + p_1 = 0.25 + 0.25 = 0.50\
  w_2(1) &= 1 - 0.50 = 0.50\
  m(1) &= m(0) + 1 times p_1 = 0 + 1 times 0.25 = 0.25\
  μ_1(1) &= m(1) / (w_1(1)) = 0.25 / 0.50 = 0.5\
  μ_2(1) &= (μ_G - m(1)) / (w_2(1)) = (2.05 - 0.25) / 0.50 = 1.80 / 0.50 = 3.6\
  σ_B^2(1) &= 0.50 times 0.50 times (0.5 - 3.6)^2 = 0.25 times (-3.1)^2 = 0.25 times 9.61 = 2.4025
$

$T = 2$:
$
  w_1(2) &= w_1(1) + p_2 = 0.50 + 0.20 = 0.70\
  w_2(2) &= 1 - 0.70 = 0.30\
  m(2) &= m(1) + 2 p_2 = 0.25 + 2 times 0.20 = 0.25 + 0.40 = 0.65\
  μ_1(2) &= m(2) / (w_1(2)) = 0.65 / 0.70 = 13 / 14 ≈ 0.9286\
  μ_2(2) &= (μ_G - m(2)) / (w_2(2)) = (2.05 - 0.65) / (0.30) = 1.40 / 0.30 = 14 / 3 ≈ 4.667\
  σ_B^2(2) &= 0.70 times 0.30 times (0.9286 - 4.667)^2 = 0.21 times (-3.7384)^2 = 0.21 times 13.976 = 2.935
$

$T = 3$:
$
  w_1(3) &= w_1(2) + p_3 = 0.70 + 0.10 = 0.80\
  w_2(3) &= 1 - 0.80 = 0.20\
  m(3) &= m(2) + 3 p_3 = 0.65 + 3 times 0.10 = 0.65 + 0.30 = 0.95\
  μ_1(3) &= m(3) / w_1(3) = 0.95 / 0.80 = 19 / 16 = 1.1875\
  μ_2(3) &= (μ_G - m(3)) / (w_2(3)) = (2.05 - 0.95) / 0.20 = 1.10 / 0.20 = 5.5\
  σ_B^2(3) &= 0.80 times 0.20 times (1.1875 - 5.5)^2 = 0.16 times (-4.3125)^2 ≈ 0.16 times 18.598 ≈ 2.976
$

$T = 4$:
$
  w_1(4) &= w_1(3) + p_4 = 0.80 + 0.05 = 0.85\
  w_2(4) &= 1 - 0.85 = 0.15\
  m(4) &= m(3) + 4 p_4 = 0.95 + 4 times 0.05 = 0.95 + 0.20 = 1.15\
  μ_1(4) &= m(4) / (w_1(4)) = 1.15 / 0.85 = 23 / 17 ≈ 1.353\
  μ_2(4) &= (μ_G - m(4)) / (w_2(4)) = (2.05 - 1.15) / 0.15 = 0.90 / 0.15 = 6.0\
  σ_B^2(4) &= 0.85 times 0.15 times (1.353 - 6.0)^2 = 0.1275 times (-4.647)^2 = 0.1275 times 21.595 = 2.753
$

$T = 5$:
$
  w_1(5) &= w_1(4) + p_5 = 0.85 + 0.05 = 0.90\
  w_2(5) &= 1 - 0.90 = 0.10\
  m(5) &= m(4) + 5 p_5 = 1.15 + 5 times 0.05 = 1.15 + 0.25 = 1.40\
  μ_1(5) &= m(5) / (w_1(5)) = 1.40 / 0.90 = 14 / 9 ≈ 1.556\
  μ_2(5) &= (μ_G - m(5)) / (w_2(5)) = (2.05 - 1.40) / 0.10 = 0.65 / 0.10 = 6.5\
  σ_B^2(5) &= 0.90 times 0.10 times (1.556 - 6.5)^2 = 0.09 times (-4.944)^2 = 0.09 times 24.443 = 2.200
$

$T = 6$:
$
  w_1(6) &= w_1(5) + p_6 = 0.90 + 0.05 = 0.95\
  w_2(6) &= 1 - 0.95 = 0.05\
  m(6) &= m(5) + 6 p_6 = 1.40 + 6 times 0.05 = 1.40 + 0.30 = 1.70\
  μ_1(6) &= m(6) / ( w_1(6)) = 1.70 / 0.95 = 34 / 19 ≈ 1.789\
  μ_2(6) &= (μ_G - m(6)) / (w_2(6)) = (2.05 - 1.70) / 0.05 = 0.35 / 0.05 = 7.0\
  σ_B^2(6) &= 0.95 times 0.05 times (1.789 - 7.0)^2 = 0.0475 times (-5.211)^2 = 0.0475 times 27.155 = 1.290
$

Comparing the between-class variances:
$
  σ_B^2(0) &≈ 1.401\
  σ_B^2(1) &≈ 2.403\
  σ_B^2(2) &≈ 2.935\
  σ_B^2(3) &≈ 2.976 "(Maximum)"\
  σ_B^2(4) &≈ 2.753\
  σ_B^2(5) &≈ 2.200\
  σ_B^2(6) &≈ 1.290
$
The maximum variance occurs when the threshold $T = 3$. This threshold divides the pixels into two classes: ${0, 1, 2, 3}$ and ${4, 5, 6, 7}$.



#problem(2)[
  1. Modify the Sobel and Prewitt kernels to give the strongest gradient response for edges oriented at ±45°:
  #grid(
    columns: 2,
    column-gutter: 20pt,
    image("image/2.png"), image("image/3.png"),
  )
  2. Show respectively: the Sobel and Prewitt kernels above, and in (1) above, give isotropic results only for horizontal and vertical edges, and for edges oriented at ±45°.
]
+ #SOLUTION
  $
    "Prewitt(+45°)" &= mat(
      -1, -1,  0;
      -1,  0,  1;
      0,  1,  1
    ) ,&
    "Prewitt(-45°)" &= mat(
      0,  1,  1;
      -1,  0,  1;
      -1, -1,  0
    )\
    "Sobel(+45°)" &= mat(
      -2, -1,  0;
      -1,  0,  1;
      0,  1,  2
    ),&
    "Sobel(-45°)" &= mat(
      0,  1,  2;
      -1,  0,  1;
      -2, -1,  0
    )
  $

+ #PROOF We calculate the gradient magnitude $G$ using the responses from the orthogonal kernel pairs:
  - Standard: $ G = sqrt(G_x^2 + G_y^2) $
  - Modified: $ G = sqrt(G_"p45"^2 + G_"n45"^2) $ (using p45 for +45° and n45 for -45°)

  We'll use an idealized 3×3 neighborhood with a step edge of strength $k$. The background is 0, and the foreground is $k$.

  + Part 1: Standard Kernels ($G_x, G_y$)
    1. *Horizontal Edge:*
      Neighborhood: $ mat(0, 0, 0; k, k, k; k, k, k) $ (Edge between row 1 and 2)
      - *Prewitt:*
        - $G_x = (0-0) times 1 + (k-k) times 1 + (k-k) times 1 = 0$
        - $G_y = (k+k+k) times 1 - (0+0+0) times (-1) = 3k$
        - $G = sqrt(0^2 + (3k)^2) = 3k$
      - *Sobel:*
        - $G_x = (0-0) times 1 + (k-k) times 2 + (k-k) times 1 = 0$
        - $G_y = (k times 1 + k times 2 + k times 1) - (0 times (-1) + 0 times (-2) + 0 times (-1)) = 4k$
        - $G = sqrt(0^2 + (4k)^2) = 4k$

    2. *Vertical Edge:*
      Neighborhood: $ mat(0, k, k; 0, k, k; 0, k, k) $ (Edge between col 1 and 2)
      - *Prewitt:*
        - $G_x = (k+k+k) times 1 - (0+0+0) times (-1) = 3k$
        - $G_y = (0-0) times (-1) + (k-k) times (-1) + (k-k) times (-1) = 0$
        - $G = sqrt((3k)^2 + 0^2) = 3k$
      - *Sobel:*
        - $G_x = (k times 1 + k times 2 + k times 1) - (0 times (-1) + 0 times (-2) + 0 times (-1)) = 4k$
        - $G_y = (0-0) times (-1) + (k-k) times (-2) + (k-k) times (-1) = 0$
        - $G = sqrt((4k)^2 + 0^2) = 4k$

    3. *+45° Diagonal Edge:*
      Neighborhood: $ mat(0, 0, k; 0, k, k; k, k, k) $
      - *Prewitt:*
        - $G_x = (0 times (-1) + 0 times 0 + k times 1) + (0 times (-1) + k times 0 + k times 1) + (k times (-1) + k times 0 + k times 1) = k + k + 0 = 2k$
        - $G_y = (0 times (-1) + 0 times (-1) + k times (-1)) + (0 times 0 + k times 0 + k times 0) + (k times 1 + k times 1 + k times 1) = -k + 0 + 3k = 2k$
        - $G = sqrt((2k)^2 + (2k)^2) = sqrt(8k^2) = 2 sqrt(2)k ≈ 2.828k$
      - *Sobel:*
        - $G_x = (0 times (-1) + 0 times 0 + k times 1) + (0 times (-2) + k times 0 + k times 2) + (k times (-1) + k times 0 + k times 1) = k + 2k + 0 = 3k$
        - $G_y = (0 times (-1) + 0 times (-2) + k times (-1)) + (0 times 0 + k times 0 + k times 0) + (k times 1 + k times 2 + k times 1) = -k + 0 + 4k = 3k$
        - $G = sqrt((3k)^2 + (3k)^2) = sqrt(18k^2) = 3 sqrt(2)k ≈ 4.243k$

  + Part 2: Modified ±45° Kernels

    1. *+45° Diagonal Edge:*
      Neighborhood: $ mat(0, 0, k; 0, k, k; k, k, k) $
      - *Prewitt ±45°:*
        - $G_"p45" = (0 times (-1) + 0 times (-1) + k times 0) + (0 times (-1) + k times 0 + k times 1) + (k times 0 + k times 1 + k times 1) = 0 + k + 2k = 3k$
        - $G_"n45" = (0 times 0 + 0 times 1 + k times 1) + (0 times (-1) + k times 0 + k times 1) + (k times (-1) + k times (-1) + k times 0) = k + k - 2k = 0$
        - $G = sqrt((3k)^2 + 0^2) = 3k$
      - *Sobel ±45°:*
        - $G_"s45" = (0 times (-2) + 0 times (-1) + k times 0) + (0 times (-1) + k times 0 + k times 1) + (k times 0 + k times 1 + k times 2) = 0 + k + 3k = 4k$
        - $G_"sn45" = (0 times 0 + 0 times 1 + k times 2) + (0 times (-1) + k times 0 + k times 1) + (k times (-2) + k times (-1) + k times 0) = 2k + k - 3k = 0$
        - $G = sqrt((4k)^2 + 0^2) = 4k$

    2. *-45° Diagonal Edge:*
      Neighborhood: $ mat(k, k, k; 0, k, k; 0, 0, k) $
      - *Prewitt ±45°:*
        - $G_"p45" = (k times (-1) + k times (-1) + k times 0) + (0 times (-1) + k times 0 + k times 1) + (0 times 0 + 0 times 1 + k times 1) = -2k + k + k = 0$
        - $G_"n45" = (k times 0 + k times 1 + k times 1) + (0 times (-1) + k times 0 + k times 1) + (0 times (-1) + 0 times (-1) + k times 0) = 2k + k + 0 = 3k$
        - $G = sqrt(0^2 + (3k)^2) = 3k$
      - *Sobel ±45°:*
        - $G_"s45" = (k times (-2) + k times (-1) + k times 0) + (0 times (-1) + k times 0 + k times 1) + (0 times 0 + 0 times 1 + k times 2) = -3k + k + 2k = 0$
        - $G_"sn45" = (k times 0 + k times 1 + k times 2) + (0 times (-1) + k times 0 + k times 1) + (0 times (-2) + 0 times (-1) + k times 0) = 3k + k + 0 = 4k$
        - $G = sqrt(0^2 + (4k)^2) = 4k$

    3. *Horizontal Edge:*
      Neighborhood: $ mat(0, 0, 0; k, k, k; k, k, k) $
      - *Prewitt ±45°:*
        - $G_"p45" = (0 times (-1) + 0 times (-1) + 0 times 0) + (k times (-1) + k times 0 + k times 1) + (k times 0 + k times 1 + k times 1) = 0 + 0 + 2k = 2k$
        - $G_"n45" = (0 times 0 + 0 times 1 + 0 times 1) + (k times (-1) + k times 0 + k times 1) + (k times (-1) + k times (-1) + k times 0) = 0 + 0 - 2k = -2k$
        - $G = sqrt((2k)^2 + (-2k)^2) = sqrt(8k^2) = 2 sqrt(2)k ≈ 2.828k$
      - *Sobel ±45°:*
        - $G_"s45" = (0 times (-2) + 0 times (-1) + 0 times 0) + (k times (-1) + k times 0 + k times 1) + (k times 0 + k times 1 + k times 2) = 0 + 0 + 3k = 3k$
        - $G_"sn45" = (0 times 0 + 0 times 1 + 0 times 2) + (k times (-1) + k times 0 + k times 1) + (k times (-2) + k times (-1) + k times 0) = 0 + 0 - 3k = -3k$
        - $G = sqrt((3k)^2 + (-3k)^2) = sqrt(18k^2) = 3 sqrt(2)k ≈ 4.243k$

  Conclusion:
  - The standard $G_x, G_y$ Sobel and Prewitt operators achieve the same magnitude response for horizontal and vertical edges but not for diagonal edges.
  - The modified $G_"p45", G_"n45"$ Sobel and Prewitt operators achieve isotropy for $+45°$ and $-45°$ edges but not for horizontal or vertical edges.

#problem(3)[
  Given a $5 times 5$ grayscale image $bI$ as follows:
  $
    bI = mat(
      50, 55, 60, 65, 70;
      55, 60, 70, 75, 80;
      60, 70, 150, 160, 90;
      65, 75, 160, 170, 100;
      70, 80, 90, 100, 110
    )
  $
  Please apply the main steps of the edge detection algorithm to extract edges from the image. The specific requirements are as follows:
  - Compute Gradients: Use the $3 times 3$ Sobel operator to compute the gradients $G_x$ (horizontal) and $G_y$ (vertical) of the image $bI$. Apply zero-padding to handle the boundaries.
  - Compute Gradient Magnitude and Direction: Based on $G_x$ and $G_y$, calculate the gradient magnitude $sqrt(G_x^2 + G_y^2)$ and the gradient direction $theta = arctan G_y\/G_x$ for each pixel.
]
#SOLUTION
Code: #codex(read("code/code.py"), lang: "python")
Run results:
```
Original Image:
[[ 50  55  60  65  70]
 [ 55  60  70  75  80]
 [ 60  70 150 160  90]
 [ 65  75 160 170 100]
 [ 70  80  90 100 110]]

Gradient in x-direction (Gx):
[[ 170.   35.   35.   30. -205.]
 [ 245.  130.  130.  -30. -375.]
 [ 275.  290.  290. -170. -565.]
 [ 300.  300.  300. -160. -600.]
 [ 235.  135.  135.  -20. -370.]]

Gradient in y-direction (Gy):
[[ 170.  245.  275.  300.  235.]
 [  35.  130.  290.  300.  135.]
 [  35.  130.  290.  300.  135.]
 [  30.  -30. -170. -160.  -20.]
 [-205. -375. -565. -600. -370.]]

Gradient Magnitude:
[[240.4163056  247.48737342 277.21832551 301.49626863 311.84932259]
 [247.48737342 183.84776311 317.80497164 301.49626863 398.55990767]
 [277.21832551 317.80497164 410.12193309 344.81879299 580.90446719]
 [301.49626863 301.49626863 344.81879299 226.27416998 600.33324079]
 [311.84932259 398.55990767 580.90446719 600.33324079 523.25901808]]

Gradient Direction (in radians):
[[ 0.78539816  1.42889927  1.4442042   1.47112767  2.28811803]
 [ 0.14189705  0.78539816  1.14937712  1.67046498  2.79603707]
 [ 0.12659213  0.42141921  0.78539816  2.08634533  2.90705202]
 [ 0.09966865 -0.09966865 -0.51554901 -2.35619449 -3.10827166]
 [-0.71732171 -1.22524075 -1.3362557  -1.60411732 -2.35619449]]
```
