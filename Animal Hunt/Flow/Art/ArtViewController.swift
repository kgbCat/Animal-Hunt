//
//  ArtViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/20/22.
//

import UIKit

class ArtViewController: UIViewController {

    //MARK: - Private properties
    private var presenter = ArtViewPresenter()
    private var art = [UIImage]()
    private let cellId = Constants.artCollectionCell


    //MARK: -IBOulets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ArtViewPresenter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getArts()
    }


    //MARK: -Private  methods
    private func getArts() {
        if let art = presenter.getArts() {
            self.art = art
            if art.count == 0 {
                collectionView.backgroundView  = UIImageView(image: UIImage(named: Constants.defaultArt))

                collectionView.backgroundView?.contentMode = .scaleAspectFit
            } else {
                collectionView.backgroundView  = .none
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
