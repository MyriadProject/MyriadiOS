//
//  MYDevice.h
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYDevice : NSObject

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *commands;

+ (instancetype)deviceWithName:(NSString*)name;
- (instancetype)initWithJson:(NSDictionary *)json;

@end
