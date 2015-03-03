//
//  MJSecondDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJSecondDetailViewController.h"
#import "AppDelegate.h"

@interface MJSecondDetailViewController ()

@end

@implementation MJSecondDetailViewController

@synthesize delegate;
@synthesize update;
@synthesize person;
@synthesize scrollView;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    scrollView.contentSize=CGSizeMake(400.0,600.0);
    
    /*NSArray *array = [scrollView subviews];
    NSString *str=@"";
    for (int i=0; i<array.count; i++){
        if ([[array objectAtIndex:i] isKindOfClass:[UILabel class]]){
            str=[str stringByAppendingFormat:@"%@,",
                 ((UILabel*)[array objectAtIndex:i]).text];
        }
    }
    NSLog(@"%@",str);*/
}

-(void) start{
        
    if ((int)update==1){
        
    person = [[PersonEntity alloc]init];
    [person start];
    }
    else
    {
        person = [PersonEntity getPersonByName: person.personName];
        ((UITextField*)[self.view viewWithTag:1]).text = person.personName;
        for (int i=2; i<66; i++){
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

    }
    
}
- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
- (IBAction)updatePerson:(id)sender{
        person.personName = [(UITextField*)[self.view viewWithTag:1] text];
        for (int i=2; i<66; i++){
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
    if ((int)update==0){
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        [appDelegate.datebase open];
        [appDelegate.datebase executeUpdate:@"delete from person2 where personName =?" ,person.personName];
        [appDelegate.datebase close];

    }
    [PersonEntity createPerson:person];

    
        
    [self.delegate cancelButtonClicked:self];
    
}

- (IBAction)checkboxButton:(id)sender{
	if ([(UIButton*)sender isSelected ]== true){
		[(UIButton*)sender setSelected:false];
	} else {
		[(UIButton*)sender setSelected:true];
	}
}



@end
