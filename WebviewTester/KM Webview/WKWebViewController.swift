//
//  WKWebViewController.swift
//  Webview Tester
//
//  Created by Brian Reinhart on 8/19/16.
//  Copyright © 2016 Brian Reinhart. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {
    
    public var url: URL!
    public var cookies: Bool!
    
    @IBOutlet var btnForward: UIBarButtonItem!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wkConfiguration = WKWebViewConfiguration()

        if(cookies == false) {
            wkConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        }
        else {
            wkConfiguration.websiteDataStore = WKWebsiteDataStore.default()
        }
        
        //+56 from top for the Navigation bar
        //-44 on bottom for the toolbar.
        //-100 for height total.
        webView = WKWebView(frame:
            CGRect(x: self.view.frame.origin.x,
                   y: self.view.frame.origin.y + 56,
                   width: self.view.frame.width,
                   height: self.view.frame.height - 100),
                configuration: wkConfiguration)

        _ = webView.load(URLRequest(url: url))
        self.view.addSubview(webView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Toolbar Button Actions */
    
    @IBAction func btnBackClicked(_ sender: UIBarButtonItem) {
        if(webView.canGoBack) {
            webView.goBack()
        }
        else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btnForwardClicked(_ sender: UIBarButtonItem) {
        if(webView.canGoForward) {
            webView.goForward()
        }
    }
    @IBAction func btnDoneClicked(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /* UIWebView delegate functions */
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if(!webView.canGoForward) {
            btnForward.isEnabled = false
        }
        else {
            btnForward.isEnabled = true
        }
    }
}
