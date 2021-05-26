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

class Shape: UIView {
  
  private var offset: CGPoint?
  private var previousScale: CGFloat?
  var color: UIColor = .red {
    didSet {
      setNeedsDisplay()
    }
  }
  weak var delegate: ShapeDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    backgroundColor = .clear
    isOpaque = true
    contentMode = .redraw
    setNeedsDisplay()
    addGestures()
  }
  
  private func addGestures() {
    addDragGesture()
    addPinchGesture()
    addLongPressGesture()
  }
  
  private func addDragGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(gesture:)))
    addGestureRecognizer(panGesture)
  }
  
  private func addPinchGesture() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(gesture:)))
    addGestureRecognizer(pinchGesture)
  }
  
  private func addLongPressGesture() {
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(gesture:)))
    addGestureRecognizer(longPress)
  }
  
  @objc
  private func didPan(gesture: UIPanGestureRecognizer) {
    guard let superview = self.superview else { return }
    let anchorPoint = gesture.location(in: superview)
    switch gesture.state {
    case .began:
      self.offset = CGPoint(x: center.x - anchorPoint.x, y: center.y - anchorPoint.y)
    default:
      let newCenter = CGPoint(x: anchorPoint.x + (offset?.x ?? 0), y: anchorPoint.y + (offset?.y ?? 0))
      self.center = newCenter
    }
  }
  
  @objc
  private func didPinch(gesture: UIPinchGestureRecognizer) {
    switch gesture.state {
    case .began:
      self.previousScale = gesture.scale
    default:
      let scale = gesture.scale - (previousScale ?? 1.0)
      let newWidth = bounds.size.width * (1 + scale)
      let newHeight = bounds.size.height * (1 + scale)
      let offset = CGPoint(x: bounds.size.width - newWidth, y: bounds.size.height - newHeight)
      let newSize = CGSize(width: newWidth, height: newHeight)
      let newOrigin = CGPoint(x: frame.origin.x + offset.x / 2, y: frame.origin.y + offset.y / 2)
      frame = CGRect(origin: newOrigin, size: newSize)
      self.previousScale = gesture.scale
    }
  }
  
  @objc
  private func didLongPress(gesture: UILongPressGestureRecognizer) {
    guard gesture.state == .began else { return }
    delegate?.didLongPressShape(self)
  }
}
