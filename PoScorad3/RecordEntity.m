//
//  RecordEntity.m
//  PoScorad3
//
//  Created by jiayi on 6/8/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import "RecordEntity.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "AppDelegate.h"

@implementation RecordEntity

@synthesize personName;
@synthesize date;
@synthesize records;
@synthesize age;
@synthesize point;

-(void) start{
    percent = [[NSMutableArray alloc] initWithObjects:@"8.5",@"8.5",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"6",@"6",@"6",@"6",@"6",@"6",
               @"2",@"2",@"2",@"2",@"2",@"2",
               @"2",@"2",@"2",@"2",@"2",@"2",
               @"4.5",@"4.5",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"1.125",@"1.125",@"1.125",@"1.125",
               @"6",@"6",@"6",@"6",@"6",@"6",
               @"3",@"3",@"3",@"3",@"3",@"3",
               @"3",@"3",@"3",@"3",@"3",@"3",nil];
    
    date = [[NSDate alloc]init];
    records = [[NSMutableDictionary alloc] init];
}
-(NSString*) getPoint{
    float f = 0.0, temp = 0.0;
    f = f+ [self getPointByTag:101] + [self getPointByTag:102];
    for (int i= 1; i<7; i++){
        temp += [self getPointByTag:i];
    }
    f+= temp*7/2;
    temp = 0.0;
    for (int i=201; i<237; i++){
        temp+= [[percent objectAtIndex:((i-201)+36*[age intValue])] floatValue]*[self getPointByTag:i];
    }
    f+=temp/5;
    return [NSString stringWithFormat:@"%.1f", f];
}
-(float) getPointByTag: (int) tag{
    return [[records objectForKey:[NSString stringWithFormat:@"a%d",tag]] floatValue];
}
-(void) addRecord:(NSString*)index value:(NSString*) value{
    if (value == nil){
        value = @"";
    }
    [records setObject:value forKey:index];

}
-(void) clear{
    [records removeAllObjects];
}

+(void) createRecord: (RecordEntity*) record {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in record.records) {
        [cols addObject:key];
        [vals addObject:[record.records objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    NSMutableArray* newVals = [[NSMutableArray alloc] init];
    for (int i = 0; i<[cols count]; i++) {
        [newCols addObject:[NSString stringWithFormat:@"%@", [cols objectAtIndex:i]]];
        [newVals addObject:[NSString stringWithFormat:@"'%@'", [vals objectAtIndex:i]]];
    }
    NSString* sql = [NSString stringWithFormat:@"insert into record2 (personName, date, age,point, %@) values ('%@', '%@', '%@','%@', %@);", [newCols componentsJoinedByString:@", "], record.personName, record.date, record.age,record.point,[newVals componentsJoinedByString:@", "]];
    
    
   /* for (int i = 0; i<[cols count]; i++) {
     [newCols addObject:[NSString stringWithFormat:@"%@ VARCHAR(50)", [cols objectAtIndex:i]]];
     [newVals addObject:[NSString stringWithFormat:@"'%@'", [vals objectAtIndex:i]]];
     }
     NSString* sql = [NSString stringWithFormat:@"CREATE TABLE record2 (personName VARCHAR(10), date VARCHAR(10), age VARCHAR(10), point VARCHAR(10),%@);", [newCols componentsJoinedByString:@", "]];
     */
     
    BOOL updateSuccess = [appDelegate.datebase executeUpdate:sql];
    
    NSLog(@"%@", sql);
    
    if([appDelegate.datebase hadError])
    {
        NSLog(@"Error %d : %@",[appDelegate.datebase lastErrorCode],[appDelegate.datebase lastErrorMessage]);
    }
    //[appDelegate.datebase executeUpdate:@"INSERT INTO person (personName) VALUES (?)",@"789"];
    //NSLog(@"%d", updateSuccess);
    /*FMResultSet *results = [appDelegate.datebase executeQuery:@"select * from test1"];
     while ([results next]) {
     NSString *s = [results stringForColumn:@"a2"];
     //[personArray addObject:personEntity];
     NSLog(@"%@", s);
     }
     if([appDelegate.datebase hadError])
     {
     NSLog(@"Error %d : %@",[appDelegate.datebase lastErrorCode],[appDelegate.datebase lastErrorMessage]);
     }*/
    
    [appDelegate.datebase close];
    
}

@end
