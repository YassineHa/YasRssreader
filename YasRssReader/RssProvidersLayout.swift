//
//  RssProvidersLayout.swift
//  AlamofireRSSParser
//
//  Created by Yassine-Ha on 28/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class RssProvidersLayout: UICollectionViewFlowLayout {
    
    
    var numberOfColumns:Int = 2;
    
    
    
    init(numberOfColumns:Int) {
        super.init();
        self.numberOfColumns = numberOfColumns;
        self.minimumInteritemSpacing = 1;
        self.minimumLineSpacing = 10;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize{
        
        get {
            
            if let collectionView = collectionView {
                
                let collectionViewWidth = collectionView.frame.width;
                let itemWidth = (collectionViewWidth/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing;
                let itemHeight: CGFloat = 100;
                
                return CGSize(width: itemWidth, height: itemHeight);
            }
            return CGSize(width: 100,height: 100);
            
        }
        
        set {
            
            super.itemSize = newValue;
        }
    }
    

}
