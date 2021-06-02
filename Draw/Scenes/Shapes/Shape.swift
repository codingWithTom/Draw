//
//  Shape.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

protocol ShapeDelegate: AnyObject {
  func didLongPressShape(_ shape: Shape)
}

final class Shape: UIView {
  enum Form {
    case rectangle
    case triangle
    case circle
    case pentagon
  }
  
  var offset: CGPoint?
  var previousScale: CGFloat?
  var form: Form = .circle {
    didSet {
      updatePath()
    }
  }
  var color: UIColor = .red {
    didSet {
      if fillColor == nil {
        fillColor = color
        setNeedsDisplay()
      } else {
        updateColor()
      }
    }
  }
  private var fillColor: UIColor?
  private var shapeLayer: CAShapeLayer!
  weak var delegate: ShapeDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override func draw(_ rect: CGRect) {
    let path = getPathFor(rect: rect)
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = fillColor?.cgColor
    shapeLayer.strokeColor = UIColor.black.cgColor
    shapeLayer.lineWidth = 2
  }
  
  private func setup() {
    backgroundColor = .clear
    isOpaque = true
    contentMode = .redraw
    setNeedsDisplay()
    addGestures()
    self.shapeLayer = CAShapeLayer()
    layer.addSublayer(self.shapeLayer)
  }
  
  func getPathFor(rect: CGRect) -> UIBezierPath {
    let path: UIBezierPath
    switch form {
    case .circle:
      path = getCirle(rect)
    case .rectangle:
      path = getRectangle(rect)
    case .triangle:
      path = getTriangle(rect)
    case .pentagon:
      path = getPentagon(rect)
    }
    return path
  }
  
  private func updatePath() {
    if let previousPath = shapeLayer.path {
      let newPath = getPathFor(rect: bounds).cgPath
      let animation = CABasicAnimation(keyPath: "path")
      animation.fromValue = previousPath
      animation.toValue = newPath
      animation.duration = 0.5
      shapeLayer.add(animation, forKey: "Path animation")
    }
    setNeedsDisplay()
  }
  
  private func updateColor() {
    let previousColor = shapeLayer.fillColor
    let newColor = color.cgColor
    let colorAnimation = CABasicAnimation(keyPath: "fillColor")
    colorAnimation.fromValue = previousColor
    colorAnimation.toValue = newColor
    colorAnimation.duration = 1.5
    shapeLayer.add(colorAnimation, forKey: "Color animation")

    CATransaction.begin()    
    let rotatingAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.y")
    let pi = CGFloat.pi
    let angles: [CGFloat] = [0, pi, pi * 2, pi * 3, pi * 4, pi * 5, pi * 6]
    rotatingAnimation.values = angles
    rotatingAnimation.duration = 1.2
    CATransaction.setCompletionBlock { [weak self] in
      self?.fillColor = self?.color
      self?.setNeedsDisplay()
    }
    layer.add(rotatingAnimation, forKey: "Rotating animation")
    CATransaction.commit()
  }
}
