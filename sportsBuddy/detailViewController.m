//
//  detailViewController.m
//  sportsBuddy
//
//  Created by Matt Riddoch on 5/31/14.
//  Copyright (c) 2014 mattsApps. All rights reserved.
//

#import "detailViewController.h"
#import <Parse/Parse.h>

@interface detailViewController ()

@end

@implementation detailViewController{
    NSString *homeUrlHolder;
    NSMutableArray *repHolderArray;
    NSMutableArray *messageHolderArray;
    NSString *messageString;
    NSString *to;
    NSString *toname;
    NSString *from;
    NSString *fromname;
    //NSString *template;
    int messageInt;
    NSString *objectHolder;
    BOOL signedUp;
}

@synthesize replyButton;
@synthesize nameString;
@synthesize locationString;
@synthesize startString;
@synthesize endString;
@synthesize nameLabel;
@synthesize locationLabel;
@synthesize startLabel;
@synthesize incomingPoint;
@synthesize resString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [nameLabel setText:nameString];
    [locationLabel setText:locationString];
    [startLabel setText:startString];
    NSLog(@"lat %f", incomingPoint.latitude);
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pullReservationData{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)replyClicked:(id)sender {
    
    if (!signedUp) {
        NSString *titleHolder = [NSString stringWithFormat:@"Do you want to sign up for %@?", nameString];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Sign-up"
                                                        message:titleHolder
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Yep!",nil];
        [alert setTag:0];
        [alert show];
    }else{
        NSString *titleHolder = [NSString stringWithFormat:@"Do you want to change up your status for %@ to NO?", nameString];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Cancel"
                                                        message:titleHolder
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert setTag:1];
        [alert show];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    
    switch (alertView.tag) {
        case 0:
            if (buttonIndex == 0) {
            NSLog(@"zero");
            }
            if (buttonIndex == 1) {
                NSLog(@"one");
                PFObject *reservation = [PFObject objectWithClassName:resString];
                PFUser *user = [PFUser currentUser];
                [reservation setObject:user.username forKey:@"userString"];
                //[reservation setObject:user.username forKey:@"userName"];
                
                [self sendEmail];
                if (!signedUp) {
                    signedUp = YES;
                    [reservation setObject:[NSNumber numberWithBool:YES] forKey:@"status"];
                    [reservation save];

                }else{
                    signedUp = NO;
                    [reservation setObject:[NSNumber numberWithBool:NO] forKey:@"status"];
                    [reservation save];

                }
                
            }
            break;
            
        default:
            break;
    }
    
}

-(void)sendEmail{
    
    if (!signedUp) {
        objectHolder = @"0d2phCf3m7";
    }else{
        objectHolder = @"eiamYK1B7l";
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"email"];
    [query getObjectInBackgroundWithId:objectHolder block:^(PFObject *template, NSError *error) {
        
        
        to = @"matt.riddoch@gmail.com";
        toname = @"appNotification";
        from = @"matt.riddoch@gmail.com";
        PFUser *user = [PFUser currentUser];
        NSString *nameHolder = [NSString stringWithFormat:@"%@, %@", user.username, nameString];
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

@end
