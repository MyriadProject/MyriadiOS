//
//  MYCommand.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYCommand.h"

@implementation MYCommand

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self)
    {
        self.name = json[@"name"];
        self.deviceProtocol = [json[@"device_protocol"] integerValue];
        self.deviceHash = [json[@"device_hash"] integerValue];
        self.deviceBits = [json[@"device_bits"] integerValue];
    }
    return self;
}

@end
