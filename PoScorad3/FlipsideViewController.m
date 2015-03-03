//
//  FlipsideViewController.m
//  PoScorad3
//
//  Created by jiayi on 5/12/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "FlipsideViewController.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "PersonEntity.h"
#import "AppDelegate.h"


@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize person;
@synthesize update;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    }
    return self;
}


-(void)loadView{
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 460)];
    self.view = container;
    //创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    /*UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(clickLeftButton)];
    */
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(popupPersonDetail1:)];
    //创建一个左边按钮
    //UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(export:)];
    //设置导航栏内容
    [navigationItem setTitle:@"姓名"];
    
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    //[navigationItem setLeftBarButtonItem:leftButton];
    [navigationItem setRightBarButtonItem:rightButton];
    //[navigationItem setRightBarButtonItem:leftButton];
    
    //把导航栏添加到视图中
    [self.view addSubview:navigationBar];
    
    DataTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320, 420)];
    DataTable.delegate = self;
    DataTable.dataSource = self;
    [self.view addSubview:DataTable];
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 40, 320, 40)];
    [self.view addSubview:searchBar];
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	personArray = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    FMResultSet *results = [appDelegate.datebase executeQuery:@"select personName from person2"];
    while ([results next]) {
        PersonEntity *personEntity = [[PersonEntity alloc]init];
        personEntity.personName = [results stringForColumn:@"personName"];
        [personArray addObject:personEntity];
    }
    person = [[PersonEntity alloc]init];
    //[appDelegate.datebase executeUpdate:@"INSERT INTO person (personName) VALUES (?)",@"789"];
    [appDelegate.datebase close];
}

- (void)viewDidUnload
{[super viewDidUnload];
    

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView==DataTable) {
        person = [personArray objectAtIndex:indexPath.row];
    }else {
        person= [searchResultsArray objectAtIndex:indexPath.row];
    }
    [self.delegate flipsideViewControllerDidFinish:self];
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==DataTable) {
        return personArray.count;
    }else {
        return searchResultsArray.count;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appDelegate.datebase open];
        [appDelegate.datebase executeUpdate:@"delete from person2 where personName =?" ,((PersonEntity*)[personArray objectAtIndex:indexPath.row]).personName];
       [appDelegate.datebase close];
        [personArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonEntity *personEntity = [[PersonEntity alloc]init];

    if (tableView==DataTable) {
        personEntity = [personArray objectAtIndex:indexPath.row];
    }else {
       personEntity = [searchResultsArray objectAtIndex:indexPath.row];
    }
    UITableViewCell *personCell = [DataTable dequeueReusableCellWithIdentifier:@"personCell"];
    if (personCell==nil) {
        personCell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personCell"];
        
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    button.tag = indexPath.row;
    button.frame = CGRectMake( 0 , 60, 50, 50 );
    [button addTarget:self action:@selector(popupPersonDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    // add some other button properties here
    personCell.accessoryView = button;
    
    personCell.textLabel.text = personEntity.personName;
    return personCell;
}

#pragma mark - Actions

-(IBAction)popupPersonDetail:(id)sender{
    self.update = 0;
    person = [personArray objectAtIndex:[sender tag]];
    [self.delegate personDetail:self];
    
}
-(IBAction)popupPersonDetail1:(id)sender{
    self.update = 1;
    [self.delegate personDetail:self];
    
}


/*- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}*/

@end
