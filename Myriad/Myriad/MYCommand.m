//
//  MYCommand.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYAppDelegate.h"
#import "MYCommand.h"

@implementation MYCommand

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self)
    {
        self.name = json[@"name"];
        self.deviceProtocol = [json[@"device_protocol"] integerValue];
        self.deviceHash = json[@"device_hash"];
        self.deviceBits = [json[@"device_bits"] integerValue];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name deviceProtocol:(NSInteger)deviceProtocol deviceHash:(NSString *)deviceHash deviceBits:(NSInteger)deviceBits
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.deviceProtocol = deviceProtocol;
        self.deviceHash = deviceHash;
        self.deviceBits = deviceBits;
    }
    return self;
}

//use description to send data using MYBLEManager to the Arduino!
-(NSString *)description
{
    return [NSString stringWithFormat:@"%ld,%@,%ld",(long)self.deviceProtocol,self.deviceHash,(long)self.deviceBits];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToCommand:other];
}

- (BOOL)isEqualToCommand:(MYCommand *)command {
    if (self == command)
        return YES;
    if ([self deviceProtocol] != [command deviceProtocol])
        return NO;
    if (![[self deviceHash] isEqual:[command deviceHash]])
        return NO;
    if ([self deviceBits] != [command deviceBits])
        return NO;
    return YES;
}

@end
