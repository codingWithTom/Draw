//
//  CanvasViewController.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

final class CanvasViewController: UIViewController {
  
  override var canBecomeFirstResponder: Bool { return true }
  private weak var selectedShape: Shape?
  
  private var canvas: Canvas = {
    let canvas = Canvas()
    canvas.translatesAutoresizingMaskIntoConstraints = false
    return canvas
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addCanvas()
    setupViewGestures()
    configureMenu()
  }
}

private extension CanvasViewController {
  func addCanvas() {
    view.addSubview(canvas)
    NSLayoutConstraint.activate([
      canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      canvas.topAnchor.constraint(equalTo: view.topAnchor),
      canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  func setupViewGestures() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTwice))
    gesture.numberOfTouchesRequired = 1
    gesture.numberOfTapsRequired = 2
    canvas.addGestureRecognizer(gesture)
  }
  
  @objc func didTapTwice() {
    let size = CGSize(width: 100, height: 100)
    let center = CGPoint(x: view.center.x - size.width / 2, y: view.center.y - size.height / 2)
    let shape = getShape(withCenter: center, size: size)
    shape.delegate = self
    shape.color = getRandomColor()
    canvas.addSubview(shape)
  }
  
  func getShape(withCenter center: CGPoint, size: CGSize) -> Shape {
    let rand = Int.random(in: 1 ... 4)
    if rand == 1 {
      let shape = Shape(frame: CGRect(origin: center, size: size))
      shape.form = .circle
      return shape
    } else if rand == 2 {
      let shape = Shape(frame: CGRect(origin: center, size: size))
      shape.form = .rectangle
      return shape
    } else if rand == 3 {
      let newSize = CGSize(width: size.width * 1.5, height: size.height)
      let shape = Shape(frame: CGRect(origin: center, size: newSize))
      shape.form = .rectangle
      return shape
    } else if rand == 4 {
      let shape = Shape(frame: CGRect(origin: center, size: size))
      shape.form = .triangle
      return shape
    } else {
      return Shape(frame: CGRect(origin: center, size: size))
    }
  }
  
  func getRandomColor() -> UIColor {
    return [UIColor.blue, .red, .green, .gray, .brown, .orange, .purple, .yellow].randomElement() ?? .black
  }
  
  func configureMenu() {
    let menuController = UIMenuController.shared
    menuController.menuItems = [
      UIMenuItem(title: "Remove", action: #selector(didTapRemove)),
      UIMenuItem(title: "Change Color", action: #selector(didTapChangeColor))
    ]
    menuController.update()
  }
  
  @objc func didTapRemove() {
    selectedShape?.removeFromSuperview()
  }
  
  @objc func didTapChangeColor() {
    let colorController = UIColorPickerViewController()
    colorController.delegate = self
    present(colorController, animated: true, completion: nil)
  }
}

extension CanvasViewController: ShapeDelegate {
  func didLongPressShape(_ shape: Shape) {
    selectedShape = shape
    let menuController = UIMenuController.shared
    menuController.showMenu(from: canvas, rect: shape.frame)
  }
}

extension CanvasViewController: UIColorPickerViewControllerDelegate {
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    let color = viewController.selectedColor
    selectedShape?.color = color
  }
}
