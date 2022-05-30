//
//  DrawingPresenter.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/29/22.
//

import UIKit
import PencilKit

class DrawingPresenter {

    private let coreData =  CoreDataHelper()
    private let canvasWidth = CGFloat(Constants.canvasWidth)
    private let canvasOverscrollHight = CGFloat(Constants.canvasOverscrollHight)


    func updateContentSizeForDrawing(_ canvasView: PKCanvasView) {
        let drawing = canvasView.drawing
        let contentHeight: CGFloat

        if !drawing.bounds.isNull {

            contentHeight = canvasView.bounds.height
//            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + canvasOverscrollHight) * canvasView.zoomScale)
        } else {
            contentHeight = canvasView.bounds.height
        }

        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)

    }

    func setScale(_ canvasView: PKCanvasView) {
        let canvasScale = canvasView.bounds.width / canvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale

        updateContentSizeForDrawing(canvasView)
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)

    }

    func takeScreenshot(_ canvasView: PKCanvasView) -> UIImage {
                 // Begin context
              UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
                 // Draw view in that context
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
                 // get image
             let image = UIGraphicsGetImageFromCurrentImageContext()
                 UIGraphicsEndImageContext()

                 if (image != nil) {
                     return image!
                 }
                 return UIImage()
             }

        func save(_ animal: Animal, _ image: UIImage) {
            coreData.addDrawing(animal, image)
        }

    func showAlert(message: String, _ controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
