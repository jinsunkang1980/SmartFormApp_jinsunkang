//
//  AppDelegate.m
//  SmartFormApp
//
//  Created on Assignment
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"AppDelegate: Application did finish launching with options");
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    NSLog(@"AppDelegate: Configuration for connecting scene session");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    NSLog(@"AppDelegate: Did discard scene sessions");
}

#pragma mark - App Lifecycle Methods

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"AppDelegate: Application did become active");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"AppDelegate: Application will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"AppDelegate: Application did enter background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"AppDelegate: Application will enter foreground");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"AppDelegate: Application will terminate");
}

@end
