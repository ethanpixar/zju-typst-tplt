#import "@local/tplt:0.2.0": *

#show: BL.with(is-table-cell-stroked: true)

#let ymd = "2025-06-01"
#let course = "Biomedical Image Processing"
#let proj-name = "Homework 6"

#show: HW.with(
  proj-name: proj-name,
  course: course,
  english: true,
  ymd: ymd,
)

#disclosure[
  Gemini 2.5 Pro and Cursor are used to help with this homework.
]

#problem(1)[
  First order feature
  + Given the image $bI$, calculate it's the energy, mean, range and 2nd, 3rd moment of mean.

  + Write the histogram of the image and calculate the uniformity and entropy.
  $
    bI = mat(
      3, 1, 0, 0, 2;
      1, 0, 1, 1, 0;
      0, 2, 0, 3, 1;
      1, 2, 1, 0, 0;
      0, 0, 2, 3, 1;
    )
  $
]
#SOLUTION
+ + Energy:
    $
      E = sum_i sum_j I^2(i,j) = 3^2 + 1 + 2^2 + 1 + 1 + 1 + 2^2 + 3^2 + 1 + 1 + 2^2 + 1 + 2^2 + 3^2 + 1 = 51
    $
  + Mean:
    $
      mu = (sum_i sum_j I(i,j) ) / N = 25 / 25 = 1
    $
  + Range:
    $
      R = max(I) - min(I) = 3 - 0 = 3
    $
  + 2nd Moment of Mean:
    $
      mu_2 &= (sum_i sum_j (I(i,j) - mu)^2) / N\
      &=( 3 times (3-1)^2 + 4 times (2-1)^2 + 8 times (1-1)^2 + 10 times (0-1)^2 ) / 25 \
      &= 26 / 25 = 1.04
    $
  + 3rd Moment of Mean:
    $
      mu_3 &= (sum_i sum_j (I(i,j) - mu)^3) / N\
      &=( 3 times (3-1)^3 + 4 times (2-1)^3 + 8 times (1-1)^3 + 10 times (0-1)^3 ) / 25 \
      &= -18 / 25 = -0.72
    $
+ Using a python code:
  #codex(read("p1.py"), lang: "python")
  which gives:
  #figure(image("f1.png"), caption: [Histogram of the image $bI$])
  and prints #codex(read("terminal.txt")) in the terminal.

#problem(2)[Co-occurrence matrix\
  Find the co-occurrence matrix of a matrix pattern in the following cases:
  1. The position operator $Q$ is defined as "one pixel to the right"
  2. The position operator $Q$ is defined as "two pixels to the right"
  3. For GLCM of (1) and (2), calculate contrast and homogeneity.

  #grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    $
      "image" = mat(
        0, 1, 2, 1, 0;
        1, 2, 1, 2, 1;
        0, 1, 2, 1, 0;
        1, 2, 1, 2, 1;
        0, 1, 2, 1, 0;
      )
    $,
    [#table(
        columns: 4,
        [], table.vline(), [0], [1], [2],
        [0], [], [], [],
        [1], [], [], [],
        [2], [], [], [],
        table.hline()
      )
      GLCM Pattern
    ],
  )
]
#SOLUTION
+ #table(
    columns: 4,
    [], table.vline(), [0], [1], [2],
    [0], [--], [3], [--],
    [1], [3], [--], [8],
    [2], [--], [8], [--],
    table.hline()
  )

+ #table(
    columns: 4,
    [], table.vline(), [0], [1], [2],
    [0], [--], [--], [3],
    [1], [--], [7], [--],
    [2], [3], [--], [2],
    table.hline()
  )
+ + For the GLCM of (1):
    + Contrast:
      $
        C = sum_(i,j) (i-j)^2 times P(i,j) = 3 / 22 times 2 + 8 / 22 times 2 = 1
      $
    + Homogeneity:
      $
        H = sum_(i,j) frac(P(i,j), 1 + (i-j)^2) = 1 / 2 times 3 / 22 times 2 + 1 / 2 times 8 / 22 times 2 = 0.5
      $
  + For the GLCM of (2):
    + Contrast:
      $
        C = sum_(i,j) (i-j)^2 times P(i,j) = 4 times 3 / 15 times 2 = 1.6
      $
    + Homogeneity:
      $
        H = sum_(i,j) frac(P(i,j), 1 + (i-j)^2) = 1 / 5 times 3 / 15 times 2 + 7 / 15 + 2 / 15 = 0.68
      $


