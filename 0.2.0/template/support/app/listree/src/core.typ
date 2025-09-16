
#let collect-tree(body) = {
  if not body.has("children") {
    return (body: body)
  }
  let title = []
  let children = for item in body.children {
    if item.func() == std.list.item {
      ((kind: "list") + collect-tree(item.body),)
    } else if item.func() == std.enum.item {
      let number = item.at("number", default: auto)
      ((kind: "enum", number: number) + collect-tree(item.body),)
    } else {
      title += item
    }
  }
  (title: title, children: children)
}

#let flatten-tree(tree, numbering: true) = {
  let flatten-tree-impl(tree, numbers, index) = {
    if "children" not in tree {
      return ((numbers: numbers, index: index, body: tree.body),)
    }
    ((numbers: numbers, index: index, body: tree.title),)
    let i = 0
    if tree.children != none {
      for ch in tree.children {
        if "number" in ch and ch.number != auto {
          i = ch.number
          index = ch.number
        } else {
          i += 1
          index += 1
        }
        let sub = flatten-tree-impl(ch, if numbering { numbers + (i,) } else { none }, index)
        sub
        if sub.len() > 0 {
          index = sub.last().index
        }
      }
    }
  }
  flatten-tree-impl(tree, if numbering { () } else { none }, 0)
}


#let ensure-tree(body) = {
  if type(body) == dictionary {
    body
  } else {
    collect-tree(body)
  }
}

#let ensure-list(body, numbering: false) = {
  if type(body) == dictionary {
    flatten-tree(body)
  } else if type(body) == array {
    body
  } else {
    flatten-tree(collect-tree(body), numbering: numbering)
  }
}
