//
//  File.swift
//  Gradient_Background
//
//  Created by 신효근 on 2020/08/14.
//  Copyright © 2020 신효근. All rights reserved.
//

import UIKit

open class CustomIntensityVisualEffectView: UIVisualEffectView {

    /// Create visual effect view with given effect and its intensity
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    init(effect: UIVisualEffect, intensity: CGFloat) {
        super.init(effect: nil)
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [unowned self] in self.effect = effect }
        animator.fractionComplete = intensity
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: Private
    private var animator: UIViewPropertyAnimator!

}
