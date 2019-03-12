//
//  NavigationBarLyout.swift
//
//  Created by Jesse on 2019/3/10.
//

import Foundation

extension UINavigationBar {
    public func setupTranslucent() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
}

private enum Keys {
    static var lastContentOffsetYKey: UInt8 = 1
    static var lastTitleSizeKey: UInt8 = 1
}

extension UIViewController {
    var lastContentOffsetY: CGFloat {
        get {
            return objc_getAssociatedObject(self, &Keys.lastContentOffsetYKey) as? CGFloat ?? 0
        }

        set {
            objc_setAssociatedObject(self, &Keys.lastContentOffsetYKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    var lastTitleSize: CGFloat {
        get {
            return objc_getAssociatedObject(self, &Keys.lastTitleSizeKey) as? CGFloat ?? 15
        }

        set {
            objc_setAssociatedObject(self, &Keys.lastTitleSizeKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    /// hide navigation bar and adjust font size of title when scrolling either up or down
    public func hidingNavigationBarWhenScroll(_ scrollView: UIScrollView) {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }

        let diff = scrollView.contentOffset.y - self.lastContentOffsetY
        var fontSize: CGFloat!
        var frame = navigationBar.frame
        let statusBarHeight: CGFloat = prefersStatusBarHidden == true ? -20 : 0

        // Scroll down
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            print("scroll down", diff)
        } else { // Scroll up
            print("scroll up")
        }

        frame.origin.y = max(statusBarHeight, min(frame.origin.y - diff, 20))
        fontSize = max(12, min(self.lastTitleSize - 0.1 * diff, 15))

        navigationBar.frame = frame
        navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: fontSize)]
        self.lastTitleSize = fontSize
        self.lastContentOffsetY = scrollView.contentOffset.y
    }
}
