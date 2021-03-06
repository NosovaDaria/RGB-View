//
//  Color.swift
//  RGB View View
//
//  Created by Дарья Носова on 26.12.2021.
//

import Foundation

struct Color {
  var redValue: Float
  var greenValue: Float
  var blueValue: Float
  
  func roundSliderValue(slider: Float) -> String {
    return String(round(slider * 100) / 100)
  }
  
}
