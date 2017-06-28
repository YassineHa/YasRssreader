//
//  ViewController.swift
//  YasRssReader
//
//  Created by Yassine-Ha on 28/06/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var RsssearchBar: UISearchBar!
    var filtredMyRssFeedToDisplay = [RssFeed]()
    
    var isSearching = false
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var userdefaults = UserDefaults.standard
    
    var rssnames = [String]()
    var rssurls = [String]()
    
    
    
    var rssProvidersLayout:RssProvidersLayout!;
    var MyRssFeedToDisplay = [RssFeed]()
    
    override func viewDidLoad() {
        
        
        RsssearchBar.delegate = self
        RsssearchBar.returnKeyType = UIReturnKeyType.done
        
        LoadmyRssFeeds()
        
        }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
        super.viewWillTransition(to: size, with: coordinator);
        rssProvidersLayout.invalidateLayout();
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (isSearching) {
            return filtredMyRssFeedToDisplay.count;
            
        }
        
        
        
        
        return MyRssFeedToDisplay.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyFeedsCollectionViewCell;
        
        var myFeedRSS  : RssFeed
        
        
        if (isSearching){
            
            myFeedRSS = filtredMyRssFeedToDisplay[indexPath.item];
            
            
        }
            
        else {
            myFeedRSS = MyRssFeedToDisplay[indexPath.item];
        }
        
        
        
        
        cell.removeBtn.tag = indexPath.item;
        cell.removeBtn.addTarget(self,action:#selector(RemoveButtonAction),
                                 for:.touchUpInside);
        
        
        
        
        cell.Name.text = myFeedRSS.name
        
        cell.Url.text = myFeedRSS.url;
        
        
        return cell;
        
    }
    
    func RemoveButtonAction(sender: UIButton) {
        
        
        var nameRemoved = ""
        
        if (isSearching){
            nameRemoved = filtredMyRssFeedToDisplay[sender.tag].name!
            filtredMyRssFeedToDisplay.remove(at: sender.tag)
            
            
            
        }
            
        else {
            nameRemoved = MyRssFeedToDisplay[sender.tag].name!
            MyRssFeedToDisplay.remove(at: sender.tag)
            
        }
        
        
        
        
        
        
        var rssnames1 = [String]()
        var rssurls1 = [String]()
        
        
        for i in 0 ..< MyRssFeedToDisplay.count
        {
            
            if(MyRssFeedToDisplay[i].name !=  nameRemoved){
                rssnames1.append(MyRssFeedToDisplay[i].name!)
                rssurls1.append(MyRssFeedToDisplay[i].url!)
            }
            
            
        }
        
        
        
        userdefaults.set(rssnames1, forKey: "rssnames")
        userdefaults.set(rssurls1, forKey: "rssurls")
        
        
        
        userdefaults.synchronize()
        
        MyRssFeedToDisplay.removeAll()
        
        for i in 0 ..< rssnames1.count
        {
            
            let rss1 = RssFeed()
            rss1.name = rssnames1[i]
            rss1.url = rssurls1[i]
            MyRssFeedToDisplay.append(rss1)
            
        }
        
        
        
        collectionView.reloadData()
        
        
        
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
        if (isSearching){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rssFeeded1ViewController = storyBoard.instantiateViewController(withIdentifier: "RssFeeded1ViewController") as! RssFeeded1ViewController
            
            rssFeeded1ViewController.urlString = filtredMyRssFeedToDisplay[indexPath.row].url!
            self.present(rssFeeded1ViewController, animated: true, completion: nil)
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let rssFeeded1ViewController = storyBoard.instantiateViewController(withIdentifier: "RssFeeded1ViewController") as! RssFeeded1ViewController
            
            rssFeeded1ViewController.nameString = MyRssFeedToDisplay[indexPath.row].name!
            rssFeeded1ViewController.urlString = MyRssFeedToDisplay[indexPath.row].url!
            self.present(rssFeeded1ViewController, animated: true, completion: nil)
        }
        
        
        
        
        
        
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            view.endEditing(true)
            collectionView.reloadData()
        }
            
        else{
            isSearching = true
            
            filtredMyRssFeedToDisplay = MyRssFeedToDisplay.filter{ ($0.name?.uppercased().contains(searchText.uppercased()))! }}
        collectionView.reloadData()
        
        
    }
    
    
    
    
    @IBAction func goToAddRss(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addViewController = storyBoard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        
        self.present(addViewController, animated: true, completion: nil)
        
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
    
    
    func LoadmyRssFeeds(){
        
        
        
        
        var myrssNamesArray = userdefaults.stringArray(forKey: "rssnames") ?? [String]()
        var myrssUrlArray = userdefaults.stringArray(forKey: "rssurls") ?? [String]()
        
        
        
        for i in 0 ..< myrssNamesArray.count
        {
            
            let rss1 = RssFeed()
            rss1.name = myrssNamesArray[i]
            rss1.url = myrssUrlArray[i]
            MyRssFeedToDisplay.append(rss1)
            
        }
        
        self.collectionView.reloadData()
        
    }
    
    
    
    
    
    
    
}
