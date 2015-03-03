//
//  RecordCell.m
//  PoScorad3
//
//  Created by jiayi on 6/13/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

@synthesize record;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
                
    }
   
    return self;
    
}


-(void) fillField {
    [(UILabel*)[self viewWithTag:501] setText:record.point];
    [(UILabel*)[self viewWithTag:600] setText:record.age];

    [(UILabel*)[self viewWithTag:201] setText:record.date];
     [(UILabel*)[self viewWithTag:202] setText:[NSString stringWithFormat:@"%@+%@", [record.records objectForKey:@"a201"],[record.records objectForKey:@"a202"]]];
     [(UILabel*)[self viewWithTag:203] setText:[NSString stringWithFormat:@"%@+%@+%@", [record.records objectForKey:@"a219"],[record.records objectForKey:@"a220"], [record.records objectForKey:@"a221"]]];
     [(UILabel*)[self viewWithTag:204] setText:[NSString stringWithFormat:@"%@+%@+%@", [record.records objectForKey:@"a222"],[record.records objectForKey:@"a223"], [record.records objectForKey:@"a224"]]];
    [(UILabel*)[self viewWithTag:205] setText:[NSString stringWithFormat:@"%@+%@+%@+%@", [record.records objectForKey:@"a204"],[record.records objectForKey:@"a208"], [record.records objectForKey:@"a212"],[record.records objectForKey:@"a216"]]];
     [(UILabel*)[self viewWithTag:206] setText:[NSString stringWithFormat:@"%@+%@+%@+%@", [record.records objectForKey:@"a203"],[record.records objectForKey:@"a207"], [record.records objectForKey:@"a211"],[record.records objectForKey:@"a215"]]];
     [(UILabel*)[self viewWithTag:207] setText:[NSString stringWithFormat:@"%@+%@+%@+%@", [record.records objectForKey:@"a205"],[record.records objectForKey:@"a209"], [record.records objectForKey:@"a213"],[record.records objectForKey:@"a217"]]];
     [(UILabel*)[self viewWithTag:208] setText:[NSString stringWithFormat:@"%@+%@+%@+%@", [record.records objectForKey:@"a206"],[record.records objectForKey:@"a210"], [record.records objectForKey:@"a214"],[record.records objectForKey:@"a218"]]];
    [(UILabel*)[self viewWithTag:209] setText:[NSString stringWithFormat:@"%@+%@+%@", [record.records objectForKey:@"a226"],[record.records objectForKey:@"a230"], [record.records objectForKey:@"a234"]]];
    [(UILabel*)[self viewWithTag:210] setText:[NSString stringWithFormat:@"%@+%@+%@", [record.records objectForKey:@"a225"],[record.records objectForKey:@"a229"], [record.records objectForKey:@"a233"]]];
    [(UILabel*)[self viewWithTag:211] setText:[NSString stringWithFormat:@"%@+%@+%@", [record.records objectForKey:@"a227"],[record.records objectForKey:@"a231"], [record.records objectForKey:@"a235"]]];

    [(UILabel*)[self viewWithTag:212] setText:[NSString stringWithFormat:@"%@+%@+%@", [record.records objectForKey:@"a228"],[record.records objectForKey:@"a232"], [record.records objectForKey:@"a236"]]];
    for (int i=1; i<7; i++){
        [(UILabel*)[self viewWithTag:i] setText:[NSString stringWithFormat:@"%@", [record.records objectForKey:[NSString stringWithFormat:@"a%d",i]]]];
    }
    for (int i=100; i<103; i++){
        [(UILabel*)[self viewWithTag:i] setText:[NSString stringWithFormat:@"%@", [record.records objectForKey:[NSString stringWithFormat:@"a%d",i]]]];
    }
    /*for (int i=401; i<403; i++){
        [(UILabel*)[self viewWithTag:i] setText:[NSString stringWithFormat:@"%@", [record.records objectForKey:[NSString stringWithFormat:@"a%d",i]]]];
    }
*/

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
