# Animation

Day32_34_proj6 (https://www.hackingwithswift.com/100/swiftui/32)


![Animation Demo](Demo/Animation.gif)


## Day32 - Day34

### Implicit Animation
`.animation(.default)`

### Custome Animvation
`.animation(
     Animation.easeout(duration: 1)
     ...
     `
### Animation Binding

for example:
 `$dataChange.animation()`
 
 SwiftUI is examining the state of our view before the binding changes, examining the target state of our views after the binding changes, then applying an animation to get from point A to point B
 
 
 ### Explicit Animation
 ` withAnimation {...}`
 
 ### Animation Gestures
 
 ### Showing and Hiding view with transitions
 
 
 ### Builduing custom transitions using viewmodifier
 `
 extension AnyTransition {
     static var pivot: AnyTransition {
         .modifier(
             active: CornerRotateModifier(amount: -90, anchor: .topLeading),
             identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
         )
     }
 }
 `
 
 
