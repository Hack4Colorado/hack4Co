//
//  event.h
//  sportsBuddy
//
//  Created by Matt Riddoch on 5/31/14.
//  Copyright (c) 2014 mattsApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface event : NSObject

@property (nonatomic, assign) NSString *eventName;
@property (nonatomic, assign) NSString *eventProgram;
@property (nonatomic, assign) NSString *eventDetail;
@property (nonatomic, assign) NSString *eventBegin;
@property (nonatomic, assign) NSString *eventEnd;
@property (nonatomic, assign) NSString *eventLocation;

//- (id) init;



@end
