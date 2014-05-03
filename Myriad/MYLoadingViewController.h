//
//  MYLoadingViewController.h
//  Myriad
//
//  Created by Ethan Gill on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLE.h"

@interface MYLoadingViewController : UIViewController <BLEDelegate>

@property (strong, nonatomic) BLE *ble;

@end
