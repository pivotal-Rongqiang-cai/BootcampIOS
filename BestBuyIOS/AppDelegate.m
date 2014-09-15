//
//  AppDelegate.m
//  BestBuyIOS
//
//  Created by DX195 on 9/3/14.
//
//

#import "AppDelegate.h"
#import "BestBuyPhotoViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{


    UIMutableUserNotificationAction *viewGallery = [[UIMutableUserNotificationAction alloc] init];
    viewGallery.identifier = @"viewGallery";
    viewGallery.activationMode = UIUserNotificationActivationModeBackground;
    viewGallery.title = @"View Gallery";
    viewGallery.destructive = YES;

    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"myNotification"; //category name to send in the payload
    [category setActions:@[viewGallery] forContext:UIUserNotificationActionContextDefault];
    [category setActions:@[viewGallery] forContext:UIUserNotificationActionContextMinimal];

    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObjects:category,nil]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];



   // UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
   // [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
   // application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert |
     //                                                                       UIUserNotificationType.Badge, categories: nil))

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void) application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    if ([identifier isEqualToString:@"viewGallery"]) {

        UINavigationController *navigationController = (UINavigationController*) self.window.rootViewController;

       UIViewController * temp = [[navigationController viewControllers] objectAtIndex:0];
        [[[navigationController viewControllers] objectAtIndex:0] performSegueWithIdentifier:@"straightToPhotos" sender:self];
        /*
        UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BestBuyPhotoViewController* detailVC = [storyBoard instantiateViewControllerWithIdentifier:@"Photos"];
        [self.window.rootViewController presentViewController:detailVC animated:YES completion:nil];


        UINavigationController *mvc = (UINavigationController *)self.window.rootViewController;
        BestBuyPhotoViewController *lvc = [mvc.storyboard instantiateViewControllerWithIdentifier:@"BestBuyPhotoViewController"];
        [currentVC presentModalViewController:lvc animated:YES];

        BestBuyPhotoViewController * myPhotos = [[BestBuyPhotoViewController alloc ] init];

        [(UINavigationController*)self.window.rootViewController pushViewController:myPhotos animated:NO];
*/
    }

    completionHandler();
}

@end
