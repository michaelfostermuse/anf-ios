//
//  String+Ext.swift
//  ANF Code Test
//
//  Created by Michael Muse on 3/6/22.
//

import Foundation

extension String {

    func urlString() -> String {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

        var returnString = ""
        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            let url = self[range]
            returnString = String(url)
        }
        return returnString
    }
    
    func titleText() -> String {
        let regex = try! NSRegularExpression(pattern: "<[^>]*>", options: .caseInsensitive)
        let range = NSMakeRange(0, self.count)
        let htmlWithoutInlineAttributes = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        return htmlWithoutInlineAttributes
    }
}
