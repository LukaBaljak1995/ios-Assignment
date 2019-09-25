//
//  SecondViewController.swift
//  iosAssignment
//
//  Created by Luka Baljak on 9/19/19.
//  Copyright © 2019 Luka Baljak. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate {

    //MARK:Properties
    @IBOutlet weak var mapKitView: MKMapView!
    var users:[User] = []
    var userForDetails:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        users = dataManager.getData()
        loadMap()
        mapKitView.delegate=self
    }
    
    func loadMap(){
        for user in users {
            
            let name = user.name
            
            if let lat = Double(user.address.geo.lat), let lng = Double(user.address.geo.lng){
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                annotation.title=name
                
                mapKitView.addAnnotation(annotation)
            }
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SecondToDetailsSegue") {
            
            if let detailsController =  segue.destination as? DetailsViewController{
                
                detailsController.user = userForDetails
            }
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let lat = view.annotation?.coordinate.latitude ?? 0
        let lng = view.annotation?.coordinate.longitude ?? 0
        
        print(type(of: lat))
        
        for user in users {
            if let userLat = Double(user.address.geo.lat), let userLng = Double(user.address.geo.lng){
                if(userLat==lat && userLng == lng){
                    
                    userForDetails = user
                   
                    performSegue(withIdentifier: "SecondToDetailsSegue", sender: self)
                }
            }
        }
        
    }

}

