//
//  ScrollView+Extension.swift
//
//  Created by Jesse on 2019/3/12.
//

import Foundation

public enum ScrollDirection {
    case up(CGFloat)
    case down(CGFloat)
    case left(CGFloat)
    case right(CGFloat)
    case origin
}

public var lastScrollOffset: CGPoint = CGPoint.zero

public extension UIScrollViewDelegate {
    // recommend that you handle `scrollViewDidScroll` to this func to get more useful value
    func scrollViewDidScrollHandler(_ scrollView: UIScrollView) -> (scrollView: UIScrollView, direction: ScrollDirection) {
        let offset = scrollView.contentOffset
        //        let gestureDirection = scrollView.panGestureRecognizer.velocity(in: scrollView.superview)
        var direction: ScrollDirection = .origin

        let deltaX = offset.x - lastScrollOffset.x
        let deltaY = offset.y - lastScrollOffset.y

        if deltaY > 0 {
            direction = .up(deltaY)
        } else if deltaY < 0 {
            direction = .down(deltaY)
        }
        lastScrollOffset.y = offset.y

        if deltaX > 0 {
            direction = .left(deltaX)
        } else if deltaX < 0 {
            direction = .right(deltaX)
        }

        if deltaX == 0 && deltaY == 0 {
            direction = .origin
        }
        lastScrollOffset.x = offset.x

        return (scrollView, direction)
    }
}
