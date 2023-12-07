//
//  Bundle+Extension.swift
//  SSStoryStatus
//
//  Created by Krunal Patel on 01/12/23.
//

import Foundation

#if !SPM
extension Bundle {
  static var module: Bundle {
      Bundle(for: BundleFinder.self)
  }
}
#endif

private class BundleFinder {
    private init() { }
}
