//
//  BestBuyDetailedViewController.m
//  BestBuyIOS
//
//  Created by DX195 on 9/5/14.
//
//

#import "BestBuyDetailedViewController.h"
#import "AFImageRequestOperation.h"
@import Photos;
@interface BestBuyDetailedViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation BestBuyDetailedViewController
- (IBAction)addImageToLibrary:(id)sender {
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

        PHAssetChangeRequest *request = [PHAssetChangeRequest creationRequestForAssetFromImage:self.image.image];

        //request.contentEditingOutput = contentEditingOutput;

    } completionHandler:^(BOOL success, NSError *error) {

        if (!success) {

            NSLog(@"Error: %@", error);
            
        }
        
    }];

}

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
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageUrl];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        self.image.image = [UIImage imageWithData:responseObject];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        self.image.frame = CGRectMake(self.image.frame.origin.x, self.image.frame.origin.y,
                                     self.image.image.size.width, self.image.image.size.height);


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
