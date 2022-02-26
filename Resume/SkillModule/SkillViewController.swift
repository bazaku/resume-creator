//
//  SkillViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import UIKit

class SkillViewController: UIViewController {
    
    var presenter: SkillPresenter?
    
    @IBOutlet weak var skillTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        displaySkill()
    }
    
    private func displaySkill() {
        let skillName = presenter?.getSkill()
        skillTextField?.text = skillName
    }
    
    @IBAction func save() {
        do {
            try presenter?.save(skillName: skillTextField?.text)
        } catch SkillPresenter.ValidationError.invalidName {
            displayError(text: "Invalid skill name", responder: skillTextField)
        } catch {
            displayError(text: "System error", responder: skillTextField)
        }
        
    }

}

extension SkillViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
