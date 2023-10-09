
import Foundation
import CoreLocation
import MapKit
import SwiftUI

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        determineCurrentLocation()
        
        return locationManager.location?.coordinate
    }
    
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
            
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

