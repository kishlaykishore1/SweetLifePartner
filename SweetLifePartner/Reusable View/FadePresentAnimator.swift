//
//  FadePresentAnimator.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 07/05/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit


class FadePresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 2.0
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    //Setting the transition’s context
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //Adding a fade transition
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        containerView.addSubview(toView)
        toView.alpha = 0.0
        UIView.animate(withDuration: duration,
                    animations: {
                        toView.alpha = 1.0
        },
                    completion: { _ in
                        transitionContext.completeTransition(true)
        }
        )
    }
}
