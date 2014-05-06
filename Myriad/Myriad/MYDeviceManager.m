//
//  MYDeviceManager.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYDeviceManager.h"
#import "MYAppDelegate.h"
#import "MYDevice.h"
#import "MYCommand.h"

@interface MYDeviceManager ()

@property (strong, nonatomic) NSMutableDictionary *devices;
@property (weak, nonatomic) id <NSObject> hello;

@end

@implementation MYDeviceManager

+ (instancetype)manager
{
    MYDeviceManager *manager = [NSKeyedUnarchiver unarchiveObjectWithFile:[MYDeviceManager filePath]];
    if (!manager)
    {
        manager = [[MYDeviceManager alloc] init];
        [manager archive];
    }
    return manager;
}

+ (NSString*)filePath
{
    return [[MYAppDelegate applicationDocumentsDirectory] stringByAppendingPathComponent:@"DeviceManagerStore"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.devices = [aDecoder decodeObjectForKey:@"devices"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.devices forKey:@"devices"];
}

- (void)archive
{
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:[MYDeviceManager filePath]];
    if (!success)
    {
        NSLog(@"Warning: archive to path: '%@' unsuccesful!", [MYDeviceManager filePath]);
    }
}

- (void)registerDevice:(MYDevice*)device
{
    if (!self.devices)
    {
        self.devices = [NSMutableDictionary dictionary];
    }
    [self.devices setObject:device forKey:device.name];
    [self archive];
}

- (void)unregisterDevice:(MYDevice *)device
{
    [self.devices removeObjectForKey:device.name];
    [self archive];
}

- (NSArray *)allDevices
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [[self.devices allValues] sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (void)createCommand:(MYCommand *)command inDeviceWithName:(NSString *)name
{
    MYDevice *device = [self deviceWithName:name];
    
    if(!device.commands)
    {
        device.commands = [[NSArray alloc] init];
    }
    device.commands = [device.commands arrayByAddingObject:command];
    [self archive];
}

- (void)removeCommand:(MYCommand *)command inDeviceWithName:(NSString *)name
{
    MYDevice *device = [self deviceWithName:name];
    
    NSMutableArray *mutableCommands = [NSMutableArray arrayWithArray:device.commands];
    NSUInteger match = [device.commands indexOfObjectPassingTest:^BOOL(MYCommand *c, NSUInteger idx, BOOL *stop) {
        return [command.name isEqualToString:c.name];
    }];
    if (match != NSNotFound)
    {
        [mutableCommands removeObjectAtIndex:match];
        device.commands = [NSArray arrayWithArray:mutableCommands];
        [self archive];
    }
    else
    {
        NSLog(@"Warning: cannot delete command '%@' with device '%@' because command was not found", command.name, device.name);
    }
}

- (MYDevice *)deviceWithName:(NSString *)name
{
    return self.devices[name];
}

@end
