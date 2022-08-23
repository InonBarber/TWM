

import UIKit

class FeedTableViewController: UITableViewController {

    var data = [Post]()
    
    enum FeedType {
        case all
        case myFeeds
    }
    
    
    func updateData(feedType: FeedType) {
        switch feedType {
        case .all:
            Model.instance.getAllPosts { [weak self] posts in
                self?.data = posts
                self?.tableView.reloadData()
            }
        case .myFeeds:
            if let user = Model.instance.user {
                Model.instance.getUserPosts(userId: user.email) { [weak self] posts in
                    self?.data = posts
                    self?.tableView.reloadData()
                }
            }
            
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
        cell.configureCell(post: item)
        return cell
    }
    
    var selectedRow = 0
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Selcted row at \(indexPath.row)")
        selectedRow = indexPath.row
        performSegue(withIdentifier: "openPostDetails", sender: self)
        
        
    }
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "openPostDetails"){
            let dvc = segue.destination as! PostDetailsViewController
            let st = data[selectedRow]
            dvc.post = st
        }
    }
    

}
