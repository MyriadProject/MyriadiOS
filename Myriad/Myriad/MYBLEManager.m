//
//  MYBLEManager.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYBLEManager.h"

@interface MYBLEManager ()

@property (strong, nonatomic) BLE *ble;

@end

@implementation MYBLEManager

+ (instancetype)sharedManager
{
    static MYBLEManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MYBLEManager alloc] init];
        sharedManager.ble = [[BLE alloc] init];
        [sharedManager.ble controlSetup];
        sharedManager.ble.delegate = sharedManager;
    });
    return sharedManager;
}

- (void)scanForPeripherals
{
    if (self.ble.activePeripheral)
    {
        if(self.ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [self.ble.CM cancelPeripheralConnection:self.ble.activePeripheral];
            return;
        }
    }
    
    if (self.ble.peripherals)
    {
        self.ble.peripherals = nil;
    }
    
    [self.ble findBLEPeripherals:4];
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

-(void) connectionTimer:(NSTimer *)timer
{
    if (self.ble.peripherals.count > 0)
    {
        [self.ble connectPeripheral:[self.ble.peripherals objectAtIndex:0]];
    }
}

#pragma mark - BLEDelegate

- (void)bleForwardCentralManagerDidUpdateState:(CBCentralManager *)centralManager
{
    if (centralManager.state == CBCentralManagerStatePoweredOn)
    {
        [self scanForPeripherals];
    }
}

- (void)bleDidConnect
{
    NSLog(@"ble did connect");
}

- (void)bleDidDisconnect
{
    NSLog(@"ble did disconnect");
}

- (void)bleDidUpdateRSSI:(NSNumber *)rssi
{
    NSLog(@"ble did update RSSI");
}

- (void)bleDidReceiveData:(unsigned char *)data length:(int)length
{
    NSLog(@"ble did receive data");
}

@end
