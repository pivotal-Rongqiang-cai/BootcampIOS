//
//  BestBuySearchViewController.h
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import <UIKit/UIKit.h>

@interface BestBuySearchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) NSMutableString* productName;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@end
