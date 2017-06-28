//
//  FeedItemViewController.swift
//  YasRssReader
//
//  Created by Yassine-Ha on 28/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class FeedItemViewController: UIViewController {
    
    var selectedFeedURL: String?
    @IBOutlet var myWebView: UIWebView!
    //commit test
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        myWebView.loadRequest(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
