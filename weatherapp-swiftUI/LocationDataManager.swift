//
//  LocationDataManager.swift
//  weatherapp-swiftUI
//
//  Created by Jagdeep Singh on 12/05/24.
//

import Foundation
import CoreLocation

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees,  completion: @escaping (String) -> ()){
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: latitude, longitude: longitude)
            var cityName = "Not found"
            geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Failed to retrieve address")
                    
                    return
                }
                
                if let placemarks = placemarks, let placemark = placemarks.first {
                    print("asasasasas \(placemark.locality)")
                    cityName = placemark.locality ?? "Not found"
                    completion(placemark.locality ?? "")
                }
                else
                {
                    print("No Matching Address Found")
                }
            })
            
        }
    
    
}
