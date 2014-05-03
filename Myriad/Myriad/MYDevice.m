//
//  MYDevice.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYDevice.h"
#import "MYCommand.h"
#import "MYAppDelegate.h"

@implementation MYDevice

+ (instancetype)deviceWithName:(NSString*)name
{
    NSString *path = [[MYAppDelegate applicationDocumentsDirectory] stringByAppendingPathComponent:name];
    MYDevice *device = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!device)
    {
        device = [[MYDevice alloc] initWithName:name];
        [device archive];
    }
    return device;
}

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

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        self.name = name;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.commands = [aDecoder decodeObjectForKey:@"commands"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.commands forKey:@"commands"];
}

- (void)archive
{
    NSString* path = [[MYAppDelegate applicationDocumentsDirectory] stringByAppendingPathComponent:self.name];
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:path];
    if (!success)
    {
        NSLog(@"Warning: archive to path: '%@' unsuccesful!", path);
    }
}

@end
