//
//  FirstTableViewController.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/21/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    @IBOutlet weak var usersSearchBar: UISearchBar!
    @IBOutlet weak var sortButton: UIButton!
    
    var originalUsers = dataManager.getData()
    var users = dataManager.getData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        usersSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UserTableCell.")
        }
        
        let user:User = users[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.addressLabel.text = "\(user.address.street) \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
        let url = URL(string:user.avatar)!
        downloadImage(from: url, imageAvatar: cell.imageAvatar)
        cell.companyNameLabel.text = "Company: \(user.company.name)"
        
        //print(indexPath.row)
        
        
        return cell
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, imageAvatar:UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageAvatar.image = UIImage(data: data)
            }
        }
    }
    
    var userForDetails:User!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FirstToDetailsSegue") {
            /*
             if let nextViewController = segue.destination as? NextViewController {
             nextViewController.valueOfxyz = "XYZ" //Or pass any values
             nextViewController.valueOf123 = 123
             }
             */
            if let detailsController =  segue.destination as? DetailsViewController{
                
                detailsController.user = userForDetails
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        
        userForDetails = users[indexPath.row]
        
        performSegue(withIdentifier: "FirstToDetailsSegue", sender: self)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //print(searchText)
        
        users = searchText.isEmpty ? originalUsers : originalUsers.filter({(user:User) -> Bool in
            // If dataItem matches the searchText, return true to include it
            //return dataString.range(of: searchText, options: .caseInsensitive) != nil
            return (user.name.range(of: searchText, options: .caseInsensitive) != nil) ||
                (user.address.street.range(of: searchText, options: .caseInsensitive) != nil) ||
                (user.address.city.range(of: searchText, options: .caseInsensitive) != nil) ||
                (user.company.name.range(of: searchText, options: .caseInsensitive) != nil)
        })
        //print(users.count)
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    var sortedAsc = false
    
    @IBAction func onSortButtonTouchUpInside(_ sender: Any) {
        if(sortedAsc == false){
            users.sort{$0.name<$1.name}
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
            sortedAsc = true
            
            sortButton.setTitle("SORT DESC", for: .normal)
        } else {
            users.sort{$0.name>$1.name}
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
            sortedAsc = false
            sortButton.setTitle("SORT ASC", for: .normal)
        }
        //print("SORTIRAM")
        
    }
    
    
    
}
