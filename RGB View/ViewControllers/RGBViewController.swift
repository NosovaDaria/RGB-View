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
    
    redValueLabel.text = String(redSlider.value)
    greenValueLabel.text = String(greenSlider.value)
    blueValueLabel.text = String(blueSlider.value)
    
    setupSlider()
    setupView()
    setupTextField()
  }
  
  //MARK: - Private Properties
  private func setupSlider() {
    redSlider.minimumTrackTintColor = .red
    greenSlider.minimumTrackTintColor = .green
    
    redSlider.value = Float(backgroundColor.red)
    greenSlider.value = Float(backgroundColor.green)
    blueSlider.value = Float(backgroundColor.blue)
  }
  
  private func setupTextField() {
    redValueTextField.text = String(round(redSlider.value * 100) / 100)
    greenValueTextField.text = String(round(greenSlider.value * 100) / 100)
    blueValueTextField.text = String(round(blueSlider.value * 100) / 100)
    
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
  
  // MARK: - IB Actions
  @IBAction func slidersAction() {
    setupView()
    
    redValueTextField.text = String(round(redSlider.value * 100) / 100)
    greenValueTextField.text = String(round(greenSlider.value * 100) / 100)
    blueValueTextField.text = String(round(blueSlider.value * 100) / 100)
    
    redValueLabel.text = String(round(redSlider.value * 100) / 100)
    greenValueLabel.text = String(round(greenSlider.value * 100) / 100)
    blueValueLabel.text = String(round(blueSlider.value * 100) / 100)
    
  }
  @IBAction func saveButtonPressed(_ sender: UIButton) {
    view.endEditing(true)
    delegate?.setBackgroundColour(redValue: redSlider.value , greenValue: greenSlider.value , blueValue: blueSlider.value)
    dismiss(animated: true)
    }
}

extension RGBViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let newValue = textField.text else { return }

    guard let numberValue = Float(newValue) else {
      showAlert(title: "Oops!", message: "Invalid value:(");
      textField.text = "1.0"
      return
    }
    
    if textField == redValueTextField {
      redSlider.value = numberValue
      redValueLabel.text = String(round(numberValue * 100) / 100)
    } else if textField == greenValueTextField {
      greenSlider.value = numberValue
      greenValueLabel.text = String(round(numberValue * 100) / 100)
    } else {
      blueSlider.value = numberValue
      blueValueLabel.text = String(round(numberValue * 100) / 100)
    }
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
