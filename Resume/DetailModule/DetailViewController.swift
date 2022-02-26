//
//  DetailViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextField: UITextField?
    @IBOutlet weak var mobileNumberTextField: UITextField?
    @IBOutlet weak var emailAddressTextField: UITextField?
    @IBOutlet weak var residenceAddressTextView: UITextView?
    @IBOutlet weak var careerObjectiveTextView: UITextView?
    @IBOutlet weak var yearsOfExperienceTextField: UITextField?
    @IBOutlet weak var workSummaryStackView: UIStackView?
    @IBOutlet weak var skillsStackView: UIStackView?
    @IBOutlet weak var educationsStackView: UIStackView?
    @IBOutlet weak var projectsStackView: UIStackView?
    @IBOutlet weak var insertPhotoButton: UIButton?
    @IBOutlet weak var photoImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizer()
        avoidKeyboard(scrollView: scrollView)
    }
    
    private func addGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        gestureRecognizer.addTarget(self, action: #selector(showInsertPhotoChoiceIfNeeded))
        photoImageView?.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayResume()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    private func displayResume() {
        let resume = presenter.getResume()
        let picture = resume.picture
        if let picture = picture {
            DispatchQueue.main.async { [weak self] in
                do {
                    if let fileUrl = URL(string: picture) {
                        let data = try Data(contentsOf: fileUrl)
                        self?.photoImageView?.image = UIImage(data: data)
                    }
                } catch {}
                self?.insertPhotoButton?.isHidden = self?.photoImageView?.image != nil
                self?.photoImageView?.isHidden = self?.photoImageView?.image == nil
            }
        } else {
            insertPhotoButton?.isHidden = false
            photoImageView?.isHidden = true
        }
        
        titleTextField?.text = resume.title
        mobileNumberTextField?.text = resume.mobileNumber
        emailAddressTextField?.text = resume.emailAddress
        residenceAddressTextView?.text = resume.residenceAddress
        careerObjectiveTextView?.text = resume.careerObjective
        if let yearsOfExperience = resume.yearsOfExperience {
            yearsOfExperienceTextField?.text = String(yearsOfExperience)
        }
        
        workSummaryStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        resume.workSummary.forEach { company in
            let views = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)
            guard let cardView = views.first as? CardView else { return }
            let year = company.durationYear > 0 ? "\(company.durationYear) years" : ""
            let month = company.durationMonth > 0 ? "\(company.durationMonth) months" : ""
            let duration = "\(year) \(month)".trimmingCharacters(in: .whitespacesAndNewlines)
            let text = "\(company.name)\n\(duration)"
            cardView.setData(text: text, editHandler: { [weak self] in
                self?.presenter.editCompany(company)
            }, deleteHandler: { [weak self, weak cardView] in
                self?.presenter.deleteCompany(company)
                cardView?.removeFromSuperview()
            })
            workSummaryStackView?.addArrangedSubview(cardView)
        }
        
        skillsStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        resume.skills.forEach { skill in
            let views = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)
            guard let cardView = views.first as? CardView else { return }
            cardView.setData(text: skill, editHandler: { [weak self] in
                self?.presenter.editSkill(skill)
            }, deleteHandler: { [weak self, weak cardView] in
                self?.presenter.deleteSkill(skill)
                cardView?.removeFromSuperview()
            })
            skillsStackView?.addArrangedSubview(cardView)
        }
        
        educationsStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        resume.educations.forEach { education in
            let views = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)
            guard let cardView = views.first as? CardView else { return }
            let text = "\(education.className)\nPassing year: \(education.passingYear)\nCGPA:\(education.cgpa)"
            cardView.setData(text: text, editHandler: { [weak self] in
                self?.presenter.editEducation(education)
            }, deleteHandler: { [weak self, weak cardView] in
                self?.presenter.deleteEducation(education)
                cardView?.removeFromSuperview()
            })
            educationsStackView?.addArrangedSubview(cardView)
        }
        
        projectsStackView?.arrangedSubviews.forEach { $0.removeFromSuperview() }
        resume.projects.forEach { project in
            let views = UINib(nibName: "CardView", bundle: nil).instantiate(withOwner: nil, options: nil)
            guard let cardView = views.first as? CardView else { return }
            let text = "\(project.name)\n\(project.projectSummary)\nRole: \(project.role)\nTeam size: \(project.teamSize)\nTechnology: \(project.technologyUsed)"
            cardView.setData(text: text, editHandler: { [weak self] in
                self?.presenter.editProject(project)
            }, deleteHandler: { [weak self, weak cardView] in
                self?.presenter.deleteProject(project)
                cardView?.removeFromSuperview()
            })
            projectsStackView?.addArrangedSubview(cardView)
        }
    }
    
    @IBAction func addCompany() {
        presenter.addCompany()
    }
    
    @IBAction func addSkill() {
        presenter.addSkill()
    }
    
    @IBAction func addEducation() {
        presenter.addEducation()
    }
    
    @IBAction func addProject() {
        presenter.addProject()
    }

    @IBAction func insertPhoto() {
        showInsertPhotoChoiceIfNeeded()
    }
    
    @objc func showInsertPhotoChoiceIfNeeded() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController()
            alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                self?.showImagePicker(sourceType: .camera)
            }))
            alertController.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { [weak self] _ in
                self?.showImagePicker(sourceType: .photoLibrary)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alertController, animated: true)
        } else {
            showImagePicker(sourceType: .photoLibrary)
        }
    }
    
    private func showImagePicker(sourceType:  UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text
        switch textView {
        case residenceAddressTextView:
            presenter.updateResidenceAddress(text)
        case careerObjectiveTextView:
            break
        default:
            break
        }
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        switch textField {
        case titleTextField:
            presenter.updateTitle(text)
        case mobileNumberTextField:
            presenter.updateMobileNumber(text)
        case emailAddressTextField:
            presenter.updateEmailAddress(text)
        case yearsOfExperienceTextField:
            break
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case titleTextField:
            mobileNumberTextField?.becomeFirstResponder()
        case mobileNumberTextField:
            emailAddressTextField?.becomeFirstResponder()
        case emailAddressTextField:
            residenceAddressTextView?.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        do {
            let image = info[.editedImage] ?? info[.originalImage]
            guard let image = image as? UIImage else {
                return
            }
            let data = image.jpegData(compressionQuality: 1.0)
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            let resume = presenter.getResume()
            let fileURL = documentsDirectory.appendingPathComponent("\(resume.id).jpg")
            try data?.write(to: fileURL)
            photoImageView?.image = image
            photoImageView?.isHidden = false
            insertPhotoButton?.isHidden = true
            presenter.updatePhoto(fileURL.absoluteString)
            print(fileURL)
        } catch {
            print(error)
        }
        
    }
}
