# ChapNum

A customizable alternative to i-figured, providing chapter-based numbering for equations, figures, and other elements in Typst. Numbers are formatted as "chapter-number" (e.g., "1-1") and reset per chapter.

## Features
### Automatic Chapter-based Numbering
- Figures, tables, equations and other elements you need are numbered as "chapter-number" (e.g., Figure 1-1, Equation 2-1)
- Numbers automatically reset at each chapter
- Maintains separate counting for different types of elements


### Customizable Configuration
By specifying different counter keys, functions, and numbering patterns, you can customize numberings as you want.
```typst
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

// your document
```
### Optional Numbering
- Use `<->`(by default) to make equations unnumbered
- Configurable unnumbered label

## Example
<details>
<summary>Click to expand</summary>

![1](https://raw.githubusercontent.com/ParaN3xus/typst-snippets/refs/heads/main/chapnum/example/1.png)

</details>