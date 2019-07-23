# Bookbinder
A Swift ePub parser framework for iOS.

## Requirements
* Swift 5.0+
* iOS 10.0+
* ARC

## Usage
1. Create bookbinder instance with default configuration
   ```
   // default configuration uses `NSTemporaryDirectory` as root directory to unzip ePub file
   let bookbinder = Bookbinder()
   ```
1. Create bookbinder instance with custom configuration
   ```
   let configuration = BookbinderConfiguration(rootURL: customRootURL)
   let bookbinder = Bookbinder(configuration: configuration)
   ```
1. Parse ePub file by one line
   ```
   let ebook = bookbinder.bindBook(at: ePubFileURL)
   ```
1. Ready made interface of ebook
   ```
   // cover image
   let coverImageURLs = ebook.coverImageURLs
   // toc
   let tocURL = ebook.tocURL
   // ncx
   let ncx = ebook.ncx
   // primary spine items
   let pages = ebook.pages
   // others
   let mainAuthor = ebook.opf?.package?.metadata?.creators.first
   ...
   ```
1. Subclass EPUBBook
   ```
   class CustomBook: EPUBBook {
      lazy var firstAuthors: [String]? = {
         return opf.package?.metadata?.creators
      }()
      
      lazy var secondAuthors: [String]? = {
        return opf.package?.metadata?.contributors
      }()
      
      ...
   }
   
   let bookbinder = Bookbinder()
   let ebook = bookbinder.bindBook(at: url, to: CustomBook.self)
   ```
1. Playground in `BookbinderTests`
   ```
   // study `Bookbinder` from unit test
   let ebook = EPUBBook(identifier: "Alice's_Adventures_in_Wonderland", contentsOf: url)
   expect(ebook).notTo(beNil())
   expect(ebook?.identifier).to(equal("Alice's_Adventures_in_Wonderland"))
   expect(ebook?.baseURL).to(equal(url))
   expect(ebook?.resourceBaseURL).to(equal(url.appendingPathComponent("epub")))
   expect(ebook?.opf).notTo(beNil())
   expect(ebook?.uniqueID).to(equal("url:https://standardebooks.org/ebooks/lewis-carroll/alices-adventures-in-wonderland"))
   expect(ebook?.releaseID).to(equal("\(ebook?.uniqueID ?? "")@2017-03-09T17:21:15Z"))
   expect(ebook?.publicationDate).to(equal(ISO8601DateFormatter().date(from: "2015-05-12T00:01:00Z")))
   ...
   ```

## Installation
### [Cathage](https://github.com/Carthage/Carthage)
Please add it to your `Cartfile`:
```
github "stonezhl/Bookbinder" ~> 1.0.0
```
### [CocoaPods](https://cocoapods.org/)
Please add it to your `Podfile`:
```
use_frameworks!
pod 'Bookbinder', '~> 1.0.0'
```

## License
Bookbinder is released under the MIT license. See `LICENSE` for details.
