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
@property NSInteger deviceProtocol;
@property NSString* deviceHash;
@property NSInteger deviceBits;

- (instancetype)initWithJson:(NSDictionary *)json;
- (instancetype)initWithName:(NSString *)name deviceProtocol:(NSInteger)deviceProtocol deviceHash:(NSString *)deviceHash deviceBits:(NSInteger)deviceBits;
- (NSString *)description;

@end
