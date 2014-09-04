//
//  BestBuyParseData.h
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import <Foundation/Foundation.h>

@interface BestBuyParseData : NSObject
@property (strong,nonatomic) NSMutableArray * items;
@property (strong,nonatomic) NSData * json;
-   (NSMutableArray * )parse;
@end
