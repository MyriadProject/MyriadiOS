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
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MYDeviceManager manager] allDevices] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:[MYDeviceCell class]])
    {
        MYDeviceCell *deviceCell = (MYDeviceCell *)cell;
        MYDevice *device = [[[MYDeviceManager manager] allDevices] objectAtIndex:indexPath.row];
        deviceCell.deviceName.text = device.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        MYDevice *device = [[[MYDeviceManager manager] allDevices] objectAtIndex:indexPath.row];
        [[MYDeviceManager manager] unregisterDevice:device];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
