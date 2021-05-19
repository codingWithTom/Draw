//
//  Canvas.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

final class Canvas: UIView {
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
    addGesture()
  }
  
  private func addGesture() {
    addClearGesture()
  }
  
  private func addClearGesture() {
    let doubleTap = UITapGestureRecognizer(target: self, action: #selector(didTapTwiceWithTwoFingers))
    doubleTap.numberOfTapsRequired = 2
    doubleTap.numberOfTouchesRequired = 2
    addGestureRecognizer(doubleTap)
  }
  
  @objc
  private func didTapTwiceWithTwoFingers() {
    UIView.animate(withDuration: 0.5, animations: { [weak self] in
      self?.subviews.forEach {
        self?.removeAnimated(view: $0)
      }
    }, completion: { [weak self] _ in
      self?.subviews.forEach {
        $0.removeFromSuperview()
      }
    })
  }
  
  private func removeAnimated(view: UIView) {
    let centerOfView = CGPoint(x: bounds.midX, y: bounds.midY)
    let originOfView = view.frame.origin
    let offset = CGPoint(x: originOfView.x - centerOfView.x, y: originOfView.y - centerOfView.y)
    view.transform = view.transform.translatedBy(x: offset.x * 20, y: offset.y * 20)
  }
}
