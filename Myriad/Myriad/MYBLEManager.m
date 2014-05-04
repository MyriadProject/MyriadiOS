//
//  MYBLEManager.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYBLEManager.h"
#import "MYDevice.h"
#import "MYCommand.h"

@interface MYBLEManager ()

@property (strong, nonatomic) BLE *ble;
@property (strong, nonatomic) NSMutableArray* devices;

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
        
        sharedManager.devices = [NSMutableArray array];
        
        // TODO: just hardcode in a test device for now
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testDevices" ofType:@"json"]];
        NSArray *devices = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:&error]];
        sharedManager.devices = [NSMutableArray array];
        for (NSDictionary *d in devices)
        {
            MYDevice *device = [[MYDevice alloc] initWithJson:d];
            [sharedManager.devices addObject:device];
        }
    });
    return sharedManager;
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
    
    [self.delegate bleManagerDidConnect];
    NSLog(@"ble did connect");
}

- (void)bleDidDisconnect
{
    [self.delegate bleManagerDidDisconnect];
    NSLog(@"ble did disconnect");
}

- (void)bleDidUpdateRSSI:(NSNumber *)rssi
{
    [self.delegate bleManagerDidUpdateRSSI:rssi];
    NSLog(@"ble did update RSSI");
}

- (void)bleDidReceiveData:(unsigned char *)data length:(int)length
{
    [self.delegate bleManagerDidReceiveData:data length:length];
    NSLog(@"ble did receive data");
}

#pragma mark - Public

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

- (NSArray *)knownDevices
{
    return [NSArray arrayWithArray:self.devices];
}

- (void) sendString:(NSString *)string
{
    NSString *s;
    NSData *d;
    
    if (string.length > 16)
        s = [string substringToIndex:16];
    else
        s = string;
    
    d = [s dataUsingEncoding:NSUTF8StringEncoding];
    if (self.ble.activePeripheral.state == CBPeripheralStateConnected) {
        [self.ble write:d];
    }
}

@end
