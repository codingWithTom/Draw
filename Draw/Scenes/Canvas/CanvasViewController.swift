//
//  CanvasViewController.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

final class CanvasViewController: UIViewController {
  
  private var canvas: Canvas = {
    let canvas = Canvas()
    canvas.translatesAutoresizingMaskIntoConstraints = false
    return canvas
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addCanvas()
    setupViewGestures()
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
    shape.color = getRandomColor()
    canvas.addSubview(shape)
  }
  
  func getShape(withCenter center: CGPoint, size: CGSize) -> Shape {
    let rand = Int.random(in: 1 ... 4)
    if rand == 1 {
      return Circle(frame: CGRect(origin: center, size: size))
    } else if rand == 2 {
      return Rectangle(frame: CGRect(origin: center, size: size))
    } else if rand == 3 {
      let newSize = CGSize(width: size.width * 1.5, height: size.height)
      return Rectangle(frame: CGRect(origin: center, size: newSize))
    } else if rand == 4 {
      return Triangle(frame: CGRect(origin: center, size: size))
    }
    else {
      return Circle(frame: CGRect(origin: center, size: size))
    }
  }
  
  func getRandomColor() -> UIColor {
    return [UIColor.blue, .red, .green, .gray, .brown, .orange, .purple, .yellow].randomElement() ?? .black
  }
}
