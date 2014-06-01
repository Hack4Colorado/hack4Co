//
//  detailViewController.h
//  sportsBuddy
//
//  Created by Matt Riddoch on 5/31/14.
//  Copyright (c) 2014 mattsApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>

@interface detailViewController : UIViewController <UIAlertViewDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *replyButton;

@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSString *locationString;
@property (nonatomic, strong) NSString *startString;
@property (nonatomic, strong) NSString *endString;
@property (nonatomic, strong) NSString *resString;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) PFGeoPoint *incomingPoint;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;




@end
