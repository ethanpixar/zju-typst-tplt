// 3-column table
#let tri-tab(columns, header, data, caption: none) = {
  let row-count = calc.ceil(data.len() / 3)
  let data1 = data.slice(0, row-count)
  let data2 = data.slice(row-count, 2 * row-count)
  let data3 = data.slice(2 * row-count, data.len())

  let extra-line-count = data1.len() - data3.len()
  for i in range(0, extra-line-count * columns) {
    data3 += ([--],)
  }
  figure(
    caption: caption,
    grid(
      columns: 3,
      column-gutter: 30pt,
      align: center,
      table(
        columns: columns,
        table.header(..header.map(num => [#num])),
        ..data1.flatten().map(num => [#num]),
        table.hline(),
      ),
      table(
        columns: columns,
        table.header(..header.map(num => [#num])),
        ..data2.flatten().map(num => [#num]),
        table.hline(),
      ),
      table(
        columns: columns,
        table.header(..header.map(num => [#num])),
        ..data3.flatten().map(num => [#num]),
        table.hline(),
      ),
    ),
  )
}


// 3-column table with header included in csv
#let tri-tab0(columns, data, caption: none) = {
  let row-count = calc.ceil((data.len() - 1) / 3)
  let data1 = data.slice(1, row-count + 1)
  let data2 = data.slice(row-count + 1, 2 * row-count + 1)
  let data3 = data.slice(2 * row-count + 1, data.len())

  let extra-line-count = data1.len() - data3.len()
  for i in range(0, extra-line-count * columns) {
    data3 += ([--],)
  }
  figure(
    caption: caption,
    grid(
      columns: 3,
      column-gutter: 30pt,
      align: center,
      table(
        columns: columns,
        table.header(..data.flatten().slice(0, columns).map(eval.with(mode: "markup"))),
        ..data1.flatten().map(num => [#num]),
        table.hline(),
      ),
      table(
        columns: columns,
        table.header(..data.flatten().slice(0, columns).map(eval.with(mode: "markup"))),
        ..data2.flatten().map(num => [#num]),
        table.hline(),
      ),
      table(
        columns: columns,
        table.header(..data.flatten().slice(0, columns).map(eval.with(mode: "markup"))),
        ..data3.flatten().map(num => [#num]),
        table.hline(),
      ),
    ),
  )
}




// 2-column table
#let db-tab(columns, header, data, caption: none) = {
  let row-count = calc.ceil(data.len() / 2)
  let data1 = data.slice(0, row-count)
  let data2 = data.slice(row-count, data.len())

  if data1.len() - data2.len() != 0 {
    for i in range(0, columns) {
      data2 += ([--],)
    }
  }
  figure(
    caption: caption,
    grid(
      columns: 2,
      column-gutter: 30pt,
      align: center,
      table(
        columns: columns,
        table.header(..header.map(eval.with(mode: "markup"))),
        ..data1.flatten().map(num => [#num]),
        table.hline(),
      ),
      table(
        columns: columns,
        table.header(..header.map(eval.with(mode: "markup"))),
        ..data2.flatten().map(num => [#num]),
        table.hline(),
      ),
    ),
  )
}


// 2-column table with header included in csv
#let db-tab0(columns, data, caption: none) = {
  let row-count = calc.ceil((data.len() - 1) / 2)
  let data1 = data.slice(1, row-count + 1)
  let data2 = data.slice(row-count + 1, data.len())

  if data1.len() - data2.len() != 0 {
    for i in range(0, columns) {
      data2 += ([--],)
    }
  }
  figure(
    caption: caption,
    grid(
      columns: 2,
      column-gutter: 30pt,
      align: center,
      table(
        columns: columns,
        table.header(..data.flatten().slice(0, columns).map(eval.with(mode: "markup"))),
        ..data1.flatten().map(eval.with(mode: "markup")),
        table.hline(),
      ),
      table(
        columns: columns,
        table.header(..data.flatten().slice(0, columns).map(eval.with(mode: "markup"))),
        ..data2.flatten().map(num => [#num]),
        table.hline(),
      ),
    ),
  )
}





// 1-column table
#let un-tab(columns, header, data, caption: none) = {
  figure(
    caption: caption,
    table(
      columns: columns,
      table.header(..header.map(eval.with(mode: "markup"))),
      ..data.flatten().map(num => [#num]),
      table.hline(),
    ),
  )
}
// 1-column table with header included in csv
#let un-tab0(columns, data, caption: none) = {
  figure(
    caption: caption,
    table(
      columns: columns,
      table.header(..data.flatten().slice(0, columns).map(eval.with(mode: "markup"))),
      ..data.flatten().slice(columns).map(num => [#num]),
      table.hline(),
    ),
  )
}

