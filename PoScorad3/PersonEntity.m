//
//  PersonEntity.m
//  SqliteDemo
//
//  Created by 俞 億 on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PersonEntity.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "AppDelegate.h"

@implementation PersonEntity
@synthesize personName;
@synthesize attributes;

-(void) start{
    attributes = [[NSMutableDictionary alloc] init];
}
+(void) createPerson: (PersonEntity*) person {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in person.attributes) {
        [cols addObject:key];
        [vals addObject:[person.attributes objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    NSMutableArray* newVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[cols count]; i++) {
        [newCols addObject:[NSString stringWithFormat:@"%@", [cols objectAtIndex:i]]];
        [newVals addObject:[NSString stringWithFormat:@"'%@'", [vals objectAtIndex:i]]];
    }
    NSString* sql = [NSString stringWithFormat:@"insert into person2 (personName, %@) values ('%@', %@);", [newCols componentsJoinedByString:@", "], person.personName, [newVals componentsJoinedByString:@", "]];
    /*
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE person2"];
     BOOL updateSuccess = [appDelegate.datebase executeUpdate:sqlstr];
     
     for (int i = 0; i<[cols count]; i++) {
     [newCols addObject:[NSString stringWithFormat:@"%@ VARCHAR(50)", [cols objectAtIndex:i]]];
     [newVals addObject:[NSString stringWithFormat:@"'%@'", [vals objectAtIndex:i]]];
     }
     NSString* sql = [NSString stringWithFormat:@"CREATE TABLE person2 (personName VARCHAR(10), %@);", [newCols componentsJoinedByString:@", "]];
    
  */
    NSLog(@"%@", sql);
     bool updateSuccess = [appDelegate.datebase executeUpdate:sql];
    
    if([appDelegate.datebase hadError])
    {
        NSLog(@"Error %d : %@",[appDelegate.datebase lastErrorCode],[appDelegate.datebase lastErrorMessage]);
    }
    //[appDelegate.datebase executeUpdate:@"INSERT INTO person (personName) VALUES (?)",@"789"];
    //NSLog(@"%d", updateSuccess);
   
    FMResultSet *results = [appDelegate.datebase executeQuery:@"select * from test1"];
    while ([results next]) {
        NSString *s = [results stringForColumn:@"a2"];
        //[personArray addObject:personEntity];
        NSLog(@"%@", s);
    }
    if([appDelegate.datebase hadError])
    {
        NSLog(@"Error %d : %@",[appDelegate.datebase lastErrorCode],[appDelegate.datebase lastErrorMessage]);
    }
    
    [appDelegate.datebase close];

}

+(PersonEntity*) getPersonByName: (NSString*) personName {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];

    [appDelegate.datebase open];
    
    FMResultSet *results = [appDelegate.datebase executeQuery:@"SELECT * FROM person2 WHERE personName = ?",personName];
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    for (int i = 2; i<66; i++) {
        [newCols addObject:[NSString stringWithFormat:@"a%d", i]];
    }
    PersonEntity *person =[[PersonEntity alloc] init];
    [person start];
    while ([results next]) {
    
    person.personName = personName;
    for (int i=2; i<66; i++){
        NSString *s = [results stringForColumn:[newCols objectAtIndex:(i-2)]] ;
        if (s!=nil){
            [person.attributes setObject:s forKey:[newCols objectAtIndex:(i-2)]];
            //NSLog(@"%@--%@", [newCols objectAtIndex:(i-2)],s);
        }
        else {
            [person.attributes setObject:@"" forKey:[newCols objectAtIndex:(i-2)]];
        }
        
    }
    
    NSLog(@"@%", [person.attributes objectForKey:@"a3"]);
    }
    /*for (int i = 0; i<[cols count]; i++) {
     [newCols addObject:[NSString stringWithFormat:@"a%@ VARCHAR(50)", [cols objectAtIndex:i]]];
     [newVals addObject:[NSString stringWithFormat:@"'%@'", [vals objectAtIndex:i]]];
     }
     NSString* sql = [NSString stringWithFormat:@"CREATE TABLE person2 (personName VARCHAR(10), %@);", [newCols componentsJoinedByString:@", "]];
     
     */
    
    //NSLog(@"%@", sql);
    //BOOL updateSuccess = [appDelegate.datebase executeUpdate:sql];
    
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
    [results close];
    [appDelegate.datebase close];
    return person;
    
}
/*+(NSMutableArray*) getPersonArray{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.datebase open];
    
    FMResultSet *results = [appDelegate.datebase executeQuery:@"SELECT * FROM person2 where personName = yyyy"];
    [appDelegate.datebase close];
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    for (int i = 2; i<66; i++) {
        [newCols addObject:[NSString stringWithFormat:@"a%d", i]];
    }
    

    while ([results next]) {
        PersonEntity *person =[[PersonEntity alloc] init];
        [person start];
        person.personName = [results stringForColumn:@"personName"];
        for (int i=2; i<66; i++){
            NSString *s = [results stringForColumn:[newCols objectAtIndex:(i-2)]] ;
            if (s!=nil){
                [person.attributes setObject:s forKey:[newCols objectAtIndex:(i-2)]];
               // NSLog(@"%@--%@", [newCols objectAtIndex:(i-2)],s);
            }
            else {
                [person.attributes setObject:@"" forKey:[newCols objectAtIndex:(i-2)]];
            }
            
        }
        [resultArray addObject:person];
        
        //NSLog(@"@%", [person.attributes objectForKey:@"a3"]);
    }
      
    if([appDelegate.datebase hadError])
    {
        NSLog(@"Error %d : %@",[appDelegate.datebase lastErrorCode],[appDelegate.datebase lastErrorMessage]);
    }
    
    return resultArray;
   

}
*/
@end
