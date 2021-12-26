//
//  ViewController.swift
//  RGB View
//
//  Created by Дарья Носова on 10.12.2021.
//

import UIKit


class RGBViewController: UIViewController {
 
  // MARK: - IB Outlets
  @IBOutlet var coloredView: UIView!
  
  @IBOutlet var redValueLabel: UILabel!
  @IBOutlet var greenValueLabel: UILabel!
  @IBOutlet var blueValueLabel: UILabel!
  
  @IBOutlet var redSlider: UISlider!
  @IBOutlet var greenSlider: UISlider!
  @IBOutlet var blueSlider: UISlider!
  
  @IBOutlet var redValueTextField: UITextField!
  @IBOutlet var greenValueTextField: UITextField!
  @IBOutlet var blueValueTextField: UITextField!
    
  var delegate: RGBViewControllerDelegate!
  var backgroundColor: CIColor!
  
  // MARK: - Life Cycles Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    coloredView.layer.cornerRadius = 32
  
    setupSlider()
    setupLabel()
    setupTextField()
    setupView()
  }
  
  // MARK: - IB Actions
  @IBAction func slidersAction() {
    setupView()
    
    redValueTextField.text = roundSliderValue(sliderValue: redSlider.value)
    greenValueTextField.text = roundSliderValue(sliderValue: greenSlider.value)
    blueValueTextField.text = roundSliderValue(sliderValue: blueSlider.value)
    
    redValueLabel.text = roundSliderValue(sliderValue: redSlider.value)
    greenValueLabel.text = roundSliderValue(sliderValue: greenSlider.value)
    blueValueLabel.text = roundSliderValue(sliderValue: blueSlider.value)
    
  }
  @IBAction func saveButtonPressed(_ sender: UIButton) {
    view.endEditing(true)
    delegate?.setBackgroundColour(redValue: redSlider.value , greenValue: greenSlider.value , blueValue: blueSlider.value)
    dismiss(animated: true)
    }

  // MARK: - Private Methods
  private func setupLabel() {
    redValueLabel.text = roundSliderValue(sliderValue: redSlider.value)
    greenValueLabel.text = roundSliderValue(sliderValue: greenSlider.value)
    blueValueLabel.text = roundSliderValue(sliderValue: blueSlider.value)
  }
  
  private func setupSlider() {
    redSlider.minimumTrackTintColor = .red
    greenSlider.minimumTrackTintColor = .green
    
    redSlider.value = Float(backgroundColor.red)
    greenSlider.value = Float(backgroundColor.green)
    blueSlider.value = Float(backgroundColor.blue)
  }
  
  private func setupTextField() {
    redValueTextField.text = roundSliderValue(sliderValue: redSlider.value)
    greenValueTextField.text = roundSliderValue(sliderValue: greenSlider.value)
    blueValueTextField.text = roundSliderValue(sliderValue: blueSlider.value)
    
    redValueTextField.delegate = self
    greenValueTextField.delegate = self
    blueValueTextField.delegate = self
  }
  
  private func setupView() {
    let redSliderValue = CGFloat(redSlider.value)
    let greenSliderValue = CGFloat(greenSlider.value)
    let blueSliderValue = CGFloat(blueSlider.value)
    
    coloredView.backgroundColor = UIColor (
      red: redSliderValue,
      green: greenSliderValue,
      blue: blueSliderValue,
      alpha: 1.0
    )
  }
  
  private func roundSliderValue(sliderValue: Float) -> String {
    return String(round(sliderValue * 100) / 100)
  }
}

// MARK: - Extensions
extension RGBViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let newValue = textField.text else { return }

    guard let numberValue = Float(newValue) else {
      showAlert(title: "Oops!", message: "Invalid value:(");
      textField.text = "1.0"
      return
    }
    
    if (numberValue > 1 || numberValue < 0) {
      showAlert(title: "Oops!", message: "Invalid value:(");
      textField.text = "1.0"
      return
    }
    
    if textField == redValueTextField {
      redSlider.value = numberValue
      redValueLabel.text = roundSliderValue(sliderValue: numberValue)
    } else if textField == greenValueTextField {
      greenSlider.value = numberValue
      greenValueLabel.text = roundSliderValue(sliderValue: numberValue)
    } else {
      blueSlider.value = numberValue
      blueValueLabel.text = roundSliderValue(sliderValue: numberValue)
    }
    setupView()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    redValueTextField.endEditing(true)
    greenValueTextField.endEditing(true)
    blueValueTextField.endEditing(true)
  }
}

extension RGBViewController {
  private func showAlert(title: String, message: String, textField: UITextField? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
      textField?.text = ""
    }
    alert.addAction(okAction)
    present(alert, animated: true)
  }
}
