//
//  ListViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/27/22.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: Private properties
    private let coreData = CoreDataPresenter()
    private var animals:[Animal] = []
    private let cellID = String(describing: TableViewCell.self)


    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet  {
            let nib = UINib(nibName: cellID, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellID)
        }
    }


    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Animals"
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItems()
    }


    // MARK: Private Methods
    private func getItems() {
        if let items = coreData.getAllitems() {
            self.animals = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

    //MARK: UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID,
                                                       for: indexPath) as? TableViewCell
        else { return UITableViewCell() }

        cell.configure(animal: animals[indexPath.row])
        return cell
    }
}

    //MARK: UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = animals[indexPath.row]
//        guard let imgData = item.image else { return }
//        let image = UIImage(data: imgData)
        // navigate to animal info page and pass data


    }

    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.none
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = animals[indexPath.row]
        // Delete action
        let delete = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleMovetoDelete(item: item)
            completionHandler(true)
        }

        delete.backgroundColor = .systemRed
        delete.image = UIImage(named: "icons8-bull-64")

        // Edit action
        let edit = UIContextualAction(style: .normal,
                                      title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleMovetoEdit(item: item)
            completionHandler(true)
        }

        edit.backgroundColor = .systemGreen
        edit.image  = UIImage(named: "abstract-1313")

        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])

        return configuration
    }
}


extension ListViewController {

    private func handleMovetoDelete(item: Animal) {
        // alert ( Are you sure you want to delete it? You can not restore it back)
        let alert = UIAlertController(title: nil,
                                      message: "Are you sure you want to delete it? You can not restore it back",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.coreData.deleteItem(item: item)
            self?.getItems()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    private func handleMovetoEdit(item: Animal) {
        // alert to edit name
        let alert = UIAlertController(title: "New Name",
                                      message: "Enter new name",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first,
                  let name = field.text,
                  !name.isEmpty
            else {
                return
            }
            self?.coreData.updateItem(item: item, newName: name )
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
        }))
        present(alert, animated: true)

    }

}
