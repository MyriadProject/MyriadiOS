//
//  MYCommandCell.m
//  Myriad
//
//  Created by John Saba on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYCommandCell.h"

@interface MYCommandCell ()

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressRecognizer;

@end

@implementation MYCommandCell

- (void)awakeFromNib
{
    self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:self.longPressRecognizer];
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        [self.delegate commandCellLongPress:self];
    }
}

@end
