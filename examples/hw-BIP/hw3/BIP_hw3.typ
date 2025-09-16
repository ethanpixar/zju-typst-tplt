#import "@local/tplt:0.2.0": *

#show: BL
#let ymd = "2025-04-8"
#let course = "Biomedical Image Processing"
#let proj-name = "Homework 3"

#show: HW.with(
  proj-name: proj-name,
  course: course,
  english: true,
  ymd: ymd,
)

#disclosure[
  Properties used is mainly referred to Gemini 2.0 Flash Thinking Experimental. It is really helpful and efficient for me to catch up with all the properties needed for this homework.
]

#problem(1)[Consider a linear, position invariant image degradation system with impulse response
  $
    h(p, q) = e^(-(p^2 + q^2))
  $
  - Suppose that the input to the system is a binary image consisting of a white vertical line of infinite small width located at $x = a$, on a black background.\
    Such an image can be modeled as $f(x, y) = delta(x - a)$.

  Assume negligible noise and use $ g(x, y) = integral.double^oo_(-oo)f(alpha, beta)h(x - alpha, y - beta)dif alpha dif beta $ to calculate the output image $g(x, y)$
]
#ANSWER

$g(x, y)$ is the convolution of $f(x, y)$ and $h(x, y)$, while $h(x, y)$ is basically a Gaussian function. The problem asks me to calculate the convolution of a delta function with a Gaussian function which intuitively gives a Gaussian function. Let me proof it:
$
  g(x, y) & = integral.double^oo_(-oo)f(alpha, beta)dot h(x - alpha, y - beta)dif alpha dif beta \
          & = integral.double^oo_(-oo)delta(alpha - a)dot exp{-((x - alpha)^2 + (y - beta)^2)}dif alpha dif beta \
$
Applying the *shifting property of the delta function*: for any $phi(x)$ and $delta(x - a)$,
$
  integral^oo_(-oo)phi(x)dot delta(x - a)dif x = phi(a)
$
Therefore,
$
  g(x, y) & = integral^oo_(-oo)exp{-((x - a)^2 + (y - beta)^2)}dif beta \
          & = exp{-(x - a)^2} dot integral^oo_(-oo) exp{- (y - beta)^2}dif beta \
$
The remaining integral is a standard Gaussian integral
$
  integral^oo_(-oo) exp{-x^2}dif x = sqrt(pi)
$
Hence,
$
  ∫ exp{-(y - β)^2} dif β = ∫ exp{-u^2} dif u = sqrt(π) quad ("where" u = y - β)
$
Thus, the result is
$
  g(x, y) = sqrt(pi) dot exp{-(x - a)^2}
$
This indicates a Gaussian function of $x$ only, with the result being constant with respect to $y$.

#problem(2)[
  Assume that we have noisy image $g_i (x, y)$ from the image $f(x, y)$, i.e.
  $
    g_i (x, y) = f(x, y) + eta_i (x, y)
  $
  where the noise $eta_i (x, y)$ is zero-mean and at all point-pairs $(x, y)$ are uncorrelated. Then reduce noise by taking the mean of all the noisy images:
  $
    dash(g)(x,y) = 1 / M ∑_(i = 1)^M g_i (x, y)
  $
  Prove that:
  $
    E{dash(g)(x,y)} = f(x,y)
  $
  and
  $
    sigma^2_(dash(g)(x,y)) = 1 / M sigma^2_(eta(x, y))
  $
  where $sigma^2_(eta(x, y))$ is the variance of $eta$ and $sigma^2_(dash(g)(x,y))$ is the variance of $dash(g)(x,y)$.
]
#PROOF
$
  E{dash(g)(x,y)} & = E{1 / M ∑_(i = 1)^M g_i (x, y)} \
                  & = 1 / M ∑_(i = 1)^M E{g_i (x, y)} \
                  & = 1 / M ∑_(i = 1)^M E{f(x, y) + eta_i (x, y)} \
                  & = 1 / M ∑_(i = 1)^M E{f(x, y)} + 1 / M ∑_(i = 1)^M E{eta_i (x, y)} \
$
Since $eta_i (x, y)$ is zero-mean, $E{eta_i (x, y)} = 0$. Therefore,
$
  E{dash(g)(x,y)} = 1 / M ∑_(i = 1)^M E{f(x, y)} = 1 / M ∑_(i = 1)^M f(x, y) = f(x, y)
$
#done

$
  sigma^2_(dash(g)(x,y)) & := E{(dash(g)(x,y) - E{dash(g)(x,y)})^2} = E{(dash(g)(x,y) - f(x,y))^2} \
                         & = E{(1 / M ∑_(i = 1)^M g_i (x, y) - f(x,y))^2} \
                         & = E{(1 / M ∑_(i = 1)^M (f(x, y) + eta_i (x, y) - f(x,y)))^2} \
                         & = E{(1 / M sum_(i = 1)^M eta_i (x, y))^2} \
                         & = E{1 / M ∑_(i=1)^M eta_i(x,y) dot 1 / M ∑_(j=1)^M eta_j(x,y) } \
                         & = E{ 1 / M^2 ∑_(i=1)^M ∑_(j=1)^M eta_i(x,y) dot eta_j(x,y) } \
                         & = 1 / M^2 ∑_(i=1)^M ∑_(j=1)^M E{ eta_i(x,y) dot eta_j(x,y) } \
