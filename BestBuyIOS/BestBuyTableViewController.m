//
//  BestBuyTableViewController.m
//  BestBuyIOS
//
//  Created by DX195 on 9/4/14.
//
//

#import "BestBuyTableViewController.h"
#import <AFNetworking/AFJSONRequestOperation.h>
#include "BestBuyParseData.h"
#include "BestBuyDetailedViewController.h"
#include "BestBuyResult.h"

static NSInteger const pageSize = 5;



@implementation BestBuyTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //NOTE: Should be in constructor
    
    self.pageNumber = 1;
    self.parser = [[BestBuyParseData alloc] init];

    NSString * encodedString = [self.productName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *urlStr = [NSMutableString stringWithFormat:@"http://api.remix.bestbuy.com/v1/products(name=%@*)?show=name,salePrice,image&format=json&pageSize=%i&page=%i&apiKey=vf5ft65skvwfvyd5guj6npef",
                        encodedString, pageSize, self.pageNumber ];
    NSURL * url = [NSURL URLWithString:urlStr];


    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFJSONRequestOperation * operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Response of getall rooms %@", JSON);
       self.parser.mainJsonDictionary = JSON;
        self.resultList = [self.parser parse];
        if ([self.resultList count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Results" message:@"No Results were found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        // use resultList to update UI here
        [self.tableview reloadData];

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"Error");

    }];

    [operation start];
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSString * encodedString = [self.productName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *urlStr = [NSMutableString stringWithFormat:@"http://api.remix.bestbuy.com/v1/products(name=%@*)?show=name,salePrice&format=json&pageSize=%i&page=%i&apiKey=vf5ft65skvwfvyd5guj6npef",
                          encodedString, pageSize, self.pageNumber ];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSData* data = [NSData dataWithContentsOfURL:
                        url];
        self.parser.json = data;
        
        self.resultList = [self.parser parse];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.resultList count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Results" message:@"No Results were found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            // use resultList to update UI here
            [self.tableview reloadData];

        });
    });
    */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
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

    BestBuyResult * item =[self.resultList objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    NSLog(item.name);
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableview.bounds.size.height / 6 ;
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
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"tableItemToDetailedView"]){
        BestBuyDetailedViewController *detailedViewController = (BestBuyDetailedViewController *)segue.destinationViewController;
        detailedViewController.imageUrl = self.destURL;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //UIViewController *detailedViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailedViewController"];
    // Navigation logic may go here, for example:
    // Create the next view controller.
    // <#DetailViewController#> *detailViewController = [[DetailViewController alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    //[self.navigationController pushViewController:detailedViewController animated:YES];


    BestBuyResult *item = [self.resultList objectAtIndex:indexPath.row];
    self.destURL = item.imageUrl;
    [self performSegueWithIdentifier:@"tableItemToDetailedView" sender:self];
}



@end
