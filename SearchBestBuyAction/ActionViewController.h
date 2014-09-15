//
//  ActionViewController.h
//  SearchBestBuyAction
//
//  Created by DX169-XL on 2014-09-08.
//
//

#import <UIKit/UIKit.h>

@class BestBuyParseData;

@interface ActionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) BestBuyParseData * parser;
@property (strong, nonatomic) NSMutableArray * resultList;
@end
