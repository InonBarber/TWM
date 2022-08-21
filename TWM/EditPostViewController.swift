//
//  EditPostViewController.swift
//  TWM
//
//  Created by Naum Rabich on 19/08/2022.
//

import UIKit

class EditPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    

    @IBOutlet weak var descriptionBtn: UITextField!
    
    @IBOutlet weak var postImg: UIImageView!
    
    
    @IBAction func cancleBtn(_ sender: Any) {
    }
    
    @IBAction func saveBtn(_ sender: Any) {
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
    }
    
    @IBAction func openGallery(_ sender: Any) {
        
        takePicture(source: .photoLibrary)
    }
    @IBAction func openCamera(_ sender: Any) {
        
        takePicture(source: .camera)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func takePicture(source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source;
        imagePicker.allowsEditing = true
        if (UIImagePickerController.isSourceTypeAvailable(source))
        {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    var selectedImage: UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        self.postImg.image = selectedImage
        self.dismiss(animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
