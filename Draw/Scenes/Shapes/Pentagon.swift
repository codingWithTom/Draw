//
//  Pentagon.swift
//  Draw
//
//  Created by Tomas Trujillo on 2021-05-30.
//

import UIKit

extension Shape {
  func getPentagon(_ rect: CGRect) -> UIBezierPath {
    let path = UIBezierPath()
    let padding: CGFloat = 5
    path.move(to: CGPoint(x: 0.0 + padding, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX, y: 0.0))
    path.addLine(to: CGPoint(x: rect.width - padding, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.width - rect.width * 0.10, y: rect.height - padding))
    path.addLine(to: CGPoint(x: rect.width * 0.10, y: rect.height - padding))
    path.close()
    return path
  }
}
