#import "BestBuyParseData.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(BestBuyParseDataSpec)

describe(@"BestBuyParseData", ^{
    __block BestBuyParseData *myParser;

    beforeEach(^{
        myParser = [[BestBuyParseData alloc] init];

        NSString* filePath = @"../Specs/json.txt";
        NSString* fileRoot = [[NSBundle mainBundle]
                              pathForResource:filePath ofType:@"txt"];
        NSString* fileContents = @"{\"from\": 1, \"products\": [ { \"name\": \"ADOPTED - Cushion Wrap Case for Apple® iPhone® 5 and 5s - Black/Rose Gold\", \"salePrice\": 39.99 } ] }";
        NSLog(fileContents);

        myParser.json = [fileContents dataUsingEncoding:NSUTF8StringEncoding];

    });
    
    it(@"Parsing JsonStr", ^{
        NSMutableArray * resultList = [myParser parse];
        [[resultList objectAtIndex:0] isEqualToString:@"ADOPTED - Cushion Wrap Case for Apple® iPhone® 5 and 5s - Black/Rose Gold 39.99"] should be_truthy;
    });
});

SPEC_END
