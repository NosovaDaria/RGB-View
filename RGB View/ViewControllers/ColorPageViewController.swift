//
//  ColorPageViewController.swift
//  RGB View View
//
//  Created by Дарья Носова on 26.12.2021.
//

import UIKit

protocol RGBViewControllerDelegate {
  func setColour(_ color: UIColor)
}

class ColorPageViewController: UIViewController {

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let rgbVC = segue.destination as! RGBViewController
    rgbVC.delegate = self
    rgbVC.viewColor = view.backgroundColor
  }
}

extension ColorPageViewController: RGBViewControllerDelegate {
  func setColour(_ color: UIColor) {
    view.backgroundColor = color
  }
}