$
Because the noise $eta_i(x,y)$ are uncorrelated at all point-pairs $(x,y)$,
$
  E{ eta_i(x,y) dot eta_j(x,y) } = cases(
    0 quad i != j,
    E{ eta_i(x,y)^2 } quad i = j
  )
$
Thus,
$
  sigma^2_(dash(g)(x,y)) = 1 / M^2 ∑_(i=1)^M E{ eta^2_i(x,y)} = 1 / M^2 M dot E{ eta^2(x,y)} = 1 / M E{ eta^2(x,y)}
$
Consider that the variance of a random variable $x$ is given by:
$
  "Var"{x} = E{(x - E{x})^2} = E{x^2} - E^2{x}
$
Therefore, $sigma^2_(eta(x, y))$ is equivalent to
$
  sigma^2_(eta(x, y)) = E{eta^2 (x, y)} - E^2{eta (x, y)} = E{eta^2 (x, y)}
$
Hence,
$
  sigma^2_(dash(g)(x,y)) = 1 / M sigma^2_(eta(x, y))
$
#done




#problem(3)[
  Suppose an image's degradation function is the convolution of original image and $ h(x, y) = (x^2 + y^2 - 2 sigma^2) / sigma^4 exp{-(x^2 + y^2) / (2 sigma^2)} $ and here assume $x, y$ are continuous.
  1. Prove that the degradation in frequency filed is
    $
      H(u, v) = -8 pi^3 sigma^2 (u^2 + v^2)exp{-2 pi^2 sigma^2 (u^2 + v^2)}
    $
  2. Assume the power specturm ratio of noise and undegraded image $S_eta\/S_f$ is the constant parameter $K$, give the transfer function expression of Wiener filter for this image.
]
1. #PROOF Consider the Properties of Fourier Transforms:
  + Differentiation in the spatial domain corresponds to multiplication by a frequency term in the frequency domain:
    $
      "FT"{ (∂²f(x,y)) / (∂x²) + (∂²f(x,y)) / (∂y²) } = -4π²(u² + v²) dot F(u,v)
    $
  + Fourier Transform of a Gaussian function is also a Gaussian function. Specifically:
    $
      "FT"{ exp{-(x² + y²) / (2σ²)} / (2π σ²)} = exp{-2π²σ²(u² + v²)}
    $
*Notice* that $h(x, y)$ is related to the Laplacian of a Gaussian function:
$
  "Lo"G(x, y) = ∇²G(x, y) = ((∂²) / (∂x²) + (∂²) / (∂y²)) G(x, y) = ((∂²) / (∂x²) + (∂²) / (∂y²)) dot exp{-(x² + y²) / (2σ²)} / (2π σ²)
$
Calculate $∇²G(x, y)$:
$
    (∂G) / (∂x) & = -x / (2π σ^4) exp{-(x² + y²) / (2σ²)} \
  (∂²G) / (∂x²) & = (x^2-σ^2) / (2π σ^6) exp{-(x² + y²) / (2σ²)} \
$
Applying symmetry:
$
  ∇²G & = (x^2+y^2-2σ^2) / (2π σ^6) exp{-(x² + y²) / (2σ²)} \
$
Hence,
$
  h(x, y) = 2 π σ² ∇²G(x, y)
$
Applying the properties:
$
  H(u, v) & = "FT"{ h(x, y) } = "FT"{ 2 π σ² ∇²G(x,y)} \
          & = 2 π σ² "FT"{∇²G(x,y)} \
          & = 2 π σ² "FT"{(∂²G) / (∂x²) + (∂²G) / (∂y²)} \
          & = 2 π σ² (-4π²(u² + v²)) dot "FT"{G(x,y)} \
          & = -8π^3σ²(u² + v²) dot "FT"{ exp(-(x² + y²) / (2σ²)) / (2π σ²) } \
          & = -8π^3σ²(u² + v²) dot exp{-2π²σ²(u² + v²)} \
$ #done
2.
  $
    W(u, v) = 1 / H(u,v)dot abs(H(u,v))^2 / (abs(H(u,v))^2+ S_eta\/S_f)
  $
Because $S_eta\/S_f = K$, and $H(u,v)$ is real,
$
  W(u, v) = H(u,v) / (H^2(u,v)+ K) = -(8π^3σ²(u² + v²) dot exp{-2π²σ²(u² + v²)}) / (64π^6σ^4(u² + v²)^2 dot exp{-4π²σ²(u² + v²)} + K)
$
