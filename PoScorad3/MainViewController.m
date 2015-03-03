//
//  MainViewController.m
//  PoScorad3
//
//  Created by jiayi on 5/12/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "MainViewController.h"
#import "AAActivityAction.h"
#import "AAActivity.h"
#import "AppDelegate.h"
@interface MainViewController ()


@end

@implementation MainViewController

@synthesize mySlider;
@synthesize bodyButton;
@synthesize skinButton;
@synthesize myTextField;
@synthesize myLabel;
@synthesize record;
@synthesize group;
//@synthesize update;
//@synthesize tempFile;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *options =[[NSArray alloc]initWithObjects:@"less than 2 years old",@"more than 2 years old",nil];
    record = [RecordEntity alloc];
    [record start];
	group =[[MIRadioButtonGroup alloc]initWithFrame:CGRectMake(0, 100, 700, 75) andOptions:options andColumns:2];
	[self.view addSubview:group];
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    myTextField.text = [formate stringFromDate:[[NSDate alloc]init] ];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [(UILabel*)[self.view viewWithTag:502] setText:controller.person.personName];
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        
    }
    
}
- (void)flipsideViewControllerDidFinish1:(RecordViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
       [self.flipsidePopoverController dismissPopoverAnimated:YES];
        
    }
    //update = 1;
    [group setSelected:[controller.record.age intValue]];
    ((UILabel*)[self.view viewWithTag:502]).text = controller.record.personName;
    ((UITextField*)[self.view viewWithTag:503]).text = controller.record.date;
    for (int i=1; i<7; i++){
       [((UIButton*)[self.view viewWithTag:(i)]) setTitle:[controller.record.records objectForKey:[NSString stringWithFormat:@"a%d",i]] forState:UIControlStateNormal];
        
    }
    for (int i=201; i<237;i++){
         [((UIButton*)[self.view viewWithTag:(i)]) setTitle:[controller.record.records objectForKey:[NSString stringWithFormat:@"a%d",i]] forState:UIControlStateNormal];
    }
    for (int i=100; i<103; i++){
         ((UILabel*)[self.view viewWithTag:(i)]).text= [controller.record.records objectForKey:[NSString stringWithFormat:@"a%d",i]];
    }
    /*for (int i=401; i<403; i++){
     
     [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [(UITextField*)[self.view viewWithTag:(i)] text]];
     }*/
    myLabel.text = controller.record.point;
}

- (void)personDetail:(FlipsideViewController *)controller
{
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
    secondDetailViewController = nil;
    secondDetailViewController = [[MJSecondDetailViewController alloc] initWithNibName:@"MJSecondDetailViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    secondDetailViewController.person = controller.person;
    secondDetailViewController.update = controller.update;
    [secondDetailViewController start];
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
}

- (IBAction)showSurvey:(id)sender
{
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
    surveyViewController = nil;
    surveyViewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil];
    /*if ([((UILabel*)[self.view viewWithTag:504]).text length]>0){
        surveyViewController.survey = ((UILabel*)[self.view viewWithTag:504]).text;
        surveyViewController.update = 1;
    }*/
    
    surveyViewController.delegate =self;
    [surveyViewController start];
    [self presentPopupViewController:surveyViewController animationType:MJPopupViewAnimationFade];
}

