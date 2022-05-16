//
//  TableViewCell.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/4/22.
//

import UIKit

final class TableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var animalImage: UIImageView! {
        didSet{
            animalImage.layer.cornerRadius = animalImage.frame.size.height / 2
            animalImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var predictionLabel: UILabel!


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
