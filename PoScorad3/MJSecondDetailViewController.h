//
//  MJSecondDetailViewController.h
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonEntity.h"

@protocol MJSecondPopupDelegate;


@interface MJSecondDetailViewController : UIViewController{
    NSInteger *update;
    PersonEntity *person;
    //int counter;
}

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;
@property (nonatomic) NSInteger *update;
@property (nonatomic, retain) PersonEntity *person;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
-(void) start;
- (IBAction)updatePerson:(id)sender;
- (IBAction)checkboxButton:(id)sender;
@end


@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(MJSecondDetailViewController*)secondDetailViewController;
@end