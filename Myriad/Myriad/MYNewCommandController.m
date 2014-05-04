//
//  MYNewCommandController.m
//  Myriad
//
//  Created by Ethan Gill on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYNewCommandController.h"
#import "MYBLEManager.h"

@interface MYNewCommandController ()

@end


@implementation MYNewCommandController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isLearning = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
