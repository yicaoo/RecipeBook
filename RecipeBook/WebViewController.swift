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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
