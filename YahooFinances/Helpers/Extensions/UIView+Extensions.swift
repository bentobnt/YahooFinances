//
//  UIView+Extensions.swift
//  YahooFinances
//
//  Created by Bento luiz Rodrigues filho on 02/03/23.
//

import UIKit

extension UIView {
//    func addCardShadow(opacity: Float = 0.2) {
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 4)
//        self.layer.shadowRadius = 4
//        self.layer.shadowOpacity = opacity
//    }

    func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        if !self.isHidden && self.alpha == 1 {
            completion?()
            return
        }

        if isHidden {
            isHidden = false
        }

        UIView.animate(withDuration: duration, animations: { self.alpha = 1 }, completion: { _ in
            completion?()
        })
    }

    func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if self.isHidden || self.alpha == 0 {
                completion?()
                return
            }

            UIView.animate(withDuration: duration, animations: { self.alpha = 0 }, completion: { _ in
                self.isHidden = true
                completion?()
            })
        }
    }
}
