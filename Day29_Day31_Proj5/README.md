# Word Scramble

https://www.hackingwithswift.com/100/swiftui/29

![Word Scramble Demo](Demo/wordScramble.gif)


## Day29-Day31

### Loading Resource from Bundle

`
    if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
        if let fileContents = try? String(contentsOf: fileURL) {
        }
`

### String
#### `components(separatedBy:)`
To covert "a b c" -> "["a", "b", "c"]"

#### Trim
`let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)`

#### Check Misspelled string
`let checker = UITextChecker()`

`let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")`

=> 
In this instance, if the Objective-C range comes back as empty – i.e., if there was no spelling mistake because the string was spelled correctly – then we get back the special value `NSNotFound`.


#### auto capital
`.autocapitalization()`


### OnAppear


