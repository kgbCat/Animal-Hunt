//
//  CanvasView.swift
//  Animal Hunt
//
//  Created by Anna Delova on 5/17/22.
//

import UIKit

class CanvasView: UIView {

    var lines = [Touch]()

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
        lastPoint.color = .green
        lastPoint.width = 5
        lastPoint.opacity = 1.0
        lines.append(lastPoint)
        setNeedsDisplay()

    }


}
