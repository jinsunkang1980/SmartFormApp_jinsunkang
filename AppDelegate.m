#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"App did finish launching");
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"App became active");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"App will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"App entered background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"App will enter foreground");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"App will terminate");
}

@end
