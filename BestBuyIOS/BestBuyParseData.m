//
//  BestBuyParseData.m
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import "BestBuyParseData.h"

@implementation BestBuyParseData

- (NSMutableArray * ) parse
{
    NSString* newStr = [[NSString alloc] initWithData:self.json encoding:NSUTF8StringEncoding];

    NSLog(newStr);
    NSError * error = nil;
    NSDictionary * mainJsonDictionary = [NSJSONSerialization JSONObjectWithData : self.json options: NSJSONReadingMutableContainers error: &error];
    NSArray * products = [ mainJsonDictionary objectForKey:@"products" ];
    NSMutableString * str;
    NSMutableString * priceStr;
    
    self.items = [NSMutableArray arrayWithCapacity:10];
    for (NSDictionary * dict in products) {

        str = [dict valueForKey:@"name"];
        priceStr = [dict valueForKey:@"salePrice"];
        str = [NSMutableString stringWithFormat:@"%@ %@",
         str, priceStr];
        [self.items addObject:str];
    }
    return self.items;
    
}

@end
