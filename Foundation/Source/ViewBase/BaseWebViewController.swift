//
//  BaseWebViewController.swift
//  ASDebugger
//
//  Created by Jesse on 2019/3/20.
//

import UIKit
import WebKit

open class ASWebViewController: UIViewController {
    var webView: WKWebView
    private(set) var originURL: URL
    var progressView: UIProgressView

    public init(url: URL) {
        self.webView = WKWebView()
        self.progressView = UIProgressView()
        self.originURL = url
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        setupUI()

        // KVO
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)

        // load data
        load()
    }

    func setupUI() {
        let safeArea: UILayoutGuide

        if #available(iOS 11.0, *) {
            safeArea = view.safeAreaLayoutGuide
        } else {
            safeArea = view.readableContentGuide
        }

        [webView, progressView].forEach(view.addSubview)

        progressView.progressViewStyle = .bar

        webView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 1),
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
    }

    func load() {
        let request = URLRequest(url: originURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10.0)
        webView.load(request)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "loading")
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {

            progressView.alpha = 1.0

            progressView.setProgress(Float(webView.estimatedProgress), animated: true)

            if (webView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3,
                               delay: 0.3,
                               options: [.curveEaseOut],
                               animations: { [weak self] in
                                self?.progressView.alpha = 0.0
                    }, completion: { [weak self]
                        (finished : Bool) in
                        self?.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }

}

extension ASWebViewController: WKNavigationDelegate{
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = webView.url else {
            decisionHandler(.cancel)
            return
        }

        if url.scheme != "http" && url.scheme != "https" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            } else {
//                print("Sorry, you haven't install the \(url.scheme ?? "")")
            }
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
