//
//  SSSearchViewController.swift
//  swagswap
//
//  Created by Logan Isitt on 3/3/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController,
ClientDelegate, UISearchBarDelegate, CategoryViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var categoryViewController: CategoryViewController!
    
    var collectionView: UICollectionView!
    var searchBar: UISearchBar!

    var selectedSection: Int = -1
    
    var isSearching = false
    
    var listings: [Listing] = [Listing]() {
        didSet{
            if (searchBar.text as NSString).length == 0 {
                listings = []
            }
        }
    }
    
    // MARK: - General
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Client 
        Client.sharedInstance.delegate = self
        // Nav Bar
        navigationItem.title = "Search"
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem().SSBackButton("backButtonAction", target: self)
        
        addCategoryViewController()
        
        self.definesPresentationContext = true
        
        setupViews()
        layoutViews()
    }
    
    // MARK: - Views
    
    func setupViews() {
     
        // searchBar
        searchBar = UISearchBar()
        
        searchBar.delegate = self
        
        var img = UIImage().imageWithColor(UIColor.thrift_red())
        searchBar.setBackgroundImage(img, forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        
        // collectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerNib(UINib(nibName: "ListingCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Cell")
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func addCategoryViewController() {
        
        categoryViewController = CategoryViewController()
        categoryViewController.delegate = self
        
        addChildViewController(categoryViewController)
        
        view.addSubview(categoryViewController.tableView)
        
        categoryViewController.didMoveToParentViewController(self)
    }
    
    // MARK: - Layout
    
    func layoutViews() {
        
        let tv: UITableView = categoryViewController.tableView as UITableView
        
        searchBar.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        searchBar.autoPinEdgeToSuperviewEdge(.Left)
        searchBar.autoPinEdgeToSuperviewEdge(.Right)
        searchBar.autoSetDimension(.Height, toSize: 44)
        
        tv.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBar)
        tv.autoPinEdgeToSuperviewEdge(.Left)
        tv.autoPinEdgeToSuperviewEdge(.Right)
        tv.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        
        collectionView.autoPinEdge(.Top, toEdge: .Bottom, ofView: searchBar)
        collectionView.autoPinEdgeToSuperviewEdge(.Left)
        collectionView.autoPinEdgeToSuperviewEdge(.Right)
        collectionView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        isSearching = true
        collectionView.reloadData()
        searchBar.showsCancelButton = true
    
        view.bringSubviewToFront(collectionView)
        
        return true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchStr: String = searchBar.text
        
        if count(searchStr) >= 3 {
            Client.sharedInstance.basicSearchFor(searchStr + "*")
        }
        else {
            self.listings = []
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.listings = []
        isSearching = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        let tv: UITableView = categoryViewController.tableView as UITableView

        view.bringSubviewToFront(tv)
    }
    
//    optional func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    
    // MARK: - CategoryViewControllerDelegate
    
    func selectedCategory(category: Category) {
        self.performSegueWithIdentifier("gotoBrowse", sender: self)
    }
    
    // MARK: - UICollectionView Data Source
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: ListingCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ListingCell
        
        let listing: Listing = listings[indexPath.row] as Listing
        
        var path = listing.imagePaths[0].substringFromIndex(advance(listing.imagePaths[0].startIndex, 8))
        
        let url = NSURL(string: Client.sharedInstance.baseUrl + path)!
        
        cell.imageView.hnk_setImageFromURL(url)
//        cell.titleText.text = listing.name
//        cell.priceText.text = "$\(listing.price)"
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
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
        
        if segue.identifier == "gotoBrowse" {
            let vc = segue.destinationViewController as! BrowseViewController
            vc.category = categoryViewController.selected
        }
    }
    
    // MARK: - ClientDelegate
    
    func receivedListings(listings: [Listing]) {
        self.listings = listings
        collectionView.reloadData()
    }
}

