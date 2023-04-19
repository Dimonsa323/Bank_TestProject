//
//  ProgressView.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 19.04.2023.
//

import Foundation
import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

class CircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircle(startAngle: 0, endAngle: 270)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircle(startAngle: 0, endAngle: 180)
    }

    private func createCircle(startAngle: CGFloat, endAngle: CGFloat) {
        let segmentPath = createSegment(startAngle: startAngle, endAngle: endAngle)
        let segmentLayer = CAShapeLayer()
        segmentLayer.path = segmentPath.cgPath
        segmentLayer.lineWidth = 2
        segmentLayer.strokeColor = UIColor.blue.cgColor
        segmentLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(segmentLayer)
    }

    private func createSegment(startAngle: CGFloat, endAngle: CGFloat) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: self.frame.midX + 20, y: self.frame.midY + 20), radius: 10, startAngle: startAngle.toRadians(), endAngle: endAngle.toRadians(), clockwise: true)
    }
}
