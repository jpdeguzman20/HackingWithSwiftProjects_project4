//
//  ViewController.swift
//  Project4
//
//  It's project 4 and I'm getting the hang of it. I'm still using the comments to reinforce
//  what I learn.
//
//  Created by Jonathan Deguzman on 11/19/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

import WebKit
import UIKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView! // WKWebView is able's web renderer
    
    override func loadView() {
        // Create an instance of WKWebView and assign it to the webView property
        webView = WKWebView()
        // This is the concept of delegation (a programming pattern), which is one thing acting in place of another. Thus, when any web page navigation occurs, we're notified. Remember to inherit from the WKNavigationDelegate protocol
        webView.navigationDelegate = self
        // We make our view (the root view of the controller) the webView from above
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This line is important to remember if I ever need to create a URL
        let url = URL(string: "https://www.hackingwithswift.com")!
        // Creates a URLRequest object from the URL and gives it to our web view to load
        // Note that Apple will not load a String that looks like a URL, it has to be a URL
        webView.load(URLRequest(url: url))
        // Allows users to swipe from edge to edge to move backwards/forwards while browsing
        webView.allowsBackForwardNavigationGestures = true
        // Add a button to the navigation bar called "Open" and call openTapped method when tapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction!) {
        // Use the title property of the action and append it to https to create the URL
        let url = URL(string: "https://" + action.title!)!
        // Wrap the url in a url request and give it to the web view to load
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

