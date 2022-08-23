
import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var showMoreButton: UIButton!
    
    
    func configureCell(post: Post, index: Int) {
        if let photoUrl = post.photo, !photoUrl.isEmpty, let url = URL(string: photoUrl) {
            postImage.load(url: url) { [weak self] in
                self?.loader.stopAnimating()
            }
        } else {
            postImage.image = UIImage(named: "not-found")
            loader.stopAnimating()
        }
        
        titleLabel.text = post.title
        emailLabel.text = post.userId
        bodyLabel.text = post.description
        if let email = Model.instance.email, post.userId == email {
            showMoreButton.isHidden = false
            showMoreButton.tag = index
        } else {
            showMoreButton.isHidden = true
        }
    }

}


extension UIImageView {
        
    func load(url: URL, completion: @escaping () -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion()
                    }
                }
            }
        }
    }
}
