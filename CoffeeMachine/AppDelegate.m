//
//  AppDelegate.m
//  PickerViewTest
//
//  Created by dancho on 8/6/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "OrderFinalizeFlow.h"
#import "CoffeeMachineState.h"

@implementation AppDelegate

@synthesize  coffeeMachineState;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //self.window.rootViewController = self.viewController;
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    [self.window makeKeyAndVisible];
    return YES;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
<<<<<<< HEAD
{    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
=======
{
    
   // OrderFinalizeFlow *finalize = [[OrderFinalizeFlow alloc]init];
   // self.coffeeMachineState = finalize.coffeeMachineState;
    //[self.coffeeMachineState saveStateToFile];
    NSLog(@"test");
    
>>>>>>> 44bb14223955142dc1b69937baa89cc085031862
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
<<<<<<< HEAD
     
=======
       

>>>>>>> 44bb14223955142dc1b69937baa89cc085031862
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
