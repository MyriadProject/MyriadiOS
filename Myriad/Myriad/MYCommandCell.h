//
//  MYCommandCell.h
//  Myriad
//
//  Created by John Saba on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYCommandCell;

@protocol MYCommandCellDelegate <NSObject>

- (void)commandCellLongPress:(MYCommandCell *)cell;

@end

@interface MYCommandCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) id<MYCommandCellDelegate> delegate;

@end
