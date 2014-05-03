//
//  MYNewDeviceController.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYNewDeviceController.h"
#import "MYDevice.h"

@interface MYNewDeviceController ()

@property (copy, nonatomic) NSString *deviceName;
@property (weak, nonatomic) IBOutlet UITextField *deviceNameField;

@end

@implementation MYNewDeviceController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.deviceNameField.delegate = self;
}

- (IBAction)learnPressed:(id)sender
{
    if ([self.deviceName length] > 0)
    {
        [MYDevice deviceWithName:self.deviceName];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.deviceNameField resignFirstResponder];
    }
}

- (IBAction)deviceNameChanged:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    self.deviceName = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
