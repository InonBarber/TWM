//
//  Created by Naum Raviz on 19/08/2022.
//

import UIKit
import Kingfisher

class PostDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var editPostBtn: UIButton!
    
    var post:Post?{
        didSet{
            if(titleTxt != nil){
                updateDisplay()
            }
        }
    }
    
    func updateDisplay(){
        titleTxt.text = post?.title
        descriptionTxt.text = post?.description

        if let urlStr = post?.photo {
            if (!urlStr.elementsEqual("505579")){
                let url = URL(string: urlStr)
                img?.kf.setImage(with: url)
            }else{
                img.image = UIImage(named: "505579")
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if post != nil {
            updateDisplay()
        }
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
