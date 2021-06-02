//
//  Triangle.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

extension Shape {
  
  func getTriangle(_ rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    let margin: CGFloat = 5
    path.move(to: CGPoint(x: margin, y: rect.height - margin))
    path.addLine(to: CGPoint(x: rect.width / 2, y: margin))
    path.addLine(to: CGPoint(x: rect.width - margin, y: rect.height - margin))
    path.addLine(to: CGPoint(x: margin, y: rect.height - margin))
    return path
  }
  
}
