//
//  WebViewController.swift
//  RecipeBook
//
//  Created by Yi Cao on 11/20/18.
//  Copyright © 2018 Yi Cao. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var pageURL: String!
    var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView = UIProgressView(progressViewStyle: .bar)
       view.addSubview(progressView)
        setupProgressView()
        // setup page request
        if let url = URL(string: pageURL) {
            let urlRequest: URLRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    
    override func loadView() {
        //Returns a web view initialized with a specified frame and configuration.
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView // always assigned to fill the window
        
    }
    
    // observe oading value changes
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == StringConstants.progressKeypath {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func setupProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    private struct StringConstants {
        static let progressKeypath = "estimatedProgress"
    }
}
