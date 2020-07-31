//
//  AppDelegate.m
//  XJTestDemo
//
//  Created by mac on 2020/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ClassViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *rootViewController = [[ViewController alloc] init];
    
    [[XJNavigationController shareXJNavigationController] pushViewController:rootViewController animated:NO];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.alpha = 1.0f;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [XJNavigationController shareXJNavigationController];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


@end
