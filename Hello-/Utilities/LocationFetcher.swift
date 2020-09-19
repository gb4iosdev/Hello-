//
//  LocationFetcher.swift
//  Hello-
//
//  Created by Gavin Butler on 16-09-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    
    var lastKnownLongitude: String {
        guard let long = lastKnownLocation?.longitude else { return "" }
        
        return String(format: "%.2f", long)
    }
    
    var lastKnownLatitude: String {
        guard let lat = lastKnownLocation?.latitude else { return "" }
        
        return String(format: "%.2f", lat)
    }
    
    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}

