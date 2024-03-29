//
//  BestBuySearchViewController.m
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import "BestBuySearchViewController.h"
#include "BestBuyTableViewController.h"
@interface BestBuySearchViewController ()

@end

@implementation BestBuySearchViewController

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
    
    // Do any additional setup after loading the view from its nib.


    UILocalNotification * localNotification= [[UILocalNotification alloc] init];
    localNotification.category = @"myNotification";
    localNotification.alertAction = @"Open App";

    localNotification.alertBody = @"Click to open app, or swipe to see more options";

    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow: 6];

    UIApplication *app=[UIApplication sharedApplication];
    [app scheduleLocalNotification:localNotification];

    self.nameTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleSearchClick {
    self.productName = [NSMutableString stringWithString: self.nameTextField.text];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchButtonSegue"]){
        BestBuyTableViewController *tableController = (BestBuyTableViewController *)segue.destinationViewController;
        tableController.productName = self.productName;
    }
}

// UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	[theTextField resignFirstResponder];
    [self handleSearchClick];
    [self performSegueWithIdentifier:@"searchButtonSegue" sender:self];
	return YES;
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
             withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    NSLog(@"Trait collection = %@", newCollection);

}


@end
