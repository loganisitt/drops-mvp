//
//  SSListingViewController.swift
//  swagswap
//
//  Created by Logan Isitt on 3/21/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import ObjectMapper

import PureLayout
import MaterialKit

class ListingViewController: UIViewController, UIScrollViewDelegate,
UICollectionViewDataSource, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    let shadowOffset = CGSize(width: -2, height: 2)
    
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    
    var titleLabel: MKLabel!
    var priceLabel: MKLabel!
    
    var descView: UITextView!
    
    var offerButton: SNButton!
    var messageButton: SNButton!
        
    var listing: Listing! {
        didSet {
        }
    }
    
    // MARK: - General
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Listing"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.watchButton(target: self, selector: "watchButtonAction")
        
        setupViews()
        layout()
    }
    
    // MARK: - Actions
    
    func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func sendMessage(content: String) {
        
        var message: Message = Message()
        
        message.sender = Client.sharedInstance.currentUser
        message.recipient = listing.seller
        message.text = content
    }
    
    func watchButtonAction() {
        Client.sharedInstance.watch(listing)
    }
    
    func offerButtonAction() {
        
//        if listing.seller == Client.sharedInstance.currentUser {
//            return
//        }
        
        let alertController = UIAlertController(title: "Current price: \(priceLabel.text!)", message: nil, preferredStyle: .Alert)
        
        let offerAction = UIAlertAction(title: "Make an Offer", style: .Default) { (_) in
            Client.sharedInstance.makeBid(self.listing)
        }
        offerAction.enabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
            textField.placeholder = self.priceLabel.text
            
            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                offerAction.enabled = textField.text != ""
            }
        }
        
        alertController.addAction(offerAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Views
    func setupViews() {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.pagingEnabled = true
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsHorizontalScrollIndicator = false
        
        pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = count(listing.imagePaths)
        pageControl.currentPageIndicatorTintColor = UIColor.thrift_green()
        pageControl.pageIndicatorTintColor = UIColor.thrift_gray()
        
        titleLabel = MKLabel()
        titleLabel.text = listing.name
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = .Left
        titleLabel.font = UIFont.boldSystemFontOfSize(20)
        titleLabel.backgroundLayerColor = UIColor.clearColor()
        
        titleLabel.layer.cornerRadius = 0
        titleLabel.layer.shadowOpacity = 0.55
        titleLabel.layer.shadowRadius = 0
        titleLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        titleLabel.layer.shadowOffset = CGSizeMake(-1, 1)
        
        priceLabel = MKLabel()
        priceLabel.text = NSString(format: "$%.2f", listing.price) as String
        priceLabel.textColor = UIColor.blackColor()
        priceLabel.textAlignment = .Right
        priceLabel.font = UIFont.boldSystemFontOfSize(20)
        priceLabel.backgroundLayerColor = UIColor.clearColor()
        
        priceLabel.layer.cornerRadius = 0
        priceLabel.layer.shadowOpacity = 0.55
        priceLabel.layer.shadowRadius = 0
        priceLabel.layer.shadowColor = UIColor.whiteColor().CGColor
        priceLabel.layer.shadowOffset = CGSizeMake(-1, 1)
        
        descView = UITextView()
        descView.text = listing.description
        descView.textColor = UIColor.blackColor()
        descView.font = UIFont.boldSystemFontOfSize(16)
        
        descView.layer.cornerRadius = 0
        descView.layer.shadowOpacity = 0.55
        descView.layer.shadowRadius = 0
        descView.layer.shadowColor = UIColor.whiteColor().CGColor
        descView.layer.shadowOffset = CGSizeMake(-1, 1)
        
        messageButton = SNButton()
        messageButton.hasIcon = false
        messageButton.setTitle("Message", forState: .Normal)
        messageButton.backgroundColor = UIColor.thrift_blue()
        
        messageButton.addTarget(self, action: "signupButtonAction", forControlEvents: .TouchUpInside)
        
        offerButton = SNButton()
        offerButton.hasIcon = false
        offerButton.setTitle("Make Offer", forState: .Normal)
        offerButton.backgroundColor = UIColor.thrift_orange()
        
        offerButton.addTarget(self, action: "offerButtonAction", forControlEvents: .TouchUpInside)
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(messageButton)
        view.addSubview(offerButton)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(descView)
    }
    
    func layout() {
        
        collectionView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        collectionView.autoPinEdgeToSuperviewEdge(.Left)
        collectionView.autoPinEdgeToSuperviewEdge(.Right)
        collectionView.autoSetDimension(.Height, toSize: view.bounds.height / 2.0)
        
        pageControl.autoPinEdge(.Top, toEdge: .Bottom, ofView: collectionView, withOffset: -16)
        pageControl.autoPinEdgeToSuperviewEdge(.Left)
        pageControl.autoPinEdgeToSuperviewEdge(.Right)
        pageControl.autoSetDimension(.Height, toSize: 0)
        
        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: pageControl, withOffset: 16)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 8)
        titleLabel.autoSetDimension(.Height, toSize: 25)
        
        priceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: pageControl, withOffset: 16)
        priceLabel.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel, withOffset: 8)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 8)
        priceLabel.autoSetDimension(.Height, toSize: 25)
        priceLabel.autoSetDimension(.Width, toSize: 100)
        
        descView.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 8)
        descView.autoPinEdgeToSuperviewEdge(.Left, withInset: 8)
        descView.autoPinEdgeToSuperviewEdge(.Right, withInset: 8)
        
        offerButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: descView, withOffset: 8)
        offerButton.autoPinEdgeToSuperviewEdge(.Right)
        offerButton.autoPinEdge(.Left, toEdge: .Right, ofView: messageButton)
        offerButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: 8)
        offerButton.autoSetDimension(.Height, toSize: 50)
        
        messageButton.autoPinEdgeToSuperviewEdge(.Left)
        messageButton.autoPinToBottomLayoutGuideOfViewController(self, withInset: 8)
        messageButton.autoSetDimension(.Height, toSize: 50)
        
        offerButton.autoMatchDimension(.Width, toDimension: .Width, ofView: messageButton)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count(listing.imagePaths)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundView = MKImageView()
        
        (cell.backgroundView as! MKImageView).rippleLayerColor = UIColor.grayColor()
        (cell.backgroundView as! MKImageView).contentMode = .ScaleAspectFit

        (cell.backgroundView as! MKImageView).layer.cornerRadius = 0
        (cell.backgroundView as! MKImageView).layer.shadowOpacity = 0.55
        (cell.backgroundView as! MKImageView).layer.shadowRadius = 0
        (cell.backgroundView as! MKImageView).layer.shadowColor = UIColor.blackColor().CGColor
        (cell.backgroundView as! MKImageView).layer.shadowOffset = shadowOffset
        
        cell.backgroundView?.autoPinEdgesToSuperviewMargins()
        
        var path = listing.imagePaths[indexPath.row].substringFromIndex(advance(listing.imagePaths[indexPath.row].startIndex, 8))
        
        let url = NSURL(string: Client.sharedInstance.baseUrl + path)!
        
        (cell.backgroundView as! MKImageView).hnk_setImageFromURL(url)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zeroSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zeroSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    // MARK: - UIScrollViewDelegate 
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width;
        pageControl.currentPage = Int(collectionView.contentOffset.x / pageWidth);
    }
}