//
//  ViewController.h
//  yelpclone
//
//  Created by Maneesh Goel on 8/14/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestKit.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "JSONKit.h"

@interface ViewController : UIViewController <RKRequestDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
    IBOutlet UIButton *findStuffButton;
    CLLocationManager *locationManager;
    IBOutlet MKMapView *worldView;
}

-(IBAction)findNearbyStuff;
@end
