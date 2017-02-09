//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Toph on 1/23/17.
//  Copyright © 2017 Toph. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: CustomUITextField!
    @IBOutlet var serialNumberField: CustomUITextField!
    @IBOutlet var valueField: CustomUITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var imageStore: ImageStore!
    
    var item: Item! {
        
        didSet {
            
            navigationItem.title = item.name
            
        }
        
    }
    
    let numberFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
        
    }()
    
    let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
         // Grab item key
        let key = item.itemKey
        
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        // Save changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            
            item.valueInDollars = value.intValue
            
        }
        
        else {
            
            item.valueInDollars = 0
            
        }
        
    }
            
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        print("reg")
        
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get picked image from info dict.
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Store the image in the ImageStore for the item's key
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        // Put that image on the screen in the image view
        imageView.image = image
        
        // Take your image picker off the screen -
        // Below method must be called
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        
        // If the device has a camera, take a picture;
        // otherwise, just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            imagePicker.sourceType = .camera
            
        }
        else {
            
            imagePicker.sourceType = .photoLibrary
            
        }
        
        imagePicker.delegate = self
        
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
}

