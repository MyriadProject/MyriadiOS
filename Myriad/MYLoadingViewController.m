//
//  MYLoadingViewController.m
//  Myriad
//
//  Created by Ethan Gill on 5/3/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

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
    _shimmeringView.shimmeringOpacity = 0.3;
    [self.view addSubview:_shimmeringView];
    
    _logoLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    _logoLabel.text = @"Connecting";
    _logoLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60.0];
    _logoLabel.textColor = [UIColor whiteColor];
    _logoLabel.textAlignment = NSTextAlignmentCenter;
    _logoLabel.backgroundColor = [UIColor clearColor];
    _shimmeringView.contentView = _logoLabel;
    
    // BLE
    self.ble = [[BLE alloc] init];
    [self.ble controlSetup];
    self.ble.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect shimmeringFrame = self.view.bounds;
    shimmeringFrame.origin.y = shimmeringFrame.size.height * 0.68;
    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.32;
    _shimmeringView.frame = shimmeringFrame;
}

- (void)scanForPeripherals
{
    if (self.ble.activePeripheral)
    {
        if(self.ble.activePeripheral.state == CBPeripheralStateConnected)
        {
            [self.ble.CM cancelPeripheralConnection:self.ble.activePeripheral];
            return;
        }
    }
    
    if (self.ble.peripherals)
    {
        self.ble.peripherals = nil;
    }
    
    [self.ble findBLEPeripherals:4];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
//    [indConnecting startAnimating];
}

-(void) connectionTimer:(NSTimer *)timer
{
//    [btnConnect setEnabled:true];
//    [btnConnect setTitle:@"Disconnect" forState:UIControlStateNormal];
    
    if (self.ble.peripherals.count > 0)
    {
        [self.ble connectPeripheral:[self.ble.peripherals objectAtIndex:0]];
    }
    else
    {
//        [btnConnect setTitle:@"Connect" forState:UIControlStateNormal];
//        [indConnecting stopAnimating];
    }
}

#pragma mark - BLEDelegate

- (void)bleForwardCentralManagerDidUpdateState:(CBCentralManager *)centralManager
{
    if (centralManager.state == CBCentralManagerStatePoweredOn)
    {
        [self scanForPeripherals];
    }
}

- (void)bleDidConnect
{
    NSLog(@"did connect yeahhh!");
}

- (void)bleDidDisconnect
{
    
}

- (void)bleDidUpdateRSSI:(NSNumber *)rssi
{
    
}

- (void)bleDidReceiveData:(unsigned char *)data length:(int)length
{
    
}

@end
