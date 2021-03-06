//
//  MYNewCommandController.h
//  Myriad
//
//  Created by Ethan Gill on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBLEManager.h"

@interface MYNewCommandController : UIViewController <MYBLEManagerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UIButton *learnButton;
@property (strong, nonatomic) IBOutlet UIButton *verifyButton;
@property (strong, nonatomic) IBOutlet UILabel *guideLabel1;
@property (strong, nonatomic) IBOutlet UILabel *guideLabel2;
@property (strong, nonatomic) IBOutlet UILabel *guideLabel3;
@property (strong, nonatomic) IBOutlet UILabel *guideLabel4;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) IBOutlet UIButton *fakeLearnButton;

//the name of the device we're currently creating a command for
@property (strong, nonatomic) NSString *deviceName;

@end
