#import "../src/lib.typ" as listree
#import listree: collect-tree, flatten-tree, presets
#import presets: *

#let alg = flatten-tree(
  collect-tree[
    + First line
    + Second line
    5. $a <- 1$
    + $b <- 2$
    + *if* $a = 3$ *then*
      10. $b <- a$
        + Haha
      + xxx
    + print $a$
      20.
      + aaa
        + bbb
    + ccc
  ],
)
#algorithm(alg)

#let example = [
  网络连接方式
  - 有线
    - 网线
    - 光纤
  - 无线
    + Wi-Fi
    + 4G, 5G
]

#mind-map(example)
#icicle-map(example)
#simple-tree-map(example)
#algorithm(example)

#simple-tree-map[
  title
  - 1
  - 2
    3
    - 2.1
      - 2.1.1
      - 2.1.2
    - 2.2
  - 3
]
