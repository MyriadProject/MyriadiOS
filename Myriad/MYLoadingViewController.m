//
//  MYLoadingViewController.m
//  Myriad
//
//  Created by Ethan Gill on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYBLEManager.h"
#import "MYLoadingViewController.h"
#import "FBShimmeringView.h"

@interface MYLoadingViewController (){
    UIImageView *_wallpaperView;
    FBShimmeringView *_shimmeringView;
    UIView *_contentView;
    UILabel *_logoLabel;
    
    UILabel *_valueLabel;
    
    CGFloat _panStartValue;
    BOOL _panVertical;

}

@end

@implementation MYLoadingViewController

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
    
    //Shimmer stuff
    self.view.backgroundColor = [UIColor blackColor];
    
    _wallpaperView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _wallpaperView.image = [UIImage imageNamed:@"Wallpaper"];
    _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_wallpaperView];
    
    CGRect valueFrame = self.view.bounds;
    valueFrame.size.height = valueFrame.size.height * 0.25;
    
    _shimmeringView = [[FBShimmeringView alloc] init];
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.3;
    _shimmeringView.shimmeringOpacity = 0.45;
    [self.view addSubview:_shimmeringView];
    
    _logoLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    _logoLabel.text = @"Connecting";
    _logoLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:54.0];
    _logoLabel.textColor = [UIColor whiteColor];
    _logoLabel.textAlignment = NSTextAlignmentCenter;
    _logoLabel.backgroundColor = [UIColor clearColor];
    _shimmeringView.contentView = _logoLabel;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapped:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    [[MYBLEManager sharedManager] scanForPeripherals];
    [MYBLEManager sharedManager].delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_tapped:(UITapGestureRecognizer *)tapRecognizer
{
    [self hideLoadingView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect shimmeringFrame = self.view.bounds;
    shimmeringFrame.origin.y = shimmeringFrame.size.height * 0.68;
    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.32;
    _shimmeringView.frame = shimmeringFrame;
}

-(void) hideLoadingView {
    _shimmeringView.shimmering = NO;
    
    UITabBarController* tbController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainTabView"];
    [self presentViewController:tbController animated:YES completion:nil];
    [MYBLEManager sharedManager].delegate = nil;
}

#pragma mark MYBLEManager methods

- (void) bleManagerDidConnect {
    NSLog(@"CONNECTED");
    [self hideLoadingView];
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
