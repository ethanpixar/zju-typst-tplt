#import "core.typ": collect-tree, flatten-tree, ensure-list


#let mind-map(body) = {
  let tree = if type(body) == dictionary {
    body
  } else {
    collect-tree(body)
  }

  let create-mmp(root) = {
    if "children" not in root {
      return root.body
    }
    let items = root.children.map(create-mmp)
    let list = std.list(..items, marker: none, body-indent: 0pt)
    context {
      let size = measure(list)
      grid(
        columns: 3,
        align: horizon,
        root.title, math.cases(v(size.height)), list,
      )
    }
  }
  create-mmp(tree)
}


#let icicle-map(body, inset: 0.5em) = {
  let tree = if type(body) == dictionary {
    body
  } else {
    collect-tree(body)
  }

  let create-mmp(root) = {
    if "children" not in root {
      return block(stroke: 1pt, inset: inset, rotate(90deg, root.body, reflow: true))
    }
    let items = root.children.map(create-mmp)
    let items-block = stack(dir: ltr, ..items)
    context {
      let size = measure(items-block)
      let title-block = block(
        width: size.width,
        inset: inset,
        stroke: 1pt,
        align(center, rotate(90deg, root.title, reflow: true)),
      )
      stack(dir: ttb, title-block, items-block)
    }
  }
  create-mmp(tree)
}


#let simple-tree-map(body) = {
  let tree = if type(body) == dictionary {
    body
  } else {
    collect-tree(body)
  }

  let create-mmp(root) = {
    if "children" not in root {
      return block(inset: 0.5em, root.body)
    }
    let items = root.children.map(create-mmp)
    table(
      columns: 2,
      stroke: 1pt + black,
      align: left,
      table.cell(rowspan: items.len(), align: horizon + left, root.title),
      ..for item in items {
        (table.cell(item, inset: 0pt, align: horizon + left),)
      }
    )
  }
  create-mmp(tree)
}


#let algorithm(body, indent: 2em, line-gap: 0.6em, label-gap: 0.5em) = {
  let list = if type(body) == dictionary {
    flatten-tree(body)
  } else if type(body) == array {
    body
  } else {
    flatten-tree(collect-tree(body), numbering: true)
  }

  let i = 1
  let items = for item in list.slice(1) {
    ([#item.index], [#h(indent * (item.numbers.len() - 1))#item.body])
    i += 1
  }

  grid(columns: 2, row-gutter: line-gap, column-gutter: label-gap, align: (right, left), ..items)
}
