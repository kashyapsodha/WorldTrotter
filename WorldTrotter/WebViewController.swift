//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Kashyap Sodha on 2/17/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{

    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()

        webView.navigationDelegate = self as? WKNavigationDelegate
        view = webView
        print("WebViewController is loaded")
        let urlstring: String = "https://www.google.com"
        print("Now loading this url: \(urlstring)")
        let url = URL(string: urlstring)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("WebViewController is loaded")
    }
}
