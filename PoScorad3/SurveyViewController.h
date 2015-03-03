//
//  MJSecondDetailViewController.h
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonEntity.h"
#import "MIRadioButtonGroup.h"

@protocol SurveyPopupDelegate;


@interface SurveyViewController : UIViewController{
    NSInteger *update;
    PersonEntity *person;
   NSString *survey;
}

@property (assign, nonatomic) id <SurveyPopupDelegate>delegate;
@property (nonatomic) NSInteger *update;
@property (nonatomic, retain) PersonEntity *person;
@property (nonatomic, retain) NSMutableArray *groupArray;
@property (nonatomic,retain) NSString *survey;
@property (nonatomic,retain) MIRadioButtonGroup *group;
-(void) start;
- (IBAction)updatePerson:(id)sender;
- (IBAction)checkboxButton:(id)sender;
@end


@protocol SurveyPopupDelegate<NSObject>
@optional
- (void)cancelButtonClickedSurvey:(SurveyViewController*)SurveyViewController;
@end