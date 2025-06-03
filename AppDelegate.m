objc//
//  AppDelegate.m

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"App has launched successfully.");
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    NSLog(@"Setting up scene session.");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    NSLog(@"Scene sessions discarded.");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"App is active again!");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"App will resign active (incoming call or home button).");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"App entered background.");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"App will enter foreground.");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"App is about to terminate.");
}

@end
