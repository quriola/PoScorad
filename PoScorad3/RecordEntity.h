//
//  RecordEntity.h
//  PoScorad3
//
//  Created by jiayi on 6/8/13.
//  Copyright (c) 2013 jiayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordEntity : NSObject {
    NSMutableArray *percent;
    
}
@property(nonatomic,retain) NSString *personName;
@property(nonatomic,retain) NSString *date;
@property(nonatomic,retain) NSMutableDictionary *records;
@property(nonatomic,retain) NSString *age;
@property(nonatomic,retain) NSString *point;

-(NSString*) getPoint;
-(void) start;
-(void) addRecord:(NSString*)index value:(NSString*) value;
-(void) clear;
+(void) createRecord: (RecordEntity*) record;
@end
