//
//  XMLParser.swift
//  RSS2
//
//  Created by A.S.Sahasranamam on 2/21/18.
//  Copyright © 2018 A.S.Sahasranamam. All rights reserved.
//

// RSS/XML PARSER CLASS


import Foundation

struct RSSItem{
    
    var Title:String
    var description:String
    var pubDate: String
    var enclosure: String
}

class FeedParser: NSObject, XMLParserDelegate{
    private var rssItems: [RSSItem] = []
    private var currentElement : String = ""
    private var currentTitle : String = ""{
        didSet{
            currentTitle=currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }

    private var currentDescription: String = ""{
        didSet{
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentpubDate: String = "" {
        didSet{
            currentpubDate = currentpubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
    }
    private var currentEnclosure : String = ""{
        didSet{
            currentEnclosure=currentEnclosure.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var parserCompletionHandler: (([RSSItem])-> Void)?
    
    func parseFeed(url:String, completionHandler: (([RSSItem])-> Void)?)
    {
        self.parserCompletionHandler=completionHandler
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with : request){(data,response,error) in
            guard let data = data else{
                if let error = error{
                    print(error.localizedDescription)
                }
            
            return
            }
            let parser = XMLParser(data: data)
            parser.delegate=self
            parser.parse()
        }
        task.resume()
    }
    //MARK - XMLPaRSER DELEGATE
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement=elementName
        
        switch currentElement{
       
        case "enclosure":
            //print("hurray");
            currentEnclosure=(attributeDict["url"]!)
        default:break
        }
        if currentElement == "item"{
         
            currentTitle=""
            currentDescription=""
            currentpubDate=""
                    }
        
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String ) {
       // print("HELLO")
        switch currentElement {
        case "title":currentTitle += string
        case "description":currentDescription += string
        case "pubDate":currentpubDate += string
        case "enclosure":currentEnclosure += string
        default: break
        }
    }
    func parser(_ parser : XMLParser, didEndElement elementName : String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(Title: currentTitle, description: currentDescription, pubDate: currentpubDate, enclosure: currentEnclosure)
            self.rssItems.append(rssItem)
           // print(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
