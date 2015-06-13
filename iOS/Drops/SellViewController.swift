//
//  SSSellViewController.swift
//  swagswap
//
//  Created by Logan Isitt on 3/10/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import FontAwesomeKit

class SellViewController: UICollectionViewController {
        
    var listings: [Listing] = [Listing]()
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Listings"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView!.registerNib(UINib(nibName: "ListingCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Cell")
                
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.addButton(target: self, selector: "addButtonAction")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addButtonAction() {
        self.performSegueWithIdentifier("gotoCreate", sender: self)
    }
    
    // MARK: - UICollectionView Data Source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: ListingCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ListingCell
        
        let listing = listings[indexPath.row]
        
        var path = listing.imagePaths[0].substringFromIndex(advance(listing.imagePaths[0].startIndex, 8))
        
        let url = NSURL(string: Client.sharedInstance.baseUrl + path)!
        
        cell.imageView.hnk_setImageFromURL(url)
//        cell.titleText.text = listing.name
//        cell.priceText.text = "$\(listing.price)"
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("gotoListing", sender: self)
    }
    
    // MARK: - UIColectionView Flow Layout Delegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = collectionView.bounds.width / 2.0
        return CGSizeMake(height, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    // MARK: - UIViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoListing" {
            let vc = segue.destinationViewController as! ListingViewController
            let index = collectionView!.indexPathsForSelectedItems()[0].row
            vc.listing = listings[index!]
        }
    }
}