//
//  MYNewDeviceController.m
//  Myriad
//
//  Created by John Saba on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYNewDeviceController.h"
#import "MYDevice.h"
#import "MYDeviceManager.h"

@interface MYNewDeviceController ()

@property (copy, nonatomic) NSString *deviceName;
@property (weak, nonatomic) IBOutlet UITextField *deviceNameField;

@end

@implementation MYNewDeviceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.deviceNameField becomeFirstResponder];
    self.deviceNameField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // make sure we have most recent device manager;
    self.deviceManager = [MYDeviceManager manager];
}
- (IBAction)cancelPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePressed:(UIBarButtonItem *)sender
{
    if ([self.deviceName length] > 0)
    {
        // don't overwrite a device with an existing name
        MYDevice *device = [self.deviceManager deviceWithName:self.deviceName];
        if (!device)
        {
            device = [[MYDevice alloc] initWithName:self.deviceName];
            [self.deviceManager registerDevice:device];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
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
