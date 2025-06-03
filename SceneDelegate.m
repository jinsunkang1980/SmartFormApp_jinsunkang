//
//  SceneDelegate.m

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // VMware-friendly navigation setup
    nav.navigationBar.prefersLargeTitles = NO; // Disable for performance
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    NSLog(@"📱 Scene connected successfully on VMware");
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"🔌 Scene disconnected");
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"🟢 Scene became active");
}

- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"🟡 Scene will resign active");
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"🔵 Scene entering foreground");
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"⚫ Scene entered background");
}

@end
