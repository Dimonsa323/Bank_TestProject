//
//  ActivitityIndicator+Extension.swift
//  Bank_TestProject
//
//  Created by Дима Губеня on 17.04.2023.
//

import UIKit

extension UIView {
    
    func showActivityIndicator(style: UIActivityIndicatorView.Style = .medium, color: UIColor = .gray, tranfsormValue: CGFloat? = nil) {
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.frame = bounds
        activityIndicatorView.color = color
        activityIndicatorView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        if let tranfsormValue = tranfsormValue {
            activityIndicatorView.transform = CGAffineTransform(scaleX: tranfsormValue, y: tranfsormValue)
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

    func hideActivityIndicatorView() {
        if let activityIndicator: UIView = self.subviews.first(where: { $0 is UIActivityIndicatorView }) {
            activityIndicator.removeFromSuperview()
        }
    }
}
