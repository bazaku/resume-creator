//
//  ProjectViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 26/2/2565 BE.
//

import UIKit

class ProjectViewController: UIViewController {
    
    var presenter: ProjectPresenter?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var projectNameTextField: UITextField?
    @IBOutlet weak var projectSummaryTextView: UITextView?
    @IBOutlet weak var roleTextField: UITextField?
    @IBOutlet weak var teamSizeTextField: UITextField?
    @IBOutlet weak var technologyTextView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        avoidKeyboard(scrollView: scrollView)
        displayProject()
    }
    
    func displayProject() {
        guard let project = presenter?.getProject() else {
            return
        }
        projectNameTextField?.text = project.name
        projectSummaryTextView?.text = project.projectSummary
        roleTextField?.text = project.role
        if project.teamSize >= 0 {
            teamSizeTextField?.text = "\(project.teamSize)"
        }
        technologyTextView?.text = project.technologyUsed
    }
    
    @IBAction func save() {
        do {
            try presenter?.save(projectName: projectNameTextField?.text,
                                teamSize: teamSizeTextField?.text,
                                projectSummary: projectSummaryTextView?.text,
                                role: roleTextField?.text,
                                technologyUsed: technologyTextView?.text)
        } catch ProjectPresenter.ValidationError.invalidProjectName {
            displayError(text: "Please enter project name", responder: projectNameTextField)
        } catch ProjectPresenter.ValidationError.invalidProjectSummary {
            displayError(text: "Please enter project summary", responder: projectSummaryTextView)
        } catch ProjectPresenter.ValidationError.invalidRole {
            displayError(text: "Please enter role", responder: roleTextField)
        } catch ProjectPresenter.ValidationError.invalidTeamSize {
            displayError(text: "Please enter valid team size number", responder: teamSizeTextField)
        } catch ProjectPresenter.ValidationError.invalidTechnology {
            displayError(text: "Please enter technology used", responder: technologyTextView)
        } catch {
            displayError(text: "System error")
        }
    }

}

extension ProjectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case projectNameTextField:
            projectSummaryTextView?.becomeFirstResponder()
        case roleTextField:
            teamSizeTextField?.becomeFirstResponder()
        case teamSizeTextField:
            technologyTextView?.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
