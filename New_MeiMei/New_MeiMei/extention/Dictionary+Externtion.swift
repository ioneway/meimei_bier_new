//
//  Dictionary+Externtion.swift
//  newToken_swift
//
//  Created by 王伟 on 2019/1/4.
//  Copyright © 2019 王伟. All rights reserved.
//

import Foundation

func + <K,V> ( left: Dictionary<K,V>, right: Dictionary<K,V>?)  -> Dictionary<K,V>{
    var result = Dictionary<K, V>()
    left.forEach { key, value in
        result.updateValue(value, forKey: key)
    }
    right?.forEach { key, value in
        result.updateValue(value, forKey: key)
    }
    return result
}


func += <K,V> ( left: inout Dictionary<K,V>, right: Dictionary<K,V>?) {
    guard let right = right else { return }
    right.forEach { key, value in
        left.updateValue(value, forKey: key)
    }
}

extension Dictionary {
    
    mutating func append(dict: Dictionary) {
        dict.forEach { (key, value) in
            self.updateValue(value, forKey: key)
        }
    }
}


