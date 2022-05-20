//
//  ArtCollectionViewCell.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/20/22.
//

import UIKit

class ArtCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var artImageView: UIImageView! {
        didSet {
            artImageView.layer.cornerRadius = 6
        }
    }

}
