import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {




    @IBOutlet weak var postImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func save(_ sender: Any) {
        let post = Post(name: nameTv.text, id: idTv.text, avatarUrl: "")
        Model.instance.add(post: post)
        self.navigationController?.popViewController(animated: true)
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
