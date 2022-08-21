//
//  Created by Naum Raviz on 19/08/2022.
//

import UIKit

class PostDetailsViewController: UIViewController {

    var post:Post?{
        didSet{
            if(idLabel != nil){
                idLabel.text = post?.id
                nameLabel.text = post?.email
            }
        }
    }
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            idLabel.text = post.id
            nameLabel.text = post.email
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
