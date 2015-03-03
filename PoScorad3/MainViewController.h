//
//  MainViewController.h
//  PoScorad3
//
//  Created by jiayi on 5/12/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

#import "RecordEntity.h"
#import "MIRadioButtonGroup.h"
#import "MJSecondDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "RecordViewController.h"
#import "SurveyViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, RecordViewControllerDelegate,SurveyPopupDelegate> {
    IBOutlet UISlider *mySlider;
    IBOutlet UIButton *bodyButton;
    IBOutlet UIButton *skinButton;
    UIActionSheet *pickerViewPopup;
    IBOutlet UITextField *myTextField;
    IBOutlet UILabel *myLabel;
    NSArray *percent;
    RecordEntity *record;
    MJSecondDetailViewController *secondDetailViewController;
    SurveyViewController *surveyViewController;
    //NSInteger *update;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
//@property (nonatomic,retain) NSString *tempFile;
@property (nonatomic, retain)UISlider *mySlider;
@property (nonatomic, retain)UIButton *bodyButton;
@property (nonatomic, retain)UIButton *skinButton;
@property (nonatomic,retain)UITextField *myTextField;
@property (nonatomic,retain)UILabel *myLabel;
@property (nonatomic,retain) RecordEntity *record;
@property (nonatomic,retain) MIRadioButtonGroup *group;
//@property (nonatomic) NSInteger *update;


- (IBAction)showInfo:(id)sender;
- (IBAction)bodyClicked:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)showActionSheet:(id)sender;
- (void)textFieldDidBeginEditing:(UITextField *)aTextField;
-(void)doneButtonPressed:(id)sender;
-(void)cancelButtonPressed:(id)sender;
-(IBAction)buttonClicked:(id)sender;
-(IBAction)saveRecord:(id)sender;
- (IBAction)showRecord:(id)sender;
- (IBAction)showSurvey:(id)sender;
- (void)cancelButtonClickedSurvey:(SurveyViewController *)aSecondDetailViewController;


@end
