# SwiftXML
xml in Swift

## Description

- Use libxml2
- Based on https://github.com/wemap/Reindeer


## Installation

### Swift Package Manager

```ruby
dependencies: [
    .package(url: "https://github.com/eldhoselomy/SwiftXML")
],
```

## Usage

### XML, SVG, RSS

```xml
<html>
<body>

<h1>My first SVG</h1>

<svg width="100" height="100">
  <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" />
</svg>

</body>
</html
```

```swift
let data = Utils.load(fileName: "test4", ext: "svg")
let document = try! Document(data: data)

document.rootElement.name
document.rootElement.children()

document.rootElement.elements(XPath: "//svg").first?.attributes["width"]
document.rootElement.elements(XPath: "//circle").first?.attributes["stroke"]
```

### HTML

```html
<!DOCTYPE html>
<html>
  <head>
    <style>
      h1 {
        color: blue;
        font-family: verdana;
        font-size: 300%;

      }
    p  {
      color: red;
      font-family: courier;
      font-size: 160%;
    }
    </style>
  </head>
  <body>

    <h1>This is a heading</h1>
    <p>This is a paragraph.</p>
    <a href="http://www.w3schools.com">Visit W3Schools</a>
    
  </body>
</html>
```

```swift
let data = Utils.load(fileName: "test3", ext: "html")
let document = try? Document(data: data, kind: .html)

let body = document.rootElement.child(index: 1)
body?.elements(XPath: "//p").first?.content
```

### Query

- Get element info

```swift
let element = document.rootElement.child(index: 0)

element.name
element.ns
element.line
element.attributes
element.parent
element.nextSibling
element.previousSibling
```

- Get child elements

```swift
element.children { child, index in
  return child.name == "a"
}

element.children(name: "item")
element.children(indexes: [0, 2, 4])
```

- XPath

```swift
let body = document.rootElement.firstChild(name: "body")
body?.elements(XPath: "//a").first?.attributes["href"]
body?.elements(XPath: "//div") { element in
  return element.attributes["width"] == "100"
}
```

## Author

Eldhose Lomy, eldhoselomy143@gmail.com

