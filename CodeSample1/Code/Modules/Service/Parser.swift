//
//  Parser.swift
//  CodeSample1
//
//  Created by Artem Shmatkov on 14.05.2020.
//

import Foundation

typealias ParseCompletion = (_ result: [DiskData], _ error: Error?) -> Void

struct DiskData {
    var title: String
    var artist: String
    var country: String
    var company: String
    var price: Double
    var year: Int
}

class Parser: NSObject, XMLParserDelegate {
    var disks: [DiskData] = []
    var elementName: String = ""
    
    var title = ""
    var artist = ""
    var country = ""
    var company = ""
    var price: Double = 0.0
    var year = 1990
    
    var completion: ParseCompletion?
    
    deinit {
        completion = nil
        disks.removeAll()
    }
    
    func parse(data: Data, completion: @escaping ParseCompletion) {
        self.completion = completion
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }

    // MARK: XMLParserDelegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "CD" {
            title = ""
            artist = ""
            country = ""
            company = ""
            price = 0.0
            year = 0
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "CD" {
            let disk = DiskData(title: title, artist: artist, country: country, company: company, price: price, year: year)
            disks.append(disk)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "TITLE" {
                title += data
            } else if self.elementName == "ARTIST" {
                artist += data
            } else if self.elementName == "COUNTRY" {
                country += data
            } else if self.elementName == "COMPANY" {
                company += data
            } else if self.elementName == "PRICE" {
                price += Double(data) ?? 0.0
            } else if self.elementName == "YEAR" {
                year += Int(data) ?? 0
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.completion?(disks, nil)
    }
}
