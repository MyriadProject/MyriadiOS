//
//  MYNewDeviceController.h
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYDeviceManager;

@interface MYNewDeviceController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) MYDeviceManager *deviceManager;

@end
