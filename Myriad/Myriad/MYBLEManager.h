//
//  MYBLEManager.h
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLE.h"

@interface MYBLEManager : NSObject <BLEDelegate>

+ (instancetype)sharedManager;

- (void)scanForPeripherals;
- (NSArray *)knownDevices;
- (void) sendString:(NSString *)string;
@end
