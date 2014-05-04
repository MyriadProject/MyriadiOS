//
//  MYCommand.h
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYCommand : NSObject

@property (copy, nonatomic) NSString *name;
@property NSArray *codes;

- (instancetype)initWithJson:(NSDictionary *)json;
- (instancetype)initWithName:(NSString *)name array:(NSArray *)codes;
@end
