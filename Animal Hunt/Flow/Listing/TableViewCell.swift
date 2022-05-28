//
//  TableViewCell.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/4/22.
//

import UIKit

final class TableViewCell: UITableViewCell {

    // MARK: Private properties
    private var touches = 0


    //MARK: IBOutlets
    @IBOutlet weak var animalImage: UIImageView! {
        didSet{
            animalImage.layer.cornerRadius = 6
            animalImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!



    @IBAction func heartAction(_ sender: UIButton) {
        didTapOnHeart()
    }


    func configure(animal: Animal) {
        predictionLabel.text = animal.name
        animalImage.image = UIImage(data: animal.image)
    }
    private func didTapOnHeart() {
        if touches == 0 {
            animateHeart()
            heartButton.setImage( UIImage( systemName: Constants.heartFilled), for: .normal )
            heartButton.tintColor = .systemRed
            touches += 1
        } else {
            animateHeart()
            heartButton.setImage( UIImage( systemName: Constants.heart ), for: .selected )
            heartButton.tintColor = .white
            touches = 0
        }
    }

    private func animateHeart() {
        UIView.transition(with: heartButton,
                          duration: 0.9,
                          options: [.transitionFlipFromLeft]){

        }
    }

}
