//
//  WebViewController.swift
//  BitBucketRepo
//
//  Created by Andrey Yoshua on 11/09/21.
//

import UIKit
import WebKit

public class WebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    private let request: URLRequest
    
    public init(request: URLRequest, title: String) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
        self.title = title
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Enable javascript in WKWebView to interact with the web app
        
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        closeButton.setTitle("X", for: [])
        closeButton.setTitleColor(.black, for: [])
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        closeButton.onTap { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        // Here "iOSNative" is our interface name that we pushed to the website that is being loaded
        configuration.userContentController.add(self, name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.load(request)
        
        view.addSubview(webView)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            titleLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            
            webView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
