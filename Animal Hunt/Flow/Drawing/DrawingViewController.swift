//
//  DrawingViewController.swift
//  Animal Hunt
//
//  Created by Anna Delova on 4/29/22.
//

import UIKit
import PencilKit

final class DrawingViewController: UIViewController {

    var animal = Animal()
    private let  presenter = DrawingPresenter()

    lazy var toolPicker: PKToolPicker = {
       let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()

    //MARK: IBOutlets
    @IBOutlet weak var canvasView: PKCanvasView!


    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.delegate = self
        canvasView.drawingPolicy = .default

        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(canvasView)
        presenter.setScale(canvasView)
    }


    //MARK: IBActions

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let image = presenter.takeScreenshot(canvasView)
        presenter.save(animal, image)
        presenter.showAlert(message: Constants.addToGallery, self)
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}

extension DrawingViewController: PKCanvasViewDelegate, PKToolPickerObserver {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        presenter.updateContentSizeForDrawing(canvasView)
    }
}
