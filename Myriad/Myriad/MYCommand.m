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
        self.codes = json[@"codes"];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name array:(NSArray *)codes
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.codes = codes;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.codes = [aDecoder decodeObjectForKey:@"codes"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.codes forKey:@"codes"];
}



@end
