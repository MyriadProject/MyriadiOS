//
//  MYBLEManager.h
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLE.h"

@protocol MYBLEManagerDelegate
@optional
@required
-(void) bleManagerDidConnect;
-(void) bleManagerDidDisconnect;
-(void) bleManagerDidUpdateRSSI:(NSNumber *) rssi;
-(void) bleManagerDidReceiveData:(unsigned char *) data length:(int) length;
// Myriad Edits
-(void) bleManagerForwardCentralManagerDidUpdateState:(CBCentralManager *)centralManager;

@end

@interface MYBLEManager : NSObject <BLEDelegate>

@property (weak, nonatomic) id <MYBLEManagerDelegate> delegate;

+ (instancetype)sharedManager;

- (void)scanForPeripherals;
- (NSArray *)knownDevices;
- (void) sendString:(NSString *)string;
@end


