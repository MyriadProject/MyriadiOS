//
//  MYDevicesViewController.h
//  Myriad
//
//  Created by Ethan Gill on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYDeviceManager;

@interface MYDevicesViewController : UITableViewController

@property (strong, nonatomic) MYDeviceManager *deviceManager;

@end
