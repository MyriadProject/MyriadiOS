//
//  MYNewCommandController.h
//  Myriad
//
//  Created by Ethan Gill on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNewCommandController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property BOOL isLearning;
@property (strong, nonatomic) IBOutlet UIButton *learnButton;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *guideLabels;
@property (strong, nonatomic) IBOutlet UIButton *verifyButton;
@end
