//
//  BestBuyParseData.m
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import "BestBuyParseData.h"
#include "BestBuyResult.h"
@implementation BestBuyParseData

- (NSMutableArray * ) parse
{

    NSArray * products = [ self.mainJsonDictionary objectForKey:@"products" ];
    NSMutableString * str;
    NSMutableString * priceStr;
    self.items = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dict in products) {
        str = [dict valueForKey:@"name"];
        priceStr = [dict valueForKey:@"salePrice"];
        str = [NSMutableString stringWithFormat:@"%@ $%@",
         str, priceStr];
        BestBuyResult * result = [[BestBuyResult alloc] init];
        result.name = str;
        result.imageUrl = [NSURL URLWithString:[dict valueForKey:@"image"]];
        [self.items addObject:result];
    }
    return self.items;
    
}

@end
