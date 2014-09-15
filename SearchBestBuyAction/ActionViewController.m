//
//  ActionViewController.m
//  SearchBestBuyAction
//
//  Created by DX169-XL on 2014-09-08.
//
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BestBuyParseData.h"
#import "BestBuyResult.h"
#include "HTMLParser.h"
@interface ActionViewController ()

//@property(strong,nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewAction;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) NSExtensionContext * myContext;
@end

@implementation ActionViewController
@synthesize resultList;
- (void) beginRequestWithExtensionContext:(NSExtensionContext*) context {
    self.myContext = context;
}

- (void)itemLoadCompletedWithPreprocessingResults:(NSDictionary *)javaScriptPreprocessingResults {

}

- (void)viewDidLoad {
    [super viewDidLoad];


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSExtensionContext *myExtensionContext = self.myContext;
        NSArray *inputItems = [myExtensionContext inputItems];
        for(NSExtensionItem* item in inputItems) {

            for (NSItemProvider *itemProvider in item.attachments) {
                if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"]) {
                    [itemProvider loadItemForTypeIdentifier:@"public.url"  options:nil completionHandler:^(NSURL * urlItem, NSError * error) {
                        NSString *str= [NSString stringWithContentsOfURL:urlItem];
                        HTMLParser *parser = [[HTMLParser alloc] initWithString:str error:&error];
                        HTMLNode *bodyNode = [parser body];

                        NSArray *h1Nodes = [bodyNode findChildTags:@"h1"];
                        NSString * productName;

                        productName = [[h1Nodes objectAtIndex:0] contents];


                        NSInteger pageNumber = 1;
                        self.parser = [[BestBuyParseData alloc] init];




                        NSString * encodedString = [[[productName stringByReplacingOccurrencesOfString:@"(" withString:@" "] stringByReplacingOccurrencesOfString:@")" withString:@" "] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];



                        NSString *urlStr = [NSMutableString stringWithFormat:@"http://api.remix.bestbuy.com/v1/products(name=%@*)?show=name,salePrice,image&format=json&pageSize=%i&page=%i&apiKey=vf5ft65skvwfvyd5guj6npef",
                                            encodedString, 10, pageNumber ];


                        NSURL * url = [NSURL URLWithString:urlStr];
                        NSData* data = [NSData dataWithContentsOfURL:
                                        url];
                        self.parser.mainJsonDictionary = [NSJSONSerialization JSONObjectWithData : data options: NSJSONReadingMutableContainers error: &error];;
                        
                        self.resultList = [self.parser parse];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (!str) {
                                [self.label setText:[NSString stringWithFormat:@"%@", urlItem]];
                            } else {
                                [self.label setText:[NSString stringWithFormat:@"%@", encodedString]];
                            }
                            [self.tableViewAction reloadData];
                        });
                    }];
                }
            }
        }
    });


