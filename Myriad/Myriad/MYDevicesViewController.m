//
//  MYDevicesViewController.m
//  Myriad
//
//  Created by Ethan Gill on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYDevicesViewController.h"
#import "MYBLEManager.h"
#import "MYDeviceManager.h"
#import "MYDeviceCell.h"
#import "MYDevice.h"

@interface MYDevicesViewController ()

@end

@implementation MYDevicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // make sure we have most recent device manager;
    self.deviceManager = [MYDeviceManager manager];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.deviceManager allDevices] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:[MYDeviceCell class]])
    {
        MYDeviceCell *deviceCell = (MYDeviceCell *)cell;
        MYDevice *device = [[self.deviceManager allDevices] objectAtIndex:indexPath.row];
        deviceCell.deviceName.text = device.name;
    }
    
    return cell;
}

@end
