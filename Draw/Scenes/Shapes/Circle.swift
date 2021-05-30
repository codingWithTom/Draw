//
//  Circle.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

extension Shape {
  
  private var centerPoint: CGPoint {
    return CGPoint(x: bounds.midX, y: bounds.midY)
  }
  
  func getCirle(_ rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    let radius = rect.width / 2 * 0.95
    path.addArc(withCenter: centerPoint, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    return path
  }
}
