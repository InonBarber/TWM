import UIKit
import SwiftUI

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    let standartUserDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var choosePhotoBtn: UIButton!
    
    
    var email: String = ""
    var emailPosts: [String]? = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    var image : UIImage?
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        self.img.image = image
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
    
    private func createPost(user: User) {
                            
        let post = Post()        
        post.title = self.titleTextField.text ?? ""
        post.description = self.descriptionTextField.text ?? ""
        post.userId = user.email
        if let image = self.image {
            Model.instance.uploadImage(image: image) { [weak self] url in
                post.photo = url
                self?.uploadPost(post: post, user: user)
            }
        }else{
            post.photo = ""
            uploadPost(post: post, user: user)
        }
    
    }
    
    private func uploadPost(post: Post, user: User) {
        //TODO: remove posts object from user and create an identifer (user id) inside the post.
        Model.instance.addPost(post: post){
            self.emailPosts?.append(post.id)
            Model.instance.updateUserPosts(user: user, posts: self.emailPosts!) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        saveBtn.isEnabled = false
        choosePhotoBtn.isEnabled = false
        titleTextField.isEnabled = false
        descriptionTextField.isEnabled = false
        
        
        let post = Post()
        post.id = UUID().uuidString
        if self.validTitle(title: self.titleTextField.text!) == false{
            self.alert(title: "Post faild to upload", msg: "Please add title")
        }else if self.validDescription(description: self.descriptionTextField.text!) == false {
            self.alert(title: "Post faild to upload", msg: "Please add description")
        }
        
        else{
            Model.instance.getUserDetails(){ [weak self] result in
                switch result {
                case .success(let user):
                    self?.createPost(user: user)
                case .failure(let error):
                    //TODO: add error handling
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
}
