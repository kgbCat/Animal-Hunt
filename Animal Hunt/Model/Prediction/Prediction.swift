//
//  Prediction.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/29/22.
//

import Foundation
import UIKit

struct Prediction {
    /// The name of the object or scene the image classifier recognizes in an image.
    let classification: String
    /// The image classifier's confidence as a percentage string.
    let confidencePercentage: String

    let picture: UIImage?
}
