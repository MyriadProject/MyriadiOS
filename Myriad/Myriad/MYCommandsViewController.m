//
//  MYCommandsViewController.m
//  Myriad
//
//  Created by John Saba on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYBLEManager.h"
#import "MYCommandsViewController.h"
#import "MYCommandCell.h"
#import "MYDeviceManager.h"
#import "MYDevice.h"
#import "MYCommand.h"
#import "MYNewCommandController.h"

@interface MYCommandsViewController ()

@property (strong, nonatomic) MYDevice *device;
@property (weak, nonatomic) UILabel *noCommandsLabel;

@end

@implementation MYCommandsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.deviceName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // make sure we have a fresh copy of device
    self.device = [[MYDeviceManager manager] deviceWithName:self.deviceName];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // display message if no commands
    if (self.device.commands.count < 1)
    {
        if (!self.noCommandsLabel)
        {
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont fontWithName:@"Helvetica Neue" size:32];
            label.textColor = [UIColor whiteColor];
            label.text = @"No Commands";
            [label sizeToFit];
            label.center = CGPointMake(320/2, 125);
            [self.view addSubview:label];
            self.noCommandsLabel = label;
        }
    }
    else
    {
        [self.noCommandsLabel removeFromSuperview];
    }
    
    return self.device.commands.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYCommandCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    
    if (indexPath.row < self.device.commands.count)
    {
        MYCommand *command = [self.device.commands objectAtIndex:indexPath.row];
        cell.nameLabel.text = command.name;
    }
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //all the stuff for sending a code
    MYCommand *command = [self.device.commands objectAtIndex:indexPath.row];
    [self recSendCodesFromArray:command.codes];
    
    
}

-(void) recSendCodesFromArray:(NSArray *)array {
    if([array count] == 0){
        return;
    } else {
        NSString *string = [array firstObject];
        NSArray *newArray = [array subarrayWithRange:NSMakeRange(1, [array count]-1)];
        
        [[MYBLEManager sharedManager] sendString:string];
        [self performSelector:@selector(recSendCodesFromArray:) withObject:newArray afterDelay:0.25];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
    MYNewCommandController *newCC =(MYNewCommandController *)nav.viewControllers.firstObject;
    newCC.deviceName = self.deviceName;
}

@end
