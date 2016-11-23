//
//  ViewController.swift
//  WebView Tester
//
//  Created by Brian Reinhart on 8/18/16.
//  Copyright © 2016 Brian Reinhart. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController,  UITextFieldDelegate{


    @IBOutlet var txtURL: UITextField!
    @IBOutlet var rbBrowserType: UISegmentedControl!
    @IBOutlet var cbCookies: UISwitch!
    @IBOutlet var lblCookies: UILabel!
    let defaults = UserDefaults.standard;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtURL.delegate = self
        
        //Set the defaults
        if defaults.string(forKey: "url") != nil {
            txtURL.text = defaults.string(forKey: "url")
        }
        rbBrowserType.selectedSegmentIndex = defaults.integer(forKey: "browserType")
        cbCookies.isOn = defaults.bool(forKey: "cookies")
        
        //Removes the Cookies CB if Safari is selected.
        updateCookiesVisibility()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCookiesVisibility() {
        if rbBrowserType.selectedSegmentIndex == 2 {
            cbCookies.isHidden = true
            lblCookies.isHidden = true
        }
        else {
            cbCookies.isHidden = false
            lblCookies.isHidden = false
        }
    }
    
    func showAlert(title: String, message: String, buttonLabel: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion:nil)
        let OKAction = UIAlertAction(title: buttonLabel, style: .default)
        alertController.addAction(OKAction)
    }
    
    /* UITextField Delegate method */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func browserTypeChanged(_ sender: UISegmentedControl) {
        updateCookiesVisibility()
    }
    
    @IBAction func btnFetch(_ sender: AnyObject) {
        
        guard var strURL = txtURL.text else {
            showAlert(title: "Oops", message: "You should enter a URL first", buttonLabel: "My Bad!")
            return; //Do not continue with the transition
        }
        
        if strURL.isEmpty {
            showAlert(title: "Oops", message: "You should enter a URL first", buttonLabel: "My Bad!")
            return; //Do not continue with the transition
        }
        
        //If this string doesn't start with a protocol, we should insert an https:// automatically.
        if strURL.range(of: "://", options: .caseInsensitive) == nil {
            strURL = "https://" + strURL
        }
        
        //Let us make sure this is a valid URL.
        guard let myURL = URL(string: strURL) else {
            showAlert(title: "Hmm", message: "The URL doesn't appear to be valid.  Please check the URL and try again.", buttonLabel: "Sure Thing!")
            return;
        }
        
        print("Using URL: " + myURL.absoluteString)
        
        //Now, let's figure out the cookie situation since this is a global setting
        if(!cbCookies.isOn) {
            //Disable the accept policy
            HTTPCookieStorage.shared.cookieAcceptPolicy = .never
            //clear all cookies
            let storage = HTTPCookieStorage.shared
            for cookie in storage.cookies! {
                storage.deleteCookie(cookie)
            }
        }
        else {
            HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        }
        
        //Store User Defaults
        defaults.set(txtURL.text, forKey: "url") //Store the unmodified string.
        defaults.set(cbCookies.isOn, forKey: "cookies")
        defaults.set(rbBrowserType.selectedSegmentIndex, forKey: "browserType")
        defaults.synchronize()
        
        
        //Now, we need to dymanically load the view we want based on the type of webview we select.
        var controller: UIViewController!
        
        switch rbBrowserType.selectedSegmentIndex {
        case 0:
            //UIWebView
            let uiwvController = self.storyboard?.instantiateViewController(withIdentifier: "UIWebView") as! UIWebViewController
            uiwvController.url = myURL;
            controller = uiwvController
            break;
        case 1:
            //WKWebView
            let wkController = self.storyboard?.instantiateViewController(withIdentifier: "WKWebView") as! WKWebViewController
            wkController.url = myURL;
            wkController.cookies = cbCookies.isOn
            controller = wkController
            break;
        case 2:
            //Safari VC
            let safariVC = SFSafariViewController(url: myURL)
            controller = safariVC
            break;
        default:
            showAlert(title: "Error", message: "The selected browser type was not recognized.  Please select a browser type and try again.", buttonLabel: "OK!")
            return;
        }
        
        if let navController = self.navigationController {
            navController.pushViewController(controller, animated: true)
        }
    }
}

