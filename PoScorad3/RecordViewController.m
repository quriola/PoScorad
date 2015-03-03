//
//  FlipsideViewController.m
//  PoScorad3
//
//  Created by jiayi on 5/12/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "RecordViewController.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "PersonEntity.h"
#import "AppDelegate.h"


@interface RecordViewController ()

@end

@implementation RecordViewController

@synthesize record;
@synthesize update;
@synthesize personName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(970, 576);
        record = [[RecordEntity alloc]init];
        recordArray = [[NSMutableArray alloc]init];
        
        
    }
    return self;
}


-(void)loadView{
        /*//创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(clickLeftButton)];
    
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(popupPersonDetail1:)];
    //设置导航栏内容
    [navigationItem setTitle:@"姓名"];
    
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    [navigationItem setRightBarButtonItem:rightButton];
    
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
     searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 40, 320, 40)];
     [self.view addSubview:searchBar];
     searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
     searchDisplayController.delegate = self;
     searchDisplayController.searchResultsDataSource = self;
     searchDisplayController.searchResultsDelegate = self;*/
    
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 970, 576)];
    self.view = container;
    
    
    DataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 970, 576)];
    DataTable.delegate = self;
    DataTable.dataSource = self;
    [self.view addSubview:DataTable];
    

}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    FMResultSet *results = [appDelegate.datebase executeQuery:@"select * from record2 where personName = ?", personName];
    //FMResultSet *results = [appDelegate.datebase executeQuery:@"select * from record1"];
    while ([results next]) {
        RecordEntity* recordEntity = [[RecordEntity alloc]init];
        [recordEntity start];
        recordEntity.personName = [results stringForColumn:@"personName"];
        recordEntity.date = [results stringForColumn:@"date"];
        recordEntity.age = [results stringForColumn:@"age"];
        
        recordEntity.point = [results stringForColumn:@"point"];
        for (int i=1; i<7; i++){
            NSString *key = [NSString stringWithFormat:@"a%d", i ];
                NSString *s = [results stringForColumn:key] ;
                if (s!=nil){
                    [recordEntity.records setObject:s forKey:key];
                }
                else {
                    [recordEntity.records setObject:@"" forKey:key];
                }
        }
        for (int i=201; i<237; i++){
            NSString *key = [NSString stringWithFormat:@"a%d", i ];
            NSString *s = [results stringForColumn:key] ;
            if (s!=nil){
                [recordEntity.records setObject:s forKey:key];
            }
            else {
                [recordEntity.records setObject:@"" forKey:key];
            }

        }
        for (int i=100; i<103; i++){
            NSString *key = [NSString stringWithFormat:@"a%d", i ];
            NSString *s = [results stringForColumn:key] ;
            if (s!=nil){
                [recordEntity.records setObject:s forKey:key];
            }
            else {
                [recordEntity.records setObject:@"" forKey:key];
            }

        }
        /*for (int i=401; i<403; i++){
            NSString *key = [NSString stringWithFormat:@"a%d", i ];
            NSString *s = [results stringForColumn:key] ;
            if (s!=nil){
                [recordEntity.records setObject:s forKey:key];
            }
            else {
                [recordEntity.records setObject:@"" forKey:key];
            }

        }*/

        [recordArray addObject:recordEntity];
    }
    //[appDelegate.datebase executeUpdate:@"INSERT INTO person (personName) VALUES (?)",@"789"];
    [appDelegate.datebase close];
}

- (void)viewDidUnload
{[super viewDidUnload];
    

}

/*- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    NSString *sqlStr = [NSString stringWithFormat:@"select personName from person2 where personName like '%%%@%%'",searchString];
    FMResultSet *results = [appDelegate.datebase executeQuery:sqlStr];
    searchResultsArray = [[NSMutableArray alloc]init];
    while ([results next]) {
        PersonEntity *personEntity = [[PersonEntity alloc]init];
        personEntity.personName = [results stringForColumn:@"personName"];
        [searchResultsArray addObject:personEntity];
    }
    [appDelegate.datebase close];
    return YES;
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    if (tableView==DataTable) {
        person = [personArray objectAtIndex:indexPath.row];
    }else {
        person= [searchResultsArray objectAtIndex:indexPath.row];
    }*/
    [self.delegate flipsideViewControllerDidFinish1:self];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 127;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   /* if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }*/
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return 0;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
         return recordArray.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    record = [recordArray objectAtIndex:indexPath.row];
        
    static NSString *CustomCellIdentifier = @"RecordCell";
        UINib *nib = [UINib nibWithNibName:@"RecordCell" bundle:nil];
    
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
      
    RecordEntity* recordEntity = [[RecordEntity alloc]init];
    recordEntity = [recordArray objectAtIndex:indexPath.row];
    
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    cell.record = recordEntity;
    [cell fillField];
      
    
  
    
    // add some other button properties here
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appDelegate.datebase open];
        [appDelegate.datebase executeUpdate:@"delete from record2 where personName =? and date = ?" ,((RecordEntity*)[recordArray objectAtIndex:indexPath.row]).personName,((RecordEntity*)[recordArray objectAtIndex:indexPath.row]).date];
       [appDelegate.datebase close];
        [recordArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark - Actions

/*-(IBAction)popupPersonDetail:(id)sender{
    self.update = 0;
    person = [personArray objectAtIndex:[sender tag]];
    [self.delegate personDetail:self];
    
}
-(IBAction)popupPersonDetail1:(id)sender{
    self.update = 1;
    [self.delegate personDetail:self];
    
}*/
/*- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}*/

@end
