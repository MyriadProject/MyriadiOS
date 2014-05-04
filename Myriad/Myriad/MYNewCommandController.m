//
//  MYNewCommandController.m
//  Myriad
//
//  Created by Ethan Gill on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYNewCommandController.h"

@interface MYNewCommandController ()

@end


@implementation MYNewCommandController


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
    // Do any additional setup after loading the view.
    self.isLearning = NO;
    [MYBLEManager sharedManager].delegate = self;
}

- (IBAction)cancelPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.isLearning){
    [[MYBLEManager sharedManager] sendString:@"STOP"];
        self.isLearning = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark MYBLEManager methods

- (void) bleManagerDidConnect {
    NSLog(@"CONNECTED");
}

- (void) bleManagerDidDisconnect {
    
}

- (void) bleManagerDidReceiveData:(unsigned char *)data length:(int)length {
    
}

- (void) bleManagerDidUpdateRSSI:(NSNumber *)rssi {
    
}

- (void) bleManagerForwardCentralManagerDidUpdateState:(CBCentralManager *)centralManager {
    
}

@end
