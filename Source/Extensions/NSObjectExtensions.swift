//
//  NSObjectExtensions.swift
//  CommonFiles
//
//  Created by Tiewhan Smith on 2020/04/24.
//

import Foundation

extension NSObject {
  
  var className: String {
    return String(describing: type(of: self)).components(separatedBy: ".").last!
  }
  
  class var className: String {
    return String(describing: self).components(separatedBy: ".").last!
  }
  
}
