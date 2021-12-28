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
    
  // MARK: - Public Properties
  var delegate: RGBViewControllerDelegate!
  var viewColor: UIColor!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    coloredView.layer.cornerRadius = 32
    
    redSlider.minimumTrackTintColor = .red
    greenSlider.minimumTrackTintColor = .green
    
    coloredView.backgroundColor = viewColor
  
    setupSlider()
    setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
    setValue(for: redValueTextField, greenValueTextField, blueValueTextField)
  }
  
  // MARK: - IB Actions
  @IBAction func slidersAction(_ sender: UISlider) {
    
    switch sender {
    case redSlider:
      setValue(for: redValueLabel)
      setValue(for: redValueTextField)
    case greenSlider:
      setValue(for: greenValueLabel)
      setValue(for: greenValueTextField)
    default:
      setValue(for: blueValueLabel)
      setValue(for: blueValueTextField)
    }
    
    setColor()
  }
  
  @IBAction func saveButtonPressed() {
    delegate?.setColour(coloredView.backgroundColor ?? .white)
    dismiss(animated: true)
    }
}

  // MARK: - Private Methods
extension RGBViewController {
  
  private func setColor() {
    coloredView.backgroundColor = UIColor(
      red: CGFloat(redSlider.value),
      green: CGFloat(greenSlider.value),
      blue: CGFloat(blueSlider.value),
      alpha: 1
    )
  }
  
  private func setValue(for labels: UILabel...) {
    labels.forEach { label in
      switch label {
      case redValueLabel: label.text = string(from: redSlider)
      case greenValueLabel: label.text = string(from: greenSlider)
      default: label.text = string(from: blueSlider)
      }
    }
  }
  
  private func setValue(for textFields: UITextField...) {
    textFields.forEach { textField in
      switch textField {
      case redValueTextField: textField.text = string(from: redSlider)
      case greenValueTextField: textField.text = string(from: greenSlider)
      default: textField.text = string(from: blueSlider)
      }
    }
  }
  
  private func setupSlider() {
    let ciColor = CIColor(color: viewColor)
    redSlider.value = Float(ciColor.red)
    greenSlider.value = Float(ciColor.green)
    blueSlider.value = Float(ciColor.blue)
  }
  
  private func string(from slider: UISlider) -> String {
    String(format: "%.2f", slider.value)
  }
  
  @objc private func didTapDone() {
    view.endEditing(true)
  }
  
  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    alert.addAction(okAction)
    present(alert, animated: true)
  }
  
}

// MARK: - Extensions
extension RGBViewController: UITextFieldDelegate {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    view.endEditing(true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    guard let newValue = textField.text else { return }
    if let currentValue = Float(newValue) {
      switch textField {
      case redValueTextField:
        redSlider.setValue(currentValue, animated: true)
        setValue(for: redValueLabel)
      case greenValueTextField:
        greenSlider.setValue(currentValue, animated: true)
        setValue(for: greenValueLabel)
      default:
        blueSlider.setValue(currentValue, animated: true)
        setValue(for: blueValueLabel)
      }
      
      setColor()
      return
    }
    
    showAlert(title: "Wrong format!", message: "Please enter correct value")
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    let keyboardToolbar = UIToolbar()
    keyboardToolbar.sizeToFit()
    textField.inputAccessoryView = keyboardToolbar
    
    let doneButton = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(didTapDone)
    )
    
    let flexBarButton = UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil)
    
    keyboardToolbar.items = [flexBarButton, doneButton]
  }
  
}
