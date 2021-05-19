//
//  Circle.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

final class Circle: Shape {
  
  var centerPoint: CGPoint {
    return CGPoint(x: bounds.midX, y: bounds.midY)
  }
  
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath()
    let radius = rect.width / 2 * 0.95
    path.addArc(withCenter: centerPoint, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    color.setFill()
    path.fill()
    UIColor.black.setStroke()
    path.lineWidth = 2
    path.stroke()
  }
}
