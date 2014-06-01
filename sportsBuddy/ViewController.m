//
//  ViewController.m
//  sportsBuddy
//
//  Created by Matt Riddoch on 5/31/14.
//  Copyright (c) 2014 mattsApps. All rights reserved.
//

#import "ViewController.h"
#import "event.h"
#import "mainTableViewCell.h"
#import "ISRefreshControl.h"
#import "detailViewController.h"


@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray *nameArray;
    NSMutableArray *imageArray;
    NSMutableArray *locationArray;
    NSMutableArray *startArray;
    NSMutableArray *endArray;
    NSMutableArray *geoArray;
    NSMutableArray *reservationArray;
    NSMutableArray *isReservedArray;
    ISRefreshControl *refreshControl;
    NSString *nameString;
    NSString *locationString;
    NSString *startString;
    NSString *endString;
    NSString *reservationString;
    PFGeoPoint *selectedPoint;
    
    NSString *messageString;
    NSString *to;
    NSString *toname;
    NSString *from;
    NSString *fromname;
    //NSString *template;
    int messageInt;
    NSString *objectHolder;
    BOOL signedUp;
    NSNumber *filterNum;
}

@synthesize mainTable;
@synthesize refreshButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    // pull down data from parse
//    
    nameArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    locationArray = [[NSMutableArray alloc] init];
    startArray = [[NSMutableArray alloc] init];
    endArray = [[NSMutableArray alloc] init];
    geoArray = [[NSMutableArray alloc] init];
    reservationArray = [[NSMutableArray alloc] init];
    isReservedArray = [[NSMutableArray alloc] init];
    
    PFQuery *userQuery = [PFQuery queryWithClassName:@"userType"];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu record.", (unsigned long)objects.count);
            // Do something with the found objects
            
            PFUser *user = [PFUser currentUser];
            NSString *tempString = user.username;
            
            for (PFObject *record in objects) {
                
                if ([record[@"userName"] isEqualToString:tempString]) {
                    filterNum = record[@"typeNum"];
                    NSLog(@"filterNum %@", filterNum);
                }
                
            }
            
            //NSArray *tempHolder = objects;
            
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
            }
            
            [self pullMainData];
            
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    //[self pullMainData];
    
}

-(void)setTheFilter{
    PFQuery *userQuery = [PFQuery queryWithClassName:@"userType"];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu record.", (unsigned long)objects.count);
            // Do something with the found objects
            
            PFUser *user = [PFUser currentUser];
            NSString *tempString = user.username;
            
            for (PFObject *record in objects) {
                
                if ([record[@"userName"] isEqualToString:tempString]) {
                    filterNum = record[@"typeNum"];
                    NSLog(@"filterNum %@", filterNum);
                }
                
            }
            
            //NSArray *tempHolder = objects;
            
            
            
            
            [self pullMainData];
            
            
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    //[self pullMainData];

}

-(void)pullMainData{
    
    nameArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    locationArray = [[NSMutableArray alloc] init];
    startArray = [[NSMutableArray alloc] init];
    endArray = [[NSMutableArray alloc] init];
    geoArray = [[NSMutableArray alloc] init];
    reservationArray = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"events"];
    
    //refreshControl = (id)[[ISRefreshControl alloc] init];
    //[refreshControl addTarget:self
    //                        action:@selector(refresh)
    //              forControlEvents:UIControlEventValueChanged];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu record.", (unsigned long)objects.count);
            // Do something with the found objects
            
            for (PFObject *record in objects) {
                
                NSNumber *numHolder = record[@"eventNum"];
                int switchint = [numHolder intValue];
                int filterholder = [filterNum intValue];
                if (switchint == filterholder) {
                    switch (switchint) {
                        case 1:
                        {
                            [nameArray addObject:record[@"eventName"]];
                            [imageArray addObject:record[@"eventImage"]];
                            [locationArray addObject:record[@"eventLocation"]];
                            [startArray addObject:record[@"eventBegin"]];
                            [endArray addObject:record[@"eventEnd"]];
                            [geoArray addObject:record[@"eventGeoPoint"]];
                            [reservationArray addObject:record[@"reservationTable"]];
                            
                            
                        }
                            break;
                        case 2:
                        {
                            [nameArray addObject:record[@"eventName"]];
                            [imageArray addObject:record[@"eventImage"]];
                            [locationArray addObject:record[@"eventLocation"]];
                            [startArray addObject:record[@"eventBegin"]];
                            [endArray addObject:record[@"eventEnd"]];
                            [geoArray addObject:record[@"eventGeoPoint"]];
                            [reservationArray addObject:record[@"reservationTable"]];

                        }
                            break;
                        default:
                            break;
                    }

                }
                
                
                
            }
            
            //NSArray *tempHolder = objects;
            
            
            
            
            [mainTable reloadData];
            //[self filterReservations];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

