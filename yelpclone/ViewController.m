//
//  ViewController.m
//  yelpclone
//
//  Created by Maneesh Goel on 8/14/12.
//  Copyright (c) 2012 Maneesh Goel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSDictionary *result;
}

@end

@implementation ViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"new location is %@", newLocation);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"couldn't update location, %@", error);
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000);
    [worldView setRegion:region animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [RKClient clientWithBaseURLString:@"https://maps.googleapis.com/"];
    [worldView setShowsUserLocation:YES];
}

-(IBAction)findNearbyStuff {
    NSLog(@"finding nearby stuff!");
    RKClient *client = [RKClient sharedClient];
    CLLocation *current = [locationManager location];
    double lat = current.coordinate.latitude;
    double lon = current.coordinate.longitude;
    NSDictionary *params = [NSDictionary dictionaryWithKeysAndObjects:@"key", @"AIzaSyDcajx4DCy_NJl7ykVrQR9zvE8sjiRAgWI", @"location", [NSString stringWithFormat:@"%f,%f", lat, lon], @"radius", @"2000", @"sensor", @"true", @"keyword", @"ice cream" , nil];
    
    [client get:@"/maps/api/place/search/json" queryParameters:params delegate:self];
}

-(void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    //NSLog(@"%@", [request.response parsedBody:nil]);
    result = [request.response parsedBody:nil];
    //NSLog(@"result class is %@", [result class]);
    NSLog(@"number of results is %d",[[result objectForKey:@"results"] count]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
