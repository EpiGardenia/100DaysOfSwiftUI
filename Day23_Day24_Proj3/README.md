
## Day23 - Day 24 View and Modifiers

#### Reason for Using Struct for Views
1. Simpler and faster than class
2. Neat and do not be affected by parent or children views
3. More isolated, do not contain 100 methods.

### Order of Modifier matters
The modifier process view from top to down, for example, view1 will have bigger red square if original size of view1 equals to view2

` view1
    .padding()
    .background(Color.red)
    
  view2
      .background(Color.red)
      .padding()

`

###  : some View

It's ONE type of view, which developer doesn't need to specify but compiler knows.
Each modifier might alter the type of view, by "some view", developer no need to modify each time.


### Modifiers
#### Conditional modifiers (  condition ? A : B )
#### Environment modifiers ( t.e.x, font, the child modifier overwirtes the parent modifier)
#### Regulare modifiers ( the child modifiers added on parent modifiers, not replace)


### View as property
`let motto1 = Text("Draco dormiens")` or 
computed property `var motto1: some View { Text("Draco dormiens") }`



### Custom Containers
`
    struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                    HStack {
                        ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}
`
Example of use:

`
    GridStack(rows: 4, columns: 4) { row, col in
        HStack {
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
`

Above will show 16 labels in 4*4 






### @ViewBuilder
Allows us to send in several views and have it form an implicit stack for us.

Thus we can remove `HStack` in previous example if we add below inside `GridStack`

`
init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
    self.rows = rows
    self.columns = columns
    self.content = content
}
`
