//
//  Present.swift
//  ??
//
//  Created by Роман on 28.02.2022.
//

import Foundation
import UIKit

class Present: NSObject, UIViewControllerAnimatedTransitioning {

    private let indexPath: IndexPath
    private let originFrame: CGRect
    private let duration: TimeInterval = 0.3
    private let rounding: CGFloat
//    private let cell: UIView

    init(pageIndex: Int, originFrame: CGRect, rounding: CGFloat) {
        
        self.indexPath = IndexPath(item: pageIndex, section: 0)
        self.originFrame = originFrame
        self.rounding = rounding
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.view(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) as? SecondViewController,
              let fromView = fromVC.collectionView?.cellForItem(at: self.indexPath) as? SearchControllerCollectionViewCell
            else {
                transitionContext.completeTransition(true)
                return
        }

        let finalFrame = toView.frame

        let background = UIView(frame: UIScreen.main.bounds)
        background.backgroundColor = toView.backgroundColor
        background.alpha = 0
        
        let viewToAnimate = UIImageView(frame: originFrame)
        viewToAnimate.layer.cornerRadius = rounding
        viewToAnimate.image = fromView.searchPageImageView.image
        viewToAnimate.contentMode = .scaleAspectFill
        viewToAnimate.clipsToBounds = true
        fromView.searchPageImageView.isHidden = true

        let containerView = transitionContext.containerView
        containerView.addSubview(background)
        containerView.addSubview(toView)
        containerView.addSubview(viewToAnimate)

        toView.isHidden = true

        // Determine the final image height based on final frame width and image aspect ratio
        let imageAspectRatio = viewToAnimate.image!.size.width / viewToAnimate.image!.size.height
        let finalImageheight = finalFrame.width / imageAspectRatio

        // Animate size and position
        UIView.animate(withDuration: duration, animations: {
            viewToAnimate.frame.size.width = finalFrame.width
            viewToAnimate.frame.size.height = finalImageheight
            viewToAnimate.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            background.alpha = 1
        }, completion:{ _ in
            toView.isHidden = false
            fromView.searchPageImageView.isHidden = false
            background.removeFromSuperview()
            viewToAnimate.removeFromSuperview()
            transitionContext.completeTransition(true)
        })

    }
}
