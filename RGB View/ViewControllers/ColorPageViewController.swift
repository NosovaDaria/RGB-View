//
//  ColorPageViewController.swift
//  RGB View View
//
//  Created by Дарья Носова on 26.12.2021.
//

import UIKit

protocol RGBViewControllerDelegate {
  func setBackgroundColour(redValue: Float, greenValue: Float, blueValue: Float)
}

class ColorPageViewController: UIViewController {
  
  // MARK: - Public Properties
  var redValueBackground = CGFloat(1.0)
  var greenValueBackground = CGFloat(1.0)
  var blueValueBackground = CGFloat(1.0)
  
  // MARK: - Override Methods
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let rgbVC = segue.destination as? RGBViewController else { return }
    
    rgbVC.delegate = self
    rgbVC.backgroundColor = CIColor(color: view.backgroundColor!)
  }
}
  // MARK: - Private Methods
extension ColorPageViewController: RGBViewControllerDelegate {
  func setBackgroundColour(redValue: Float, greenValue: Float, blueValue: Float) {
    redValueBackground = CGFloat(redValue)
    greenValueBackground = CGFloat(greenValue)
    blueValueBackground = CGFloat(blueValue)
    view.backgroundColor = UIColor (
      red: redValueBackground, green: greenValueBackground, blue: blueValueBackground, alpha: 1.0
    )
  }
}
