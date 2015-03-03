//
//  AppDelegate.m
//  sasa
//
//  Created by jiayi on 6/1/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@implementation AppDelegate
@synthesize datebase;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Do any additional setup after loading the view.
    NSString *documentPath = [self applicationDocumentsFileDirectory];
    NSString *currentFileName = [NSString stringWithFormat:@"PoscoradDB2.rdb"];
    NSString *currentFilePath = [documentPath stringByAppendingPathComponent:currentFileName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:currentFilePath]) {
        
    }else {
        //因为用户安装了老的版本，其中sqlite文件和最新版本不一致，从资源目录把最新的sqlite文件拷贝到document里面
        //一定要拷贝到document目录下面，因为resouce目录是只读的
        //会丢失用户在老版本中所有的数据
        //可以运行一段sql脚本，把数据从老的sqlite文件中迁移到新的sqlite
        NSString *resourceFilePath = [[NSBundle mainBundle]pathForResource:@"PoscoradDB2"
                                                                    ofType:@"rdb"];
        [[NSFileManager defaultManager]copyItemAtPath:resourceFilePath toPath:currentFilePath error:NULL];
    }
    self.datebase = [[FMDatabase alloc]initWithPath:currentFilePath];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController_iPhone" bundle:nil];
    } else {
        self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)applicationDocumentsFileDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

@end