-(void)filterReservations{
    for (int i = 0; i < reservationArray.count; i++) {
        
        PFQuery *userQuery = [PFQuery queryWithClassName:[reservationArray objectAtIndex:i]];
        [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"filter retrieved %lu record.", (unsigned long)objects.count);
                // Do something with the found objects
                
                PFUser *user = [PFUser currentUser];
                NSString *tempString = user.username;
                
                for (PFObject *record in objects) {
                    
                    if ([record[@"userString"] isEqualToString:tempString]) {
                        BOOL isReserved;
                        isReserved = record[@"status"];
                        NSLog(isReserved ? @"Yes" : @"No");
                        //[isReservedArray addObject:isReserved];
                    }
                    
                }
                
                //NSArray *tempHolder = objects;
                
                
//                for (PFObject *object in objects) {
//                    NSLog(@"%@", object.objectId);
//                    
//                }
                
                //[self pullMainData];
                [mainTable reloadData];
                
                
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

    }
}

-(void)reloadTheData{
    
    
    nameArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    locationArray = [[NSMutableArray alloc] init];
    startArray = [[NSMutableArray alloc] init];
    endArray = [[NSMutableArray alloc] init];
    geoArray = [[NSMutableArray alloc] init];
    reservationArray = [[NSMutableArray alloc] init];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"events"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu record.", (unsigned long)objects.count);
            // Do something with the found objects
            
            for (PFObject *record in objects) {
                //NSMutableDictionary *tempHolder = [[NSMutableDictionary alloc] init];
                //NSString *testString = record[@"eventName"];
                //[tempHolder setObject:testString forKey:@"eventName"];
                //event.eventName = record[@"eventName"];
                [nameArray addObject:record[@"eventName"]];
                [imageArray addObject:record[@"eventImage"]];
                [locationArray addObject:record[@"eventLocation"]];
                [startArray addObject:record[@"eventBegin"]];
                [endArray addObject:record[@"eventEnd"]];
                [geoArray addObject:record[@"eventGeoPoint"]];
                [reservationArray addObject:record[@"reservationTable"]];
            }
            
            //NSArray *tempHolder = objects;
            
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
            }
            
            [mainTable reloadData];
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}

- (void)refresh
{
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [mainTable reloadData];
        [refreshControl endRefreshing];
    });
}


#pragma mark - tableview delegate code

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return 4; //Orig code
    return nameArray.count;
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //return 80;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"mainCell";
    //archievdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //archievdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    mainTableViewCell *cell = (mainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                               forIndexPath:indexPath];
    
    cell.nameLabel.text = [nameArray objectAtIndex:indexPath.row];
    NSString *imageHolder = [[NSString alloc] init];
    if ([[imageArray objectAtIndex:indexPath.row] isEqualToString:@"rugby"]) {
        imageHolder = @"one.png";
    }else if ([[imageArray objectAtIndex:indexPath.row] isEqualToString:@"ski"]) {
        imageHolder = @"ski.png";
    }
    
    UIImage *thumb = [UIImage imageNamed:imageHolder];
    
    [cell.thumbImage setImage:thumb];
    cell.locationLabel.text = [locationArray objectAtIndex:indexPath.row];
    NSDate *startDate = [startArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd"];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm"];
    
    //NSDate *now = [[NSDate alloc] init];
    
    NSString *theDate = [dateFormat stringFromDate:startDate];
    NSString *theTime = [timeFormat stringFromDate:startDate];
    
    cell.startLabel.text = [NSString stringWithFormat:@"%@ %@", theDate, theTime];
    
    //cell.startLabel.text = [startArray objectAtIndex:indexPath.row];
    //cell.endLabel.text = [endArray objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = @"coming soon!!";
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDate *startDate = [startArray objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd"];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm"];
    
    //NSDate *now = [[NSDate alloc] init];
    
    NSString *theDate = [dateFormat stringFromDate:startDate];
    NSString *theTime = [timeFormat stringFromDate:startDate];
    
    startString = [NSString stringWithFormat:@"%@ %@", theDate, theTime];
    nameString = [nameArray objectAtIndex:indexPath.row];
    locationString = [locationArray objectAtIndex:indexPath.row];
    selectedPoint = [[PFGeoPoint alloc] init];
    selectedPoint = [geoArray objectAtIndex:indexPath.row];
    reservationString = [reservationArray objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

#pragma mark - sign-in/up

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
    objectHolder = @"10vzIPx7DI";
    PFQuery *query = [PFQuery queryWithClassName:@"email"];
    [query getObjectInBackgroundWithId:objectHolder block:^(PFObject *template, NSError *error) {
        
        
        to = @"matt.riddoch@gmail.com";
        toname = @"appNotification";
        from = @"matt.riddoch@gmail.com";
        PFUser *user = [PFUser currentUser];
        NSString *nameHolder = [NSString stringWithFormat:@"%@, %@", user.username, @"Just signed in"];
        fromname = nameHolder;
        //template = @"Future message here";
        
        PFObject *contact = [PFObject objectWithClassName:@"contact"];
        [contact setObject:to forKey:@"to"];
        [contact setObject:toname forKey:@"toname"];
        [contact setObject:from forKey:@"from"];
        [contact setObject:fromname forKey:@"fromname"];
        [contact setObject:fromname forKey:@"name"];
        [contact setObject:template forKey:@"email_template"];
        [contact save];
        
    }];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

- (IBAction)refreshClicked:(id)sender {
    //[mainTable reloadData];
    [self setTheFilter];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"detailSegue"])
    {
        // Get reference to the destination view controller
        detailViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.nameString = nameString;
        vc.locationString = locationString;
        vc.startString = startString;
        vc.endString = endString;
        vc.incomingPoint = selectedPoint;
        vc.resString = reservationString;
    }
}



@end
