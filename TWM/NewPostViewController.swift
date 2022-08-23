import UIKit
import SwiftUI

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    let standartUserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var choosePhotoBtn: UIButton!
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!
    
    var email: String = ""
    var emailPosts: [String]? = []
    var image : UIImage?
    var imageUpdated = false
    var post: Post?
    
    func editPost(post: Post) {
        self.post = post
    }
    
    private func updatePostInfo() {
        guard let post = post else {
            return
        }
        
        imageLoader.isHidden = false
        imageLoader.startAnimating()

        if let photo = post.photo, let url = URL(string: photo) {
            img.load(url: url) { [weak self] in
                self?.imageLoader.stopAnimating()
            }
        }
        
        titleTextField.text = post.title
        descriptionTextField.text = post.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePostInfo()
    }
    
    func choosePicture(source: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(source){
            self.present(picker,animated: true,completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        self.img.image = image
        imageUpdated = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func alert(title: String, msg: String){
        saveBtn.isEnabled = true
        titleTextField.isEnabled = true
        descriptionTextField.isEnabled = true
        choosePhotoBtn.isEnabled = true
        
        
        let alertC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertC.addAction(okBtn)
        ViewController().dismiss(animated: false){ () -> Void in
            self.present(alertC, animated: true, completion: nil)
        }
        
    }
    
    func validTitle(title: String) -> Bool{
        if title.count > 0 {
            return true
        }
        return false
    }
    
    func validDescription(description: String) -> Bool{
        if description.count == 0 {
            return false
        }
        return true
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        choosePicture(source:.photoLibrary)
    }
    
    private func updatePost(post: Post) {
        post.title = self.titleTextField.text ?? post.title ?? ""
        post.description = self.descriptionTextField.text ?? post.description ?? ""
        if let image = self.image, imageUpdated {
            imageUpdated = false
            Model.instance.uploadImage(image: image) { [weak self] url in
                post.photo = url
                self?.uploadUpdatedPost(post: post)
            }
        }else{
            post.photo = ""
            uploadUpdatedPost(post: post)
        }
    }
    
    private func uploadUpdatedPost(post: Post) {
        Model.instance.updatePost(postId: post.id, post: post) { [weak self] success in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func createPost() {
        
        guard let email = Model.instance.email else { return }
                            
        let post = Post()        
        post.title = self.titleTextField.text ?? ""
        post.description = self.descriptionTextField.text ?? ""
        post.userId = email
        if let image = self.image {
            Model.instance.uploadImage(image: image) { [weak self] url in
                post.photo = url
                self?.uploadPost(post: post)
            }
        }else{
            post.photo = ""
            uploadPost(post: post)
        }
    
    }
    
    private func uploadPost(post: Post) {
        //TODO: remove posts object from user and create an identifer (user id) inside the post.
        Model.instance.addPost(post: post) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        saveBtn.isEnabled = false
        choosePhotoBtn.isEnabled = false
        titleTextField.isEnabled = false
        descriptionTextField.isEnabled = false
        
        if self.validTitle(title: self.titleTextField.text!) == false {
            self.alert(title: "Post faild to upload", msg: "Please add title")
        } else if self.validDescription(description: self.descriptionTextField.text!) == false {
            self.alert(title: "Post faild to upload", msg: "Please add description")
        } else if let post = self.post {
            updatePost(post: post)
        } else {
            createPost()
        }
    }
}
