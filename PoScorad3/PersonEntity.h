//
//  PersonEntity.h
//  SqliteDemo
//
//  Created by 俞 億 on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonEntity : NSObject
@property(nonatomic,retain) NSString *personName;
@property(nonatomic,retain) NSMutableDictionary *attributes;
-(void) start;
+(void) createPerson: (PersonEntity*) person;
+(PersonEntity*) getPersonByName: (NSString*) personName;
+(NSMutableArray*) getPersonArray;
@end
