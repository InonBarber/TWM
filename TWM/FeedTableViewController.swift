

import UIKit

class FeedTableViewController: UITableViewController {

    var data = [Post]()
    private var feedType: FeedType?
    
    enum FeedType {
        case all
        case myFeeds
    }
    
    
    func updateData(feedType: FeedType) {
        self.feedType = feedType
        switch feedType {
        case .all:
            Model.instance.getAllPosts { [weak self] posts in
                self?.data = posts
                self?.tableView.reloadData()
            }
        case .myFeeds:
            if let email = Model.instance.email {
                Model.instance.getUserPosts(userId: email) { [weak self] posts in
                    self?.data = posts
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let feedType = feedType {
            updateData(feedType: feedType)
        }        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
        let item = data[indexPath.row]
        cell.configureCell(post: item, index: indexPath.row)
        return cell
    }
        
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPost", let vc = segue.destination as? NewPostViewController, let button = sender as? UIButton {
            let index = button.tag
            let data = data[index]
            vc.editPost(post: data)
        }
    }
    

}
