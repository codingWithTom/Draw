//
//  Triangle.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

final class Triangle: Shape {
  
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath()
    let margin: CGFloat = 5
    path.move(to: CGPoint(x: margin, y: rect.height - margin))
    path.addLine(to: CGPoint(x: rect.width / 2, y: margin))
    path.addLine(to: CGPoint(x: rect.width - margin, y: rect.height - margin))
    path.addLine(to: CGPoint(x: margin, y: rect.height - margin))
    color.setFill()
    path.fill()
    UIColor.black.setStroke()
    path.lineWidth = 2.0
    path.stroke()
  }
  
}
