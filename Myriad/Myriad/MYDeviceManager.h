//
//  MYDeviceManager.h
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYDevice;
@class MYCommand;

@interface MYDeviceManager : NSObject

+ (instancetype)manager;

- (void)registerDevice:(MYDevice*)device;
- (void)unregisterDevice:(MYDevice *)device;
- (NSArray *)allDevices;
- (MYDevice *)deviceWithName:(NSString *)name;
- (void)archive;
- (void) createCommand:(MYCommand *)command inDeviceWithName:(NSString *)name;
@end