/*

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSString *textType = (NSString *)kUTTypeText;

        NSExtensionContext *myExtensionContext = self.myContext;
        NSArray *inputItems = [myExtensionContext inputItems];
        NSInteger length = 0;
        for(NSExtensionItem* item in inputItems) {

            for (NSItemProvider *itemProvider in item.attachments) {
                length++;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.label2 setText:[NSString stringWithFormat:@"%d", length]];
                });                if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypePropertyList]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [self.label2 setText:[NSString stringWithFormat:@"%d", 1234]];
                        });
                    [itemProvider loadItemForTypeIdentifier:textType options:nil
                    completionHandler:^(NSString *string, NSError *error) {
                        if (string) {
                            NSString * productName = string;
                            NSInteger pageNumber = 1;
                            self.parser = [[BestBuyParseData alloc] init];

                            NSString * encodedString = [productName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

                            NSString *urlStr = [NSMutableString stringWithFormat:@"http://api.remix.bestbuy.com/v1/products(name=%@*)?show=name,salePrice&format=json&pageSize=%i&page=%i&apiKey=vf5ft65skvwfvyd5guj6npef",
                                                encodedString, 5, pageNumber ];
                            NSURL * url = [NSURL URLWithString:urlStr];
                            NSData* data = [NSData dataWithContentsOfURL:
                                            url];
                            self.parser.mainJsonDictionary = data;

                            self.resultList = [self.parser parse];

                            dispatch_async(dispatch_get_main_queue(), ^{
                                 [self.tableViewAction reloadData];
                            });
                                    

                        }
                    }];

                } else if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"]) {
                    [itemProvider loadItemForTypeIdentifier:@"public.url"  options:nil completionHandler:^(NSURL * urlItem, NSError * error) {
                         NSString *str= [NSString stringWithContentsOfURL:urlItem];
                        HTMLParser *parser = [[HTMLParser alloc] initWithString:str error:&error];


                        HTMLNode *bodyNode = [parser body];

                        NSArray *h1Nodes = [bodyNode findChildTags:@"h1"];
                        NSString * productName;
                        NSString * test;

                        

                        if (![[h1Nodes objectAtIndex:0]contents]) {
                            HTMLNode * header = [parser head];
                            NSArray * title = [header findChildTag:@"title"];
                            productName = [[title objectAtIndex:0 ] rawContents];
                            test = @"a";

                        }else{
                            productName = [[h1Nodes objectAtIndex:0] contents];
                            test = @"b";
                        }


                        NSInteger pageNumber = 1;
                        self.parser = [[BestBuyParseData alloc] init];



                        
                        NSString * encodedString = [[[productName stringByReplacingOccurrencesOfString:@"(" withString:@" "] stringByReplacingOccurrencesOfString:@")" withString:@" "] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];



                        NSString *urlStr = [NSMutableString stringWithFormat:@"http://api.remix.bestbuy.com/v1/products(name=%@*)?show=name,salePrice&format=json&pageSize=%i&page=%i&apiKey=vf5ft65skvwfvyd5guj6npef",
                                            encodedString, 10, pageNumber ];


                        NSURL * url = [NSURL URLWithString:urlStr];
                        NSData* data = [NSData dataWithContentsOfURL:
                                        url];
                        self.parser.mainJsonDictionary = data;

                        self.resultList = [self.parser parse];

                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (!str) {
                                [self.label setText:[NSString stringWithFormat:@"%@", urlItem]];
                            } else {
                                [self.label setText:[NSString stringWithFormat:@"%@", encodedString]];
                            }
                            [self.tableViewAction reloadData];
                        });


*/






                     // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
    /*
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                // This is an image. We'll load it, then place it in our image view.
                __weak UIImageView *imageView = self.imageView;
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
                    if(image) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [imageView setImage:image];
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.myContext completeRequestReturningItems:nil completionHandler:nil];
}


#pragma mark UITableViewDelegate


    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        // Return the number of sections.
        return 1;
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.resultList count];
}


    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier /*forIndexPath:indexPath*/];

        // Configure the cell...
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        }
        BestBuyResult * temp =[self.resultList objectAtIndex:indexPath.row];
        cell.textLabel.text = temp.name;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        return cell;
    }
/*
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return self.tableViewAction.bounds.size.height / 6 ;
    }

- (UIViewController*)loadAndPresentVCNamed:(NSString*)vcName
                       fromStoryboardNamed:(NSString*)sbName;
{
    // 1. Get the storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];

    // 2. Edit the vcName if necessary (optional)
    // If you don't have a separate items in your Storyboard w/ it's Storyboard ID
    // set to "<vcName>_iPhone", remove the next 2 lines.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        vcName = [NSString stringWithFormat:@"%@_iPhone", vcName];

    // 3. Get the controller from the storyboard.
    UIViewController *controller = (UIViewController *)
    [storyboard instantiateViewControllerWithIdentifier:vcName];

    // 4. Present the vc and return it.
    [self presentViewController:controller animated:YES completion:nil];
    return controller;
}*/


@end
