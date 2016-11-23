//
//  UIWebViewController.swift
//  Webview Tester
//
//  Created by Brian Reinhart on 8/19/16.
//  Copyright © 2016 Brian Reinhart. All rights reserved.
//

import UIKit

class UIWebViewController: UIViewController, UIWebViewDelegate {

    public var url: URL!
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var btnForward: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(URLRequest(url: url))
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
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription);
    }
}
