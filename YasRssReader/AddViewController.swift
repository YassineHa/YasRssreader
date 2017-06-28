//
//  AddViewController.swift
//  YasRssReader
//
//  Created by Yassine-Ha on 28/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
   
    var userdefaults = UserDefaults.standard
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var NameLabel: UITextField!
    @IBOutlet weak var UrlLabel: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        MainView.layer.cornerRadius = 5
        MainView.clipsToBounds = true
        MainView.layer.masksToBounds = true

        warningView.layer.cornerRadius = 5
        warningView.clipsToBounds = true
        warningView.layer.masksToBounds = true
        
        SubmitBtn.layer.cornerRadius = 5
        SubmitBtn.clipsToBounds = true
        SubmitBtn.layer.masksToBounds = true
        
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.clipsToBounds = true
        cancelBtn.layer.masksToBounds = true
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func SubmitACtion(_ sender: Any) {
        
        
        let rsstoadd = RssFeed()
        rsstoadd.name = NameLabel.text
        rsstoadd.url = UrlLabel.text
        
        saveArrayMyRss(thisrssfeed: rsstoadd)
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
       
        self.present(viewController, animated: true, completion: nil)
        
        
    }
   
    @IBAction func CancelAction(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    
    func saveArrayMyRss(thisrssfeed : RssFeed){
        
        
        
        
        var myrssNamesArray = userdefaults.stringArray(forKey: "rssnames") ?? [String]()
        var myrssUrlArray = userdefaults.stringArray(forKey: "rssurls") ?? [String]()
        
        
        myrssNamesArray.append(thisrssfeed.name!)
        myrssUrlArray.append(thisrssfeed.url!)
        
        
        userdefaults.set(myrssNamesArray, forKey: "rssnames")
        userdefaults.set(myrssUrlArray, forKey: "rssurls")
        
        userdefaults.synchronize()
        
        
    }
    
}
