//
//  ListViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/27/22.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: Private properties
    private let presenter = ListPresenter()
    private var animals:[Animal] = []
    private let cellID = String(describing: TableViewCell.self)


    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet  {
            let nib = UINib(nibName: cellID, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellID)
        }
    }


    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItems()
    }


    // MARK: Private Methods
    private func getItems() {
        self.animals = presenter.getAnimals()
        if animals.count == 0 {
            tableView.backgroundView = UIImageView(image: UIImage(named: Constants.letsHunt))
            tableView.backgroundView?.contentMode = .scaleAspectFit
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        guard let drawingViewController = storyboard?.instantiateViewController(withIdentifier: Constants.drawingViewController) as? DrawingViewController else { return }
        drawingViewController.animal = animals[indexPath.row]

        navigationController?.pushViewController(drawingViewController, animated: true)
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

        delete.backgroundColor = UIColor.deleteColor
        delete.image = UIImage(named: Constants.bull)

        // Edit action
        let edit = UIContextualAction(style: .normal,
                                      title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.handleMovetoEdit(item: item)
            completionHandler(true)
        }

        edit.backgroundColor =  UIColor.editColor
        edit.image  = UIImage(named: Constants.monkey)

        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])

        return configuration
    }
}


extension ListViewController {

    private func handleMovetoDelete(item: Animal) {
        // alert ( Are you sure you want to delete it? You can not restore it back)
        let alert = presenter.presentDeleteAlert()
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.presenter.deleteAnimal(item)
            self?.getItems()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    private func handleMovetoEdit(item: Animal) {
        // alert to edit name
        let alert = presenter.presentEditAlert()
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first,
                  let name = field.text,
                  !name.isEmpty
            else {
                return
            }
            self?.presenter.updateAnimal(item: item, newName: name)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
        }))
        present(alert, animated: true)
    }
}
