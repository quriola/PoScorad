//
//  RecordCell.h
//  PoScorad3
//
//  Created by jiayi on 6/13/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordEntity.h"
@interface RecordCell : UITableViewCell{
    RecordEntity *record;
}

@property RecordEntity *record;
-(void) fillField;
@end
