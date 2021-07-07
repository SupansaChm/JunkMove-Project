//
//  FontNameGenerator.swift
//  JunkMove
//
//  Created by Supansa Ch on 1/19/21.
//

import Foundation
import SwiftUI

func getCustomFontNames() {
  // get each of the font families
  for family in UIFont.familyNames.sorted() {
    let names = UIFont.fontNames(forFamilyName: family)
    // print array of names
    print("Family: \(family) Font names: \(names)")
  }
}


