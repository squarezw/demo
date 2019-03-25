//
//  NibView.swift
//  ASDebugger
//
//  Created by Jesse on 2019/3/25.
//

import UIKit

/// Custom UIView with XIB file is a very common practice in iOS Development.
///
/// Custom UIView classes don’t contain XIB files when you create them. That’s why we have to make sure that we connect the XIB file the right way. There are two approaches of merging the custom UIView with XIB file:
///
///     - UIView initialized as a Custom Class
///     - UIView initialized programmatically
///
/// At this point, you might be confused from the above-mentioned points
///
/// You could use NibView instead of old approache:
///
///     class CustomView: NibView {}
///
///     let customView = CustomView().loadNib() as! CustomView
///     customView.frame = /* add your frame */
///     view.addSubview(customView)
///
/// https://medium.com/swift2go/swift-custom-uiview-with-xib-file-211bb8bbd6eb
class NibView: UIView {

    var shouldSetupConstraints = true

    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setup view from .xib file
        xibSetup()
        // Update constraints
        updateConstraintsIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Setup view from .xib file
        xibSetup()
    }

    /// Best practice for update constrainsts
    override func updateConstraints() {
        if shouldSetupConstraints {
            // add constrainsts here
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
}

private extension NibView {

    func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
