//
//  ViewController.h
//  sportsBuddy
//
//  Created by Matt Riddoch on 5/31/14.
//  Copyright (c) 2014 mattsApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@end
