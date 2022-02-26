//
//  EducationViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import UIKit

class EducationViewController: UIViewController {
    
    var presenter: EducationPresenter?
    
    var currentYear: Int = 0
    var selectedYear: Int = 0
    @IBOutlet weak var classNameTextField: UITextField?
    @IBOutlet weak var passingYearPickerView: UIPickerView?
    @IBOutlet weak var cgpaTextField: UITextField?
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentYear = Calendar(identifier: .gregorian).component(.year, from: Date())
        selectedYear = currentYear
        displayEducation()
        avoidKeyboard(scrollView: scrollView)
    }
    
    private func displayEducation() {
        guard let education = presenter?.getEducation() else {
            return
        }
        classNameTextField?.text = education.className
        if education.cgpa != 0 {
            cgpaTextField?.text = "\(education.cgpa)"
        }
        if education.passingYear > 0 {
            selectedYear = education.passingYear
            let row = currentYear - selectedYear
            if row > 0 {
                passingYearPickerView?.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    
    @IBAction func save() {
        do {
            try presenter?.save(className: classNameTextField?.text, passingYear: selectedYear, cgpa: cgpaTextField?.text)
        } catch EducationPresenter.ValidationError.invalidClassName {
            displayError(text: "Invalid class name", responder: classNameTextField)
        } catch EducationPresenter.ValidationError.invalidCGPA {
            displayError(text: "Invalid CGPA", responder: cgpaTextField)
        } catch {}
    }

}

extension EducationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let year = currentYear - row
        return "\(year)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = currentYear - row
    }
}

extension EducationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case classNameTextField:
            cgpaTextField?.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
