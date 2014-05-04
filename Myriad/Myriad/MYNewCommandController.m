//
//  MYNewCommandController.m
//  Myriad
//
//  Created by Ethan Gill on 5/4/14.
//  Copyright (c) 2014 Myriad. All rights reserved.
//

#import "MYNewCommandController.h"

@interface MYNewCommandController ()
@property BOOL isLearning;
@property int pass;
@property (strong, nonatomic) NSMutableArray * firstPass;
@property (strong, nonatomic) NSMutableArray * secondPass;
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
    [self.nameField becomeFirstResponder];
    self.nameField.delegate = self;
    [self.guideLabel1 setHidden:NO];
    [self.guideLabel2 setHidden:YES];
    [self.guideLabel3 setHidden:YES];
    [self.guideLabel4 setHidden:YES];
    [self.learnButton setHidden:NO];
    [self.verifyButton setHidden:YES];
    [self.indicatorView stopAnimating];
    self.isLearning = NO;
    self.pass = 1;
    self.firstPass = [[NSMutableArray alloc] init];
    self.secondPass = [[NSMutableArray alloc] init];
    [MYBLEManager sharedManager].delegate = self;
}
- (IBAction)buttonPressed:(UIButton *)sender {
    if(sender == self.learnButton){
        [[MYBLEManager sharedManager] sendString:@"START"];
        [self.guideLabel1 setHidden:YES];
        //in case of a failure eariler on
        [self.guideLabel4 setHidden:YES];
        [self.guideLabel2 setHidden:NO];
    } else if(sender == self.verifyButton){
        [[MYBLEManager sharedManager] sendString:@"START"];
    }
}

- (IBAction)cancelPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(self.isLearning){
        NSLog(@"Sending Stop command");
    [[MYBLEManager sharedManager] sendString:@"STOP"];
        self.isLearning = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

       if(textField.text && textField.text.length > 0){
           [textField resignFirstResponder];
            return YES;
       }
    return NO;

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
    NSString* string = [[NSString alloc] initWithBytes:data length:length encoding:NSASCIIStringEncoding];
    NSLog(@"%@",[NSString stringWithFormat:@"Received Data of length %d: %@",length,string]);
    
    //IF learning mode is now starting
    if([string isEqualToString:@"ACK"] && !self.isLearning) {
        NSLog(@"Acknowledge command received.");
        self.isLearning = YES;
        [self.indicatorView startAnimating];
    } else if ([string isEqualToString:@"FIN"]) {
        NSLog(@"FIN command received");
        if(self.pass == 1){
            [self.verifyButton setHidden:NO];
            [self.learnButton setHidden:YES];
            [self.indicatorView stopAnimating];
            [self.guideLabel2 setHidden:YES];
            [self.guideLabel3 setHidden:NO];
            self.pass++;
            self.isLearning = NO;
        }else if(self.pass == 2){
            [self.verifyButton setHidden:YES];
            [self.indicatorView stopAnimating];
            [self.guideLabel3 setHidden:YES];
            self.isLearning = NO;
            //just in case, you never know
            self.pass = 1;
            
            if([self.firstPass isEqualToArray:self.secondPass]){
                NSLog(@"THE COMMANDS MATCH HELL YES!");
                //TODO: create the object
                //TODO: maybe show some sort of success thingy
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                NSLog(@"The commmands do not match or are not being compared properly.");
                //display the error and reset all the things
                [self.guideLabel3 setHidden:YES];
                [self.guideLabel4 setHidden:NO];
                [self.learnButton setHidden:NO];
                [self.firstPass removeAllObjects];
                [self.secondPass removeAllObjects];
            }
        }
        //switch passes and stuff
    } else if (self.isLearning) {
        if(self.pass == 1){
            //we're assuming that the format of the string sent is now "int,hex,int"
            [self.firstPass addObject:(NSString *)string];
            NSLog(@"Data added to first pass.");
        }else if(self.pass == 2){
            [self.secondPass addObject:(NSString *)string];
            NSLog(@"Data added to second pass.");
        }
    }
    
}
//
//-(BOOL) passesAreEqual {
//    if([self.firstPass count] != [self.secondPass count]){
//        return NO;
//    }
//    for(int i=0;i<[self.firstPass count];i++){
//        if(![[self.firstPass objectAtIndex:i] isEqualToString:[self.secondPass objectAtIndex:i]]){
//            return NO;
//        }
//    }
//    return YES;
//}

- (void) bleManagerDidUpdateRSSI:(NSNumber *)rssi {
    
}

- (void) bleManagerForwardCentralManagerDidUpdateState:(CBCentralManager *)centralManager {
    
}

@end
