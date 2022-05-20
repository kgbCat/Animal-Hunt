//
//  ArtViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/20/22.
//

import UIKit

class ArtViewController: UIViewController {

    private var art = [UIImage]()
    private let cellId = "artCell"


    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getArts()

        // Do any additional setup after loading the view.
    }
    private func getArts() {
        let animals  = CoreDataHelper().getAnimals(user: Secret.shared.user)
        animals?.forEach({ animal in
            art.append(UIImage(data: animal.image!)! )
        })
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

    }


}

extension ArtViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        art.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
           withReuseIdentifier: cellId,
           for: indexPath
         ) as! ArtCollectionViewCell

        cell.artImageView.image = art[indexPath.row]

        return cell
    }


}
