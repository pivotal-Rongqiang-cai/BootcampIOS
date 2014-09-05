//
//  BestBuyTableViewController.h
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import <UIKit/UIKit.h>

@class BestBuyParseData;

@interface BestBuyTableViewController : UITableViewController
@property (strong, nonatomic)  NSString * productName;
@property (nonatomic)  NSInteger pageNumber;
@property (strong, nonatomic) BestBuyParseData * parser;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray * resultList;
@end
