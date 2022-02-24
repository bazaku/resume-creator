//
//  ListViewController.swift
//  Resume
//
//  Created by Siwasit Anmahapong on 24/2/2565 BE.
//

import UIKit

class ListViewController: UIViewController {
    
    private var presenter: ListPresenter!
    var allResumes: [ListViewModel] = []
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var emptyDataView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allResumes = presenter.getAllResume()
        tableView?.reloadData()
        tableView?.isHidden = allResumes.isEmpty
        emptyDataView?.isHidden = !allResumes.isEmpty
    }
    
    private func setUp() {
        let dataSource = SimpleDataSource()
        let repository = ResumeRepository(dataSource: dataSource)
        let interactor = ListInteractor(repository: repository)
        let router = ListRouter()
        presenter = ListPresenter(interactor: interactor, router: router)
    }

    @IBAction func createNewResume() {
        presenter.createNewResume()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allResumes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resume_cell", for: indexPath)
        let resume = allResumes[indexPath.row]
        cell.textLabel?.text = resume.title
        cell.detailTextLabel?.text = resume.updatedDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectResume(index: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
