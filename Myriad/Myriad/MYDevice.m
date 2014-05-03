//
//  MYDevice.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYDevice.h"
#import "MYCommand.h"

@implementation MYDevice

- (instancetype)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if (self)
    {
        self.name = json[@"name"];
        
        NSMutableArray *commands = [NSMutableArray array];
        for (NSDictionary *c in json[@"commands"])
        {
            MYCommand *command = [[MYCommand alloc] initWithJson:c];
            [commands addObject:command];
        }
        self.commands = [NSArray arrayWithArray:commands];
    }
    return self;
}

@end
