//
//  CompanyViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import UIKit

class CompanyViewController: UIViewController {
    
    var presenter: CompanyPresenter?
    
    @IBOutlet weak var companyNameTextField: UITextField?
    @IBOutlet weak var durationYearTextField: UITextField?
    @IBOutlet weak var durationMonthTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayCompany()
    }
    
    private func displayCompany() {
        guard let company = presenter?.getCompany() else {
            return
        }
        companyNameTextField?.text = company.name
        if company.durationYear != 0 {
            durationYearTextField?.text = "\(company.durationYear)"
        }
        if company.durationMonth != 0 {
            durationMonthTextField?.text = "\(company.durationMonth)"
        }
    }
    
    @IBAction func save() {
        do {
            try presenter?.save(companyName: companyNameTextField?.text, durationYear: durationYearTextField?.text, durationMonth: durationMonthTextField?.text)
        } catch CompanyPresenter.ValidationError.invalidCompanyName {
            displayError(text: "Please enter company name", responder: companyNameTextField)
        } catch CompanyPresenter.ValidationError.invalidYear {
            displayError(text: "Invalid year input", responder: durationYearTextField)
        } catch CompanyPresenter.ValidationError.invalidMonth {
            displayError(text: "Invalid month input", responder: durationMonthTextField)
        } catch CompanyPresenter.ValidationError.invalidDuration {
            displayError(text: "Please enter duration", responder: durationYearTextField)
        } catch {
            displayError(text: "System error")
        }
    }

}

extension CompanyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case companyNameTextField:
            durationYearTextField?.becomeFirstResponder()
        case durationYearTextField:
            durationMonthTextField?.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
