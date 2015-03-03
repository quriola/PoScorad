//
//  FlipsideViewController.h
//  PoScorad3
//
//  Created by jiayi on 5/12/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonEntity.h"

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
- (void)personDetail:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *DataTable;
    NSMutableArray *personArray;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *searchResultsArray;
    PersonEntity *person;
    NSInteger *update;
    
}


@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) PersonEntity* person;
@property (nonatomic) NSInteger *update;

- (IBAction)done:(id)sender;

@end
