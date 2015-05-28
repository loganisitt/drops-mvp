//
//  CreateViewController.swift
//  Drops
//
//  Created by Logan Isitt on 5/6/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var categoryViewController: CategoryViewController!
    
    @IBOutlet var nameField:  UITextField!
    @IBOutlet var priceField: UITextField!
    
    @IBOutlet var categoryField: UIButton!
    @IBOutlet var addImgBtn:    UIButton!
    
    @IBOutlet var descView: UITextView!
    
    @IBOutlet var imgCollection: UICollectionView!
    
    var imgArray: [UIImage]!
    var category: Category!
    
    // MARK: - View
    override func viewDidLoad() {
        
        self.navigationItem.title = "Create"
        
        imgArray = []
        
        categoryField.titleLabel?.adjustsFontSizeToFitWidth = true
        
        let singleTap = UITapGestureRecognizer(target: self, action: "resignFirstResponders")
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("resignFirstResponders"))
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
        
        var saveBtn = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonAction")
        self.navigationItem.rightBarButtonItem  = saveBtn
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
        
    }
    
    // MARK: - Actions
    
    @IBAction func backButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func showImageSourcePicker() {
        
        var imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
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
    
    @IBAction func cancel() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func showCategoryViewController() {
        
        if (categoryViewController == nil) {
            categoryViewController = CategoryViewController()
        }
        
        let navController = UINavigationController(rootViewController: categoryViewController)
        
        navController.navigationBar.hideHairline()
        navController.navigationBar.translucent = false
        navController.navigationBar.barTintColor = UIColor.SSColor.Red
        navController.navigationBar.tintColor = UIColor.SSColor.White
        navController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.SSFont.H3!, NSForegroundColorAttributeName: UIColor.SSColor.White]
        
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
        
        self.imgCollection.reloadData()
        
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
        return imgArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell: ImageCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCell
        
        cell.imageView.image = imgArray[indexPath.row]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        var cgImg = imgArray[indexPath.row].og_imageAspectScaledToAtMostHeight(collectionView.bounds.size.height).CGImage
//
//        return CGSize(width: CGFloat(CGImageGetWidth(cgImg) - 10), height: CGFloat(CGImageGetHeight(cgImg) - 10))
//    }
    
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
