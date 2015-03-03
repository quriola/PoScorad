//
//  FlipsideViewController.h
//  PoScorad3
//
//  Created by jiayi on 5/12/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCell.h"

@class RecordViewController;

@protocol RecordViewControllerDelegate
- (void)flipsideViewControllerDidFinish1:(RecordViewController *)controller;
- (void)personDetail:(RecordViewController *)controller;
@end

@interface RecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *DataTable;
    NSMutableArray *recordArray;
    RecordEntity *record;
    NSString *personName;
    //NSInteger *update;
    
}


@property (weak, nonatomic) id <RecordViewControllerDelegate> delegate;
@property (nonatomic, retain) RecordEntity* record;
@property (nonatomic, retain) NSString *personName;
@property (nonatomic) NSInteger *update;
- (IBAction)done:(id)sender;

@end
