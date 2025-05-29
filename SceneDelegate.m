#import "SceneDelegate.h"
#import "ViewController.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

    if (![scene isKindOfClass:[UIWindowScene class]]) { return; }

    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

    ViewController *rootVC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];

    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"Scene disconnected");
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"Scene became active");
}

- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"Scene will resign active");
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"Scene will enter foreground");
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"Scene entered background");
}

@end
