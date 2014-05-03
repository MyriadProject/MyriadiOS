//
//  MYTestViewController.m
//  Myriad
//
//  Created by Ethan Gill on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYTestViewController.h"
#import "MYBLEManager.h"

@interface MYTestViewController ()

@end

@implementation MYTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)sendTestCommand:(id)sender {
    [[MYBLEManager sharedManager] sendString:@"1,77E1C0DA,32"];
    NSLog(@"Sending Test String to Arduino");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
