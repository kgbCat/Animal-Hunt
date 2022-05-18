//
//  TableViewCell.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/4/22.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func onDrawingScene()
}

final class TableViewCell: UITableViewCell {

    weak var delegate: TableViewCellDelegate?

    //MARK: IBOutlets
    @IBOutlet weak var animalImage: UIImageView! {
        didSet{
            animalImage.layer.cornerRadius = 6
            animalImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var predictionLabel: UILabel!


    @IBAction func onDrawSceneTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.onDrawingScene()
        }
    }


    func configure(animal: Animal) {
        predictionLabel.text = animal.name
        // convert binary to image
        if let imgdData = animal.image {
            if let image = UIImage(data: imgdData) {
                animalImage.image? = image
            }
        }
    }
}
