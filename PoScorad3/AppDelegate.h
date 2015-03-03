//
//  AppDelegate.h
//  sasa
//
//  Created by jiayi on 6/1/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,retain) FMDatabase *datebase;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *mainViewController;


@end
