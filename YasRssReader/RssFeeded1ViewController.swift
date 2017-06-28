//
//  RssFeeded1ViewController.swift
//  YasRssReader
//
//  Created by Yassine-Ha on 28/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class RssFeeded1ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, XMLParserDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var navtitle: UINavigationItem!
    
    var rssFeededlayout:RssFeededlayout!;
    
    
    var myFeed : NSArray = []
    var feedImgs: [AnyObject] = []
    var url: URL!
    var urlString = ""
    var nameString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navtitle.title = nameString
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadData() {
        //
        
        if URL(string: urlString) == nil {
            
        }
        else{
            url = URL(string: urlString)!
            
            loadRss(url);

        }
            }

    func loadRss(_ data: URL) {
        // XmlParserManager instance/object/variable
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        // Put feed in array
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        collectionView.reloadData()
    }
  

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        
        super.viewWillTransition(to: size, with: coordinator);
        rssFeededlayout.invalidateLayout();
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return myFeed.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! RssFeededCollectionViewCell;
        
       /* print(feedImgs.count)
        print(myFeed.count)
        
        
        
        let url = NSURL(string:feedImgs[indexPath.row] as! String)
        let data = NSData(contentsOf:url! as URL)
        let imageviewtoDisplay = UIImage(data:data! as Data)
        
        cell.RssImageView?.image = imageviewtoDisplay
        */
        
        
        cell.title?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        
        
        cell.date.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String
       

        
        
        
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let feedItemViewController = storyBoard.instantiateViewController(withIdentifier: "FeedItemViewController") as! FeedItemViewController
        let selectedFURL: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
        feedItemViewController.selectedFeedURL = selectedFURL
        self.present(feedItemViewController, animated: true, completion: nil)
        
        
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }



}
