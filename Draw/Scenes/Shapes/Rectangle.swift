//
//  Rectangle.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-17.
//

import UIKit

extension Shape {
  func getRectangle(_ rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    let margin: CGFloat = 5
    path.move(to: CGPoint(x: margin, y: margin))
    path.addLine(to: CGPoint(x: rect.width - margin, y: margin))
    path.addLine(to: CGPoint(x: rect.width - margin, y: rect.height - margin))
    path.addLine(to: CGPoint(x: margin, y: rect.height - margin))
    path.close()
    return path
  }
}