- (IBAction)bodyClicked:(id)sender
{
    bodyButton = (UIButton*)sender;
    [bodyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    float value = mySlider.value;
    [bodyButton setTitle:([NSString stringWithFormat:@"%.1f", value]) forState:UIControlStateNormal];

    

}

- (IBAction)sliderChanged:(id)sender{
    if ([sender tag] == 104 ||[sender tag] == 103  ){
        [((UILabel*)[self.view viewWithTag:([sender tag]-2)]) setText:[NSString stringWithFormat:@"%d",(int)(((UISlider*)sender).value)]];
    }
    else {
        float value = mySlider.value;
        [bodyButton setTitle:([NSString stringWithFormat:@"%.1f", value]) forState:UIControlStateNormal];
 }
}
//设置姓名
- (IBAction)showInfo:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
        controller.delegate = self;
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentModalViewController:controller animated:YES];
    } else {
        //if (!self.flipsidePopoverController) {
            FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
            controller.delegate = self;
            self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
        //}
        if ([self.flipsidePopoverController isPopoverVisible]) {
            [self.flipsidePopoverController dismissPopoverAnimated:YES];
        } else {
            [self.flipsidePopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
       
    }
}
//显示纪录
- (IBAction)showRecord:(id)sender
{
    [self.flipsidePopoverController dismissPopoverAnimated:YES];
    RecordViewController *controller = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    controller.delegate = self;
    controller.personName = ((UILabel*)[self.view viewWithTag:502]).text;
    
    //[self presentPopupViewController:controller animationType:MJPopupViewAnimationFade];
    self.flipsidePopoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
    //}
    if ([self.flipsidePopoverController isPopoverVisible]) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    } else {
        [self.flipsidePopoverController presentPopoverFromRect:CGRectMake(0, 0, 970, 75) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

    
}
//设置B类评分标准
- (IBAction)showActionSheet:(id)sender {
    AAImageSize imageSize = AAImageSizeNormal;
    NSMutableArray *array = [NSMutableArray array];
    skinButton = (UIButton*)sender;
    [skinButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
   
    
    for (int i=0; i<4; i++) {
        NSString* tag =[NSString stringWithFormat:@"symp_%d_%d", [sender tag],i];
        UIImage *image = [UIImage imageNamed:tag];
        AAActivity *activity = [[AAActivity alloc] initWithTitle:@""
                                                           image:image
                                                     actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                         [skinButton setTitle:([NSString stringWithFormat:@"%d", i]) forState:UIControlStateNormal];

                                                     }];
        [array addObject:activity];
    }
    
    AAActivityAction *aa = [[AAActivityAction alloc] initWithActivityItems:@[@"http://www.apple.com/"]
                                                     applicationActivities:array
                                                                 imageSize:imageSize];
    aa.title = @"";
    [aa show];
}

//设置时间
- (void)textFieldDidBeginEditing:(UITextField *)aTextField{
    [aTextField resignFirstResponder];
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [UIApplication sharedApplication].windows) {
        if (![[testWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = testWindow;
            break;
        }
    }
    
   // UIView *topView = [[UIApplication sharedApplication].keyWindow.subviews objectAtIndex:0];
    
    pickerViewPopup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(700,44, 0, 0)];
    pickerView.datePickerMode = UIDatePickerModeDate;
    pickerView.hidden = NO;
    pickerView.date = [NSDate date];
    [ pickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    [barItems addObject:doneBtn];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
    [barItems addObject:cancelBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [pickerViewPopup addSubview:pickerToolbar];
    [pickerViewPopup addSubview:pickerView];
    //[pickerViewPopup showInView:keyboardWindow ? : topView];
    //[pickerViewPopup setBounds:CGRectMake(0,0,320, 464)];
    pickerViewPopup.frame = self.view.bounds;
    [self.view addSubview:pickerViewPopup];
}

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    record.date = control.date;
}

-(IBAction)buttonClicked:(id)sender{
    if ([sender tag]==301){
        [record clear];
        record.age  = [NSString stringWithFormat:@"%d",[group getSelected] ];
        for (int i=1; i<7; i++){
            [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [self getValueByTag:i]];
        }
        for (int i=201; i<237;i++){
           [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [self getValueByTag:i]];
        }
        for (int i=101; i<103; i++){
            
             [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [(UILabel*)[self.view viewWithTag:(i)] text]];
        }
    }
    
    [myLabel setText: [record getPoint]];

}

-(IBAction)saveRecord:(id)sender{
    
        [record clear];
        record.age  = [NSString stringWithFormat:@"%d", [group getSelected]];
        record.personName = ((UILabel*)[self.view viewWithTag:502]).text;
        record.date = ((UITextField*)[self.view viewWithTag:503]).text;
        for (int i=1; i<7; i++){
            [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [self getValueByTag:i]];
        }
        for (int i=201; i<237;i++){
            [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [self getValueByTag:i]];
        }
        for (int i=100; i<103; i++){
            
            [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [(UILabel*)[self.view viewWithTag:(i)] text]];
        }
        /*for (int i=401; i<403; i++){
            
            [record addRecord:[NSString stringWithFormat:@"a%d", i] value: [(UITextField*)[self.view viewWithTag:(i)] text]];
        }*/
        [myLabel setText: [record getPoint]];
        record.point = myLabel.text;
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [appDelegate.datebase open];
        [appDelegate.datebase executeUpdate:@"delete from record2 where personName =? and date = ?" ,record.personName,record.date];
        [appDelegate.datebase close];

    
    
    [RecordEntity createRecord:record];
    
}
-(NSString*) getValueByTag:(int)tag
{
    if ([[(UIButton*)[self.view viewWithTag:(tag)] titleLabel ] text] != nil){
        return [[(UIButton*)[self.view viewWithTag:(tag)] titleLabel ] text];
    }
    else return @"0";
    
}

-(void)doneButtonPressed:(id)sender{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    myTextField.text = [formate stringFromDate:record.date];
    [pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)cancelButtonPressed:(id)sender{
    [pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
  

}

- (void)cancelButtonClicked:(MJSecondDetailViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    secondDetailViewController = nil;
    [(UILabel*)[self.view viewWithTag:502] setText:aSecondDetailViewController.person.personName];

}
- (void)cancelButtonClickedSurvey:(SurveyViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    secondDetailViewController = nil;
    [(UILabel*)[self.view viewWithTag:100] setText:aSecondDetailViewController.survey];
    
}

- (IBAction) export: (id) sender
{
    // in my full code, I start a UIActivityIndicator spinning and show a
    //  message that the app is "Exporting ..."
    
    [self performSelectorInBackground: @selector(exportImpl) withObject: nil];
}

- (void) exportImpl
{
    /*NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSSystemDomainMask, YES);
    NSString* documentsDir = [documentPaths objectAtIndex:0];
    NSString* csvPath = [documentsDir stringByAppendingPathComponent: @"export.csv"];
    
    NSLog(@"%@",csvPath);*/
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        NSLog(@"Documents directory not found!");
    }
    NSString *csvPath = [documentsDirectory stringByAppendingPathComponent:@"export.csv"];
    // TODO: mutex lock?
    [self exportCsv: csvPath];
    
    // mail is graphical and must be run on UI thread
    [self performSelectorOnMainThread: @selector(mail:) withObject: csvPath waitUntilDone: NO];
}

- (void) mail: (NSString*) filePath
{
    // here I stop animating the UIActivityIndicator
    
    // http://howtomakeiphoneapps.com/home/2009/7/14/how-to-make-your-iphone-app-send-email-with-attachments.html
    BOOL success = NO;
    
    if ([MFMailComposeViewController canSendMail]) {
        // TODO: autorelease pool needed ?
        NSData* database = [NSData dataWithContentsOfFile: filePath];
        
        if (database != nil) {
            MFMailComposeViewController* picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:[NSString stringWithFormat: @"%@ %@", [[UIDevice currentDevice] model], [filePath lastPathComponent]]];
            
            NSString* filename = [filePath lastPathComponent];
            [picker addAttachmentData: database mimeType:@"application/octet-stream" fileName: filename];
            NSString* emailBody = @"Attached is the SQLite data from my iOS device.";
            [picker setMessageBody:emailBody isHTML:YES];
            [self presentModalViewController:picker animated:YES];
            success = YES;
                  }
    }
    
    if (!success) {
        UIAlertView* warning = [[UIAlertView alloc] initWithTitle: @"Error"
                                                          message: @"Unable to send attachment!"
                                                         delegate: self
                                                cancelButtonTitle: @"Ok"
                                                otherButtonTitles: nil];
        [warning show];
        
    }
}
-(void) exportCsv: (NSString*) filename
{
    //self.tempFile = filename;
    
   
       //[self createTempFile: filename];
        /*NSOutputStream* output = [[NSOutputStream alloc] initToFileAtPath: filename append: YES];
        [output open];
            NSString* header = @"Source,Time,Latitude,Longitude,Accuracy\n";
            NSInteger result = [output write: [header UTF8String] maxLength: [header length]];
            /*if (result <= 0) {
                NSLog(@"exportCsv encountered error=%d from header write", result);
            }
            
            BOOL errorLogged = NO;
            NSString* sqlStatement = @"select timestamp,latitude,longitude,horizontalAccuracy from my_sqlite_table";
            
            // Setup the SQL Statement and compile it for faster access
            sqlite3_stmt* compiledStatement;
            if (sqlite3_prepare_v2(database, [sqlStatement UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
            {
                // Loop through the results and write them to the CSV file
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Read the data from the result row
                    NSInteger secondsSinceReferenceDate = (NSInteger)sqlite3_column_double(compiledStatement, 0);
                    float lat = (float)sqlite3_column_double(compiledStatement, 1);
                    float lon = (float)sqlite3_column_double(compiledStatement, 2);
                    float accuracy = (float)sqlite3_column_double(compiledStatement, 3);
                    
                    if (lat != 0 && lon != 0) {
                        NSDate* timestamp = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate: secondsSinceReferenceDate];
                        NSString* line = [[NSString alloc] initWithFormat: @"%@,%@,%f,%f,%d\n",
                                          table, [dateFormatter stringFromDate: timestamp], lat, lon, (NSInteger)accuracy];
                        result = [output write: [line UTF8String] maxLength: [line length]];
                        if (!errorLogged && (result <= 0)) {
                            NSLog(@"exportCsv write returned %d", result);
                            errorLogged = YES;
                        }
                      
                    }
                    // Release the compiled statement from memory
                    sqlite3_finalize(compiledStatement);
                }
            }
        */
        //[output close];
       /*NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    PersonEntity *person = [PersonEntity getPersonByName:@"yyyy"];
    [archiver encodeObject:person.attributes forKey:@"aaa"];
    [archiver finishEncoding];
     
    */
    
    //NSString *str;
    NSMutableArray *personNameArray = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    FMResultSet *results = [appDelegate.datebase executeQuery:@"select personName from person2"];
    while ([results next]) {
        [personNameArray addObject:[results stringForColumn:@"personName"]];
        
    }
    [results close];
        //[appDelegate.datebase executeUpdate:@"INSERT INTO person (personName) VALUES (?)",@"789"];
    [appDelegate.datebase close];
    NSString *sql = @"";
    for (int i=0; i<personNameArray.count;i++){
        PersonEntity *person = [PersonEntity getPersonByName:[personNameArray objectAtIndex:i]];
        sql = [sql stringByAppendingString:@"\n姓名,门诊号,出生日期,性别,固话,手机,QQ/Email,籍贯,地址,首次发病年,天,月,用药情况a. 外用润肤剂,b. 内服抗组胺药,c. 内服免疫抑制剂,d. 外用钙调神经抑制剂,e. 白三烯抑制剂和拮抗剂,f. 磷酸二脂酶抑制剂,g. 抗生素外用,内服,h. 激素外用,内服,i. 中药煎,湿敷,血常规:白细胞计数,中性细胞计数%,淋巴细胞%,嗜酸性粒细胞%,绝对计数,IgE,过敏性原测试结果,(1) 瘙痒,(2) 典型的皮损形态和分布，成人屈侧苔藓化或条状表现，婴儿和儿童面部及伸侧受累,(3) 慢性或慢性复发性皮炎,(4) 个人或家族遗传过敏史,哮喘,过敏性鼻炎,湿疹,过敏性结膜炎,药物,食物,其他,(1) 干皮症,(2) 鱼鳞病/掌纹症/毛周角化症,(3) 即刻型(I型)皮试反应,(4) 血清IgE增高,(5) 早年发病,(6) 皮肤感染倾向(特别是金黄色葡萄球菌和单纯疱疹)/损伤的细胞中介免疫,(7) 非特异性手足皮炎倾向,(8) 乳头湿疹,(9) 唇炎,(10) 复发性结合膜炎,(11) 旦尼莫根(Dennie Morgan)眶下褶痕,(12) 锥形角膜,(13) 前囊下白内障,(14) 眶周黑晕,(15) 苍白脸/面部皮炎,(16) 白色糠疹,(17) 颈前皱褶,(18) 出汗时瘙痒,(19) 对羊毛敏感,(20) 毛周隆起,(21) 对饮食敏感,(22) 病程受环境或情绪因素影响,(23) 白色划痕/延迟发白\n"];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
        [vals addObject:person.personName];
    for (int i = 2; i<66; i++) {
        [vals addObject:[person.attributes objectForKey:[NSString stringWithFormat:@"a%d",i]]];
    }
       
     sql = [sql stringByAppendingFormat:@"%@\n",  [vals componentsJoinedByString:@", "]];
        sql = [sql stringByAppendingString:@"日期,头部（正＋反）,正面躯干（自上到下）,反面躯干（自上到下）,左前臂（自上到下）,右前臂（自上到下）,左后臂（自上到下）,右后臂（自上到下）,左前腿（自上到下）,右前腿（自上到下）,左后腿（自上到下）,右后腿（自上到下）,干,红,肿,渗,挠,厚,睡,痒,总分,调查问卷\n"];
        [appDelegate.datebase open];
        NSMutableArray *recordArray = [[NSMutableArray alloc] init];
        FMResultSet *results1 = [appDelegate.datebase executeQuery:@"select * from record2 where personName = ?", person.personName];
       //FMResultSet *results = [appDelegate.datebase executeQuery:@"select * from record1"];
        
        while ([results1 next]) {
            //RecordEntity* recordEntity = [[RecordEntity alloc]init];
            //[recordEntity start];
            //recordEntity.date = [results1 stringForColumn:@"date"];
            sql = [sql stringByAppendingFormat:@"%@,",[results1 stringForColumn:@"date"]];
            

            
            
        sql = [sql stringByAppendingFormat:@"%@+%@,", [results1 stringForColumn:@"a201"],[results1 stringForColumn:@"a202"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@,", [results1 stringForColumn:@"a219"],[results1 stringForColumn:@"a220"], [results1 stringForColumn:@"a221"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@,", [results1 stringForColumn:@"a222"],[results1 stringForColumn:@"a223"], [results1 stringForColumn:@"a224"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@+%@,", [results1 stringForColumn:@"a204"],[results1 stringForColumn:@"a208"], [results1 stringForColumn:@"a212"],[results1 stringForColumn:@"a216"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@+%@,", [results1 stringForColumn:@"a203"],[results1 stringForColumn:@"a207"], [results1 stringForColumn:@"a211"],[results1 stringForColumn:@"a215"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@+%@,", [results1 stringForColumn:@"a205"],[results1 stringForColumn:@"a209"], [results1 stringForColumn:@"a213"],[results1 stringForColumn:@"a217"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@+%@,", [results1 stringForColumn:@"a206"],[results1 stringForColumn:@"a210"], [results1 stringForColumn:@"a214"],[results1 stringForColumn:@"a218"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@,", [results1 stringForColumn:@"a226"],[results1 stringForColumn:@"a230"], [results1 stringForColumn:@"a234"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@,", [results1 stringForColumn:@"a225"],[results1 stringForColumn:@"a229"], [results1 stringForColumn:@"a233"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@,", [results1 stringForColumn:@"a227"],[results1 stringForColumn:@"a231"], [results1 stringForColumn:@"a235"]];
        sql = [sql stringByAppendingFormat:@"%@+%@+%@,", [results1 stringForColumn:@"a228"],[results1 stringForColumn:@"a232"], [results1 stringForColumn:@"a236"]];
        
        for (int i=1; i<7; i++){
            NSString *key = [NSString stringWithFormat:@"a%d", i ];
            sql = [sql stringByAppendingFormat:@"%@,",  [results1 stringForColumn:key]];
        }
            for (int i=101; i<103; i++){
                NSString *key = [NSString stringWithFormat:@"a%d", i ];
                sql = [sql stringByAppendingFormat:@"%@,",  [results1 stringForColumn:key]];
            }
            sql = [sql stringByAppendingFormat:@"%@,",[results1 stringForColumn:@"point"]];

            sql = [sql stringByAppendingFormat:@"%@\n",  [results1 stringForColumn:@"a100"]];
                    }
        
        [results1 close];
        [appDelegate.datebase close];

    }
    
    NSStringEncoding strEncode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [sql dataUsingEncoding:strEncode];
    [data writeToFile:filename atomically:YES];
   
}

-(void) createTempFile: (NSString*) filename {
    NSFileManager* fileSystem = [NSFileManager defaultManager];
    [fileSystem removeItemAtPath: filename error: nil];
    
    NSMutableDictionary* attributes = [[NSMutableDictionary alloc] init];
    NSNumber* permission = [NSNumber numberWithLong: 0640];
    [attributes setObject: permission forKey: NSFilePosixPermissions];
    if (![fileSystem createFileAtPath: filename contents: nil attributes: attributes]) {
        NSLog(@"Unable to create temp file for exporting CSV.");
        // TODO: UIAlertView?
    }
   }

@end
