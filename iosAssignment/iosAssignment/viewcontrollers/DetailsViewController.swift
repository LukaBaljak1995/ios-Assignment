//
//  DetailsViewController.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: Properties
    var user:User=(User.init())
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bsLabel: UILabel!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:user.avatar)!
        downloadImage(from: url)
        presentData()
    }
    
    func presentData(){
        nameLabel.text = "\(user.username) (\(user.name))"
        addressLabel.text = "\(user.address.street) \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
        
        companyNameLabel.text = "\(user.company.name)"
        catchPhraseLabel.text = "\(user.company.catchPhrase)"
        bsLabel.text = "\(user.company.bs)"
        
        emailLabel.text = "\(user.email)"
        phoneNumberLabel.text = "\(user.phone)"
        websiteLabel.text = "\(user.website)"
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.avatarImageView.image = UIImage(data: data)
            }
        }
    }
    
    
    // MARK: - Navigation
    
    @IBAction func showFirstViewController(_ sender: Any) {
        //performSegue(withIdentifier: "BackToFirst", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    
    
    
    
    
}
