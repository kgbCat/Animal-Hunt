//
//  CanvasView.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/17/22.
//

import UIKit

class CanvasView: UIView {

    var lines = [Touch]()
    var strokeWidth: CGFloat = 1.0
    var strokeOpacity: CGFloat = 1.0
    var strokeColor: UIColor = .black
    private var coreData = CoreDataHelper()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { line in
            for (index, point) in (line.points?.enumerated())! {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Touch(color: UIColor(), points: [CGPoint]()))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else { return }
        guard var lastPoint = lines.popLast() else { return }
        lastPoint.points?.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lastPoint.opacity = strokeOpacity
        lines.append(lastPoint)
        setNeedsDisplay()
    }

    func clearCanvas() {
        lines.removeAll()
        setNeedsDisplay()
    }

    func unDo() {
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
    
    func takeScreenshot() -> UIImage {
             // Begin context
          UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
             // Draw view in that context
             drawHierarchy(in: self.bounds, afterScreenUpdates: true)
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
}
