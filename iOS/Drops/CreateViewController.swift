//
//  CreateViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

import MaterialKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    let shadowOffset = CGSize(width: -2, height: 2)
    
    var categoryViewController: CategoryViewController!
    
    var nameField: MKTextField!
    var priceField: MKTextField!
    
    var categoryField: SNButton!
    var addImgBtn: SNButton!
    
    var descView: UITextView!
    
    var imgCollection: UICollectionView!
    
    var imgArray: [UIImage]!
    var category: Category!
    
    // MARK: - View
    override func viewDidLoad() {
        
        self.navigationItem.title = "Create"
        
        imgArray = []
        
        let singleTap = UITapGestureRecognizer(target: self, action: "resignFirstResponders")
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.backButton(target: self, selector: "backButtonAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.saveButton(target: self, selector: "saveButtonAction")
        
        setupViews()
        layout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if categoryViewController != nil {
            if categoryViewController.selected != nil {
                category = categoryViewController.selected
                categoryField.backgroundColor = UIColor(rgba: categoryViewController.selected.color)
                categoryField.setTitle("\(categoryViewController.selected.name): \(categoryViewController.selected.subcategory)", forState: UIControlState.Normal)
            }
        }
    }
    
    // MARK: Views
    
    func setupViews() {
        
        let padding = CGSizeMake(21, 21)
        
        nameField = MKTextField()
        
        nameField.layer.borderColor = UIColor.clearColor().CGColor
        nameField.floatingPlaceholderEnabled = true
        nameField.placeholder = "Name"
        nameField.rippleLayerColor = UIColor.grayColor()
        nameField.backgroundColor = UIColor(hex: 0xEEEEEE)
        nameField.padding = padding
        nameField.layer.cornerRadius = 0
        nameField.bottomBorderEnabled = true
        nameField.bottomBorderHighlightWidth = nameField.bottomBorderWidth
        nameField.tintColor = nameField.bottomBorderColor
        
        priceField = MKTextField()
        
        priceField.layer.borderColor = UIColor.clearColor().CGColor
        priceField.floatingPlaceholderEnabled = true
        priceField.placeholder = "Price"
        priceField.rippleLayerColor = UIColor.grayColor()
        priceField.backgroundColor = UIColor(hex: 0xEEEEEE)
        priceField.padding = padding
        priceField.layer.cornerRadius = 0
        priceField.bottomBorderEnabled = true
        priceField.bottomBorderHighlightWidth = priceField.bottomBorderWidth
        priceField.tintColor = priceField.bottomBorderColor

        descView = UITextView()
        
        descView.layer.borderColor = UIColor.clearColor().CGColor
        descView.backgroundColor = UIColor(hex: 0xEEEEEE)
        descView.layer.cornerRadius = 0
        descView.tintColor = priceField.bottomBorderColor
        
        categoryField = SNButton()
        categoryField.hasIcon = false
        categoryField.setTitle("Category", forState: .Normal)
        categoryField.backgroundColor = UIColor.thrift_blue()
        categoryField.addTarget(self, action: "showCategoryViewController", forControlEvents: .TouchUpInside)
        
        addImgBtn = SNButton()
        addImgBtn.hasIcon = false
        addImgBtn.setTitle("Add Photos", forState: .Normal)
        addImgBtn.backgroundColor = UIColor.thrift_blue()
        addImgBtn.addTarget(self, action: "showImageSourcePicker", forControlEvents: .TouchUpInside)

        // imgCollection
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        
        imgCollection = UICollectionView(frame: CGRect.zeroRect, collectionViewLayout: layout)
        
        imgCollection.delegate = self
        imgCollection.dataSource = self
        
        imgCollection.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        imgCollection.pagingEnabled = true
        
        imgCollection.backgroundColor = UIColor.clearColor()
        
        view.addSubview(nameField)
        view.addSubview(categoryField)
        view.addSubview(priceField)
        view.addSubview(descView)
        view.addSubview(addImgBtn)
        view.addSubview(imgCollection)
    }
    
    // MARK: - Layout
    
    func layout() {
        
        nameField.autoPinToTopLayoutGuideOfViewController(self, withInset: 8)
        nameField.autoPinEdgeToSuperviewEdge(.Left)
        nameField.autoPinEdgeToSuperviewEdge(.Right)
        nameField.autoSetDimension(.Height, toSize: 50)
        
        priceField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameField)
        priceField.autoPinEdgeToSuperviewEdge(.Left)
        priceField.autoPinEdgeToSuperviewEdge(.Right)
        priceField.autoSetDimension(.Height, toSize: 50)
        
        descView.autoPinEdge(.Top, toEdge: .Bottom, ofView: priceField, withOffset: 8)
        descView.autoPinEdgeToSuperviewEdge(.Left)
        descView.autoPinEdgeToSuperviewEdge(.Right)
        
        categoryField.autoPinEdge(.Top, toEdge: .Bottom, ofView: descView, withOffset: 8)
        categoryField.autoPinEdgeToSuperviewEdge(.Left)
        categoryField.autoPinEdgeToSuperviewEdge(.Right)
        categoryField.autoSetDimension(.Height, toSize: 50)
        
        addImgBtn.autoPinEdge(.Top, toEdge: .Bottom, ofView: categoryField, withOffset: 8)
        addImgBtn.autoPinEdgeToSuperviewEdge(.Left)
        addImgBtn.autoPinEdgeToSuperviewEdge(.Right)
        addImgBtn.autoSetDimension(.Height, toSize: 50)
        
        imgCollection.autoPinEdge(.Top, toEdge: .Bottom, ofView: addImgBtn, withOffset: 8)
        imgCollection.autoPinEdgeToSuperviewEdge(.Left)
        imgCollection.autoPinEdgeToSuperviewEdge(.Right)
        imgCollection.autoPinToBottomLayoutGuideOfViewController(self, withInset: 8)
        
        descView.autoMatchDimension(.Height, toDimension: .Height, ofView: imgCollection)
    }
    
    // MARK: - Actions
    
    func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func dismissButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showImageSourcePicker() {
        
        var imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.navigationBar.hideHairline()
        imagePickerController.navigationBar.addShadows()
        imagePickerController.navigationBar.translucent = false
        imagePickerController.navigationBar.barTintColor = navigationController?.navigationBar.barTintColor
        imagePickerController.navigationBar.tintColor = navigationController?.navigationBar.tintColor
        imagePickerController.navigationBar.titleTextAttributes = navigationController?.navigationBar.titleTextAttributes
        
        let sourceAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction!) -> Void in
            //
        }
        
        sourceAlertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            //
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
        sourceAlertController.addAction(cameraAction)
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
        sourceAlertController.addAction(libraryAction)
        
        self.presentViewController(sourceAlertController, animated: true, completion: nil)
    }
    
    func showCategoryViewController() {
        
        if (categoryViewController == nil) {
            categoryViewController = CategoryViewController()
        }
        
        let navController = UINavigationController(rootViewController: categoryViewController)
        
        navController.navigationBar.hideHairline()
        navController.navigationBar.addShadows()
        navController.navigationBar.translucent = false
        navController.navigationBar.barTintColor = navigationController?.navigationBar.barTintColor
        navController.navigationBar.tintColor = navigationController?.navigationBar.tintColor
        navController.navigationBar.titleTextAttributes = navigationController?.navigationBar.titleTextAttributes
        
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    @IBAction func resignFirstResponders() {
        
        for v in view.subviews {
            if v.isFirstResponder() {
                v.resignFirstResponder()
            }
        }
    }
    
    @IBAction func saveButtonAction() {
        
        if (!nameField.text.isEmpty && !priceField.text.isEmpty && !descView.text.isEmpty && imgArray.count > 0 && categoryViewController.selected != nil) {
            
            let param = [
                "seller"  : Client.sharedInstance.currentUser.id,
                "category"    : category.id,
                "name"    : self.nameField.text,
                "description"    : descView.text,
                "price" : NSNumber(double: (priceField.text as NSString).doubleValue)]
            
            Client.sharedInstance.createListing(param, imgPaths: saveLocally(imgArray))
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let size = CGSizeMake(1024, 1024)
        
        let scaled: UIImage = tempImage.imageResizedtoTargetSize(size)
        
        imgArray.append(scaled)
        
        imgCollection.reloadData()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count(imgArray)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundView = MKImageView()
        
        (cell.backgroundView as! MKImageView).rippleLayerColor = UIColor.grayColor()
        
        (cell.backgroundView as! MKImageView).layer.cornerRadius = 0
        (cell.backgroundView as! MKImageView).layer.shadowOpacity = 0.55
        (cell.backgroundView as! MKImageView).layer.shadowRadius = 0
        (cell.backgroundView as! MKImageView).layer.shadowColor = UIColor.blackColor().CGColor
        (cell.backgroundView as! MKImageView).layer.shadowOffset = shadowOffset

        
        cell.backgroundView?.autoPinEdgesToSuperviewMargins()
        (cell.backgroundView as! MKImageView).image = imgArray[indexPath.row]
        
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
        
        var img = imgArray[indexPath.row].imageResizedtoTargetSize(CGSize(width: imgCollection.bounds.height, height: imgCollection.bounds.height))

        return CGSize(width: CGImageGetWidth(img.CGImage), height: CGImageGetHeight(img.CGImage))
    }
    
    // MARK: - Saving
    
    func saveLocally(images: [UIImage]) -> [String] {
        
        let fileManager = NSFileManager.defaultManager()
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        var urls = [] as [String]
        
        for var i = 0; i < images.count; i++ {
            
            var filePathToWrite = "\(paths)/image\(i).png"
            
            var imageData = UIImagePNGRepresentation(images[i])
            
            NSFileManager.defaultManager().createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
            
            fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
            
            var getImagePath = paths.stringByAppendingPathComponent("image\(i).png") as String
            
            urls.append(getImagePath)
        }
        return urls
    }
}
