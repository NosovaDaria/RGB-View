//
//  ViewController.swift
//  RGB View
//
//  Created by Дарья Носова on 10.12.2021.
//

import UIKit


class ViewController: UIViewController {
 
  // MARK: - IB Outlets
  @IBOutlet var coloredView: UIView!
  
  @IBOutlet var redValueLabel: UILabel!
  @IBOutlet var greenValueLabel: UILabel!
  @IBOutlet var blueValueLabel: UILabel!
  
  @IBOutlet var redSlider: UISlider!
  @IBOutlet var greenSlider: UISlider!
  @IBOutlet var blueSlider: UISlider!
  
  // MARK: - Life Cycles Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    coloredView.layer.cornerRadius = 32
    
    redSlider.value = 0
    greenSlider.value = 0
    blueSlider.value = 0
    
    redValueLabel.text = String(redSlider.value)
    greenValueLabel.text = String(greenSlider.value)
    blueValueLabel.text = String(blueSlider.value)
    
    redSlider.minimumTrackTintColor = .red
    greenSlider.minimumTrackTintColor = .green
    blueSlider.minimumTrackTintColor = .blue
  }
  
  // MARK: - IB Actions
  @IBAction func slidersAction() {
    let redSliderValue = CGFloat(redSlider.value)
    let greenSliderValue = CGFloat(greenSlider.value)
    let blueSliderValue = CGFloat(blueSlider.value)
    
    coloredView.backgroundColor = UIColor(red: redSliderValue, green: greenSliderValue, blue: blueSliderValue, alpha: 1.0)
    
    redValueLabel.text = String(round(redSlider.value * 100) / 100)
    greenValueLabel.text = String(round(greenSlider.value * 100) / 100)
    blueValueLabel.text = String(round(blueSlider.value * 100) / 100)
    
  }
  
}
