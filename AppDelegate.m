//
//  AppDelegate.m
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"✅ App launched successfully on VMware macOS 14 + Xcode 15.3!");
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    NSLog(@"🔧 Setting up scene session on VMware");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    NSLog(@"🗑️ Scene sessions discarded");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"🟢 App became active!");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"🟡 App will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"⚫ App entered background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"🔵 App will enter foreground");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"🔴 App is about to terminate");
}

@end
