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
    var progressView: UIProgressView!
    
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
        
        // Create a UIProgressView instance and give it the default style
        progressView = UIProgressView(progressViewStyle: .default)
        // Set the layout size so it fits the contents fully
        progressView.sizeToFit()
        // Wrap the UIProgressView inside the new instance of UIBarButtonItem so it can go in our toolbar. This is our progress button that we'll put on the left side of the toolbar
        let progressButton = UIBarButtonItem(customView: progressView)
        
        // Helps put the refresh button on the right by taking up as much room as it can on the left
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // The refresh button to be used that calls the reload method in our web view
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        // Create an array containing the flexible space and refresh buttons, and then set it to be our view controller's toolbarItems array
        toolbarItems = [progressButton, spacer, refresh]
        
        // Keep the toolbar visible
        navigationController?.isToolbarHidden = false
        
        // This is called a Key-Value obeserving (KVO) and we'll be using it to keep track of the progress button. To do KVO, we'll first need to add ourselves as an observer. This method takes in 4 parameters: 1. who the observer is - us 2. what property we want to observe - the estimatedProgress property of WKWebView 3. which values we want and 4. a context value is a unique value that you want to be sent back to you when it changes
        // #keyPath works like #selector because it allows the compiler to check if your code is correct
        // In some cases, removeObserver should be called when you're finished observing
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    // Method to tell you when an observer value has changed
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
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