#problem(3)[CNN\
  Calculate the following results in sequence, showing the main calculation steps:
  + Convolution Output (C): Calculate the result after convolving the input matrix $bI$ with the kernel $bK$
  + ReLU Activation Output (R): Apply the ReLU activation function to the convolution output $bC$
  + Max Pooling Output (P): Apply the max pooling operation to the ReLU activation output $bR$
  #grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    $
      "Input:" bI = mat(
        1, 0, 2, 1, 3;
        0, 1, 1, 2, 0;
        2, 0, 3, 0, 1;
        1, 1, 0, 2, 1;
        3, 2, 1, 0, 0;
      )
    $,
    $
      "Kernel:" bK = mat(
        1, 0, -1;
        1, 0, -1;
        1, 0, -1
      )
    $,
  )
  Convolution Layer Parameters:
  - Stride: 1
  - Padding: 0
  Activation Function:
  - ReLU (Rectified Linear Unit): $f(x)=max(0, x)$
  Max Pooling Layer Parameters:
  - Window Size: 2x2
  - Stride: 1
]
#SOLUTION
+ + Output_size = `(Input_size - Kernel_size + 2 * Padding)/Stride + 1 = 3`
  + Calculation:
    + C[0,0]:
      ```
      1*1 + 0*0 + 2*(-1)  =  1 + 0 - 2 = -1
      0*1 + 1*0 + 1*(-1)  =  0 + 0 - 1 = -1
      2*1 + 0*0 + 3*(-1)  =  2 + 0 - 3 = -1
      Sum = -1 + (-1) + (-1) = -3
      ```
    + C[0,1]:
      ```
      0*1 + 2*0 + 1*(-1)  =  0 + 0 - 1 = -1
      1*1 + 1*0 + 2*(-1)  =  1 + 0 - 2 = -1
      0*1 + 3*0 + 0*(-1)  =  0 + 0 - 0 =  0
      Sum = -1 + (-1) + 0 = -2
      ```
    + C[0,2]:
      ```
      2*1 + 1*0 + 3*(-1)  =  2 + 0 - 3 = -1
      1*1 + 2*0 + 0*(-1)  =  1 + 0 - 0 =  1
      3*1 + 0*0 + 1*(-1)  =  3 + 0 - 1 =  2
      Sum = -1 + 1 + 2 = 2
      ```
    + C[1,0]:
      ```
      0*1 + 1*0 + 1*(-1)  =  0 + 0 - 1 = -1
      2*1 + 0*0 + 3*(-1)  =  2 + 0 - 3 = -1
      1*1 + 1*0 + 0*(-1)  =  1 + 0 - 0 =  1
      Sum = -1 + (-1) + 1 = -1
      ```
    + C[1,1]:
      ```
      1*1 + 1*0 + 2*(-1)  =  1 + 0 - 2 = -1
      0*1 + 3*0 + 0*(-1)  =  0 + 0 - 0 =  0
      1*1 + 0*0 + 2*(-1)  =  1 + 0 - 2 = -1
      Sum = -1 + 0 + (-1) = -2
      ```
    ...
  + Output: $ bC = mat(
      -3, -2, 2;
      -1, -2, 2;
      2, 1, 2;
    ) $
+ Apply ReLU:
  $
    bR = max(0, bC) = mat(
      0, 0, 2;
      0, 0, 2;
      2, 1, 2;
    )
  $
+ Max Pooling:
  + Window Size: `(Input_size - Window_size) / Stride) + 1 = 1`
  + Calculation:
    + P[0,0]:
      ```
      0, 0
      0, 0
      max(0, 0, 0, 0) = 0
      ```
    + P[0,1]:
      ```
      0, 2
      0, 2
      max(0, 2, 0, 2) = 2
      ```
    + P[1,0]:
      ```
      0, 0
      2, 1
      max(2, 1, 0, 2) = 2
      ```
    + P[1,1]:
      ```
      0, 2
      1, 2
      max(1, 2, 2, 2) = 2
      ```
  + Output: $ bP = mat(
      0, 2;
      2, 2;
    ) $
