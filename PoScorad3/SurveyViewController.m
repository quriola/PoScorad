//
//  MJSecondDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController ()

@end

@implementation SurveyViewController

@synthesize delegate;
@synthesize update;
@synthesize person;
@synthesize groupArray;
@synthesize survey;


-(void) start{
    /*if ((int)update==1){
        
    person = [[PersonEntity alloc]init];
    [person start];
    }
    else
    {
        person = [PersonEntity getPersonByName: person.personName];
        ((UITextField*)[self.view viewWithTag:1]).text = person.personName;
        for (int i=2; i<44; i++){
            if ([[self.view viewWithTag:i] isKindOfClass:[UITextField class]]){
                ((UITextField*)[self.view viewWithTag:i]).text = [person.attributes objectForKey:[NSString stringWithFormat:@"a%d",i]];
            }
            else if ([[self.view viewWithTag:i] isKindOfClass:[UISegmentedControl class]]){
                ((UISegmentedControl*)[self.view viewWithTag:i]).selectedSegmentIndex = [[person.attributes objectForKey:[NSString stringWithFormat:@"a%d",i]] integerValue];
                
            }
            else if ([[self.view viewWithTag:i] isKindOfClass:[UIButton class]]){
                [((UIButton*)[self.view viewWithTag:i]) setSelected:[[person.attributes objectForKey:[NSString stringWithFormat:@"a%d",i]] integerValue]];
            }
            
            
            
        }

    }*/
    NSArray *array;
    if (survey!=nil){
         array= [survey componentsSeparatedByString:@","];
    }
    NSArray *options =[[NSArray alloc]initWithObjects:@"非常多",@"许多",@"一点",@"完全没有",nil];
    groupArray = [[NSMutableArray alloc]init];
    for (int i=0; i<10;i++){
        MIRadioButtonGroup *group =[[MIRadioButtonGroup alloc]initWithFrame:CGRectMake(0, 10+50*i, 700, 75) andOptions:options andColumns:4];
        /*if (update == 1){
            [group setSelected:[[array objectAtIndex:i] intValue]];
            group.selected = [[array objectAtIndex:i] intValue];
            NSLog (@"%d",[[array objectAtIndex:i] intValue]);
        }*/
        [self.view addSubview:group];
        
        [groupArray addObject:group];

    }
    	    
}
- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClickedSurvey:self];
    }
}
- (IBAction)updatePerson:(id)sender{
   /* if ((int)update==1){
        person.personName = [(UITextField*)[self.view viewWithTag:1] text];
        for (int i=2; i<44; i++){
            if ([[self.view viewWithTag:i] isKindOfClass:[UITextField class]]){
                [person.attributes setObject:((UITextField*)[self.view viewWithTag:i]).text forKey:[NSString stringWithFormat:@"a%d",i]];
                 }
            else if ([[self.view viewWithTag:i] isKindOfClass:[UISegmentedControl class]]){
                     [person.attributes setObject:[NSString stringWithFormat:@"%d",[(UISegmentedControl*)[self.view viewWithTag:i] selectedSegmentIndex]] forKey:[NSString stringWithFormat:@"a%d",i]];

            }
            else if ([[self.view viewWithTag:i] isKindOfClass:[UIButton class]]){
                [person.attributes setObject:[NSString stringWithFormat:@"%d",[(UIButton*)[self.view viewWithTag:i] isSelected]] forKey:[NSString stringWithFormat:@"a%d",i]];
            }
                 
                            
                        
        }
    [PersonEntity createPerson:person];

    }*/
    
    NSMutableArray* newVals = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        [newVals addObject:[NSString stringWithFormat:@"%d",((MIRadioButtonGroup *)[groupArray objectAtIndex:i]).selected]];
        NSLog(@"%d",((MIRadioButtonGroup *)[groupArray objectAtIndex:i]).getSelected);
           }
    survey = [NSString stringWithFormat:@"%@",[newVals componentsJoinedByString:@", "] ];
    NSLog (@"%@",survey);

    [self.delegate cancelButtonClickedSurvey:self];
    
}

- (IBAction)checkboxButton:(id)sender{
	if ([(UIButton*)sender isSelected ]== true){
		[(UIButton*)sender setSelected:false];
	} else {
		[(UIButton*)sender setSelected:true];
	}
}

@end
