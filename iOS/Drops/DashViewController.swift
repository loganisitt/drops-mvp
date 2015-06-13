//
//  DashViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import PureLayout
import Haneke
import MaterialKit

import FontAwesomeKit

class DashViewController: UIViewController,
ClientDelegate,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
//, UITableViewDelegate, UITableViewDataSource {
{
    let shadowOffset = CGSize(width: -2, height: 2)

    var collectionView: UICollectionView!

    var listings: [Listing] = [Listing]()
    var listingImages: [UIImage?]!
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Client 
        Client.sharedInstance.delegate = self
        Client.sharedInstance.getAllListings()
        
        navigationController?.navigationBar.hidden = false
        
        navigationItem.title = "Dash"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem.searchButton(target: self, selector: "searchButtonAction")
        
        navigationController?.setToolbarHidden(false, animated: false)
        
        setupViews()
        
        layoutSubviews()
    }
    
    // MARK: - Views
    
    func setupViews() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(ListingCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.backgroundColor = UIColor.whiteColor()

        view.addSubview(collectionView)
    }
    
    // MARK: - Layout
    
    func layoutSubviews() {
        
        collectionView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        collectionView.autoPinEdgeToSuperviewEdge(.Right)
        collectionView.autoPinEdgeToSuperviewEdge(.Left)
        collectionView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - Actions
    
    func searchButtonAction() {
        self.performSegueWithIdentifier("gotoSearch", sender: self)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count(listings)
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: ListingCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ListingCell
        
        let obj = listings[indexPath.row] as Listing
        
        if let image = listingImages[indexPath.row] {
            (cell.backgroundView as! MKImageView).image = image
        }

        cell.titleLabel.text = obj.name
        cell.priceLabel.text = "$\(obj.price)"
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("gotoListing", sender: self)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let dim = (collectionView.bounds.width / 2.0)
        
        if let image = listingImages[indexPath.row] {
            return image.imageResizedtoTargetSize(CGSize(width: dim, height: dim)).size
        }
        return CGSizeMake(dim, dim)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
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
    
    // MARK: - ClientDelegate
    func receivedListings(listings: [Listing]) {
        self.listings = listings
        
        listingImages = [UIImage?](count: count(listings), repeatedValue: UIImage().imageWithColor(UIColor.thrift_gray()))

        for var i = 0; i < count(listings); i++ {
            
            var obj = listings[i]
            var path = obj.imagePaths[0].substringFromIndex(advance(obj.imagePaths[0].startIndex, 8))
            let url = Client.sharedInstance.baseUrl + path
            
            ImageLoader.sharedLoader.imageForUrl(url, index: i, completionHandler: { (image, url, index) -> () in
                self.listingImages[index] = image
                
                self.collectionView.reloadItemsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)])
            })
        }
        
        collectionView.reloadData()
    }
    
    // MARK: - UIViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoListing" {
            let vc = segue.destinationViewController as! ListingViewController
            let index = collectionView.indexPathsForSelectedItems()[0].row
            vc.listing = listings[index!]
        }
    }
}