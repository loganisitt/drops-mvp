//
//  NSStringExtension.swift
//  VenmoCardForm
//
//  Created by Logan Isitt on 5/24/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

extension String {
    
    func substring(start: Int, end: Int) -> String {
        return self.substringWithRange(Range<String.Index>(start: advance(self.startIndex, start), end: advance(self.startIndex, end)))
    }
    
    func reverse() -> String{
        var revStr = ""
        for c in self {
            revStr = String(c) + revStr
        }
        return revStr
    }
    
    func removeOccurencesOfString(string: String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: Range<String.Index>(start: self.startIndex, end: self.endIndex))
    }
}