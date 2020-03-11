//
//  AppDelegate.m
//  AMapDemo
//
//  Created by 关云秀 on 2020/3/11.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MapViewController *vc= [MapViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    [AMapServices sharedServices].apiKey = @"48a797eb2f0bee7339bedcfc6e6e5d45";
    return YES;
}


@end
