//
//  CompanyCardView.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 25/2/2565 BE.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var textLabel: UILabel!
    private var editHandler: (() -> Void)?
    private var deleteHandler: (() -> Void)?
    
    func setData(text: String, editHandler: @escaping () -> Void, deleteHandler: @escaping () -> Void) {
        textLabel.text = text
        self.editHandler = editHandler
        self.deleteHandler = deleteHandler
    }
    
    @IBAction func edit() {
        editHandler?()
    }
    
    @IBAction func delete() {
        deleteHandler?()
    }
}
