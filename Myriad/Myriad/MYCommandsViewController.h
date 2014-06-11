//
//  MYCommandsViewController.h
//  Myriad
//
//  Created by John Saba on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYCommandCell.h"

@interface MYCommandsViewController : UICollectionViewController <UICollectionViewDelegate, MYCommandCellDelegate, UIAlertViewDelegate>

@property (copy, nonatomic) NSString *deviceName;

@end
