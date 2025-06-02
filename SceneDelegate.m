//
//  SceneDelegate.m
//  SmartFormApp
//
//  Created on Assignment
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    NSLog(@"SceneDelegate: Scene will connect to session");
    
    // Configure the window
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    // Create the root view controller
    ViewController *rootViewController = [[ViewController alloc] init];
    
    // Embed in navigation controller as required
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    // Set navigation controller as root
    self.window.rootViewController = navigationController;
    
    // Make window key and visible
    [self.window makeKeyAndVisible];
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    NSLog(@"SceneDelegate: Scene did disconnect");
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"SceneDelegate: Scene did become active");
}

- (void)sceneWillResignActive:(UIScene *)scene {
    NSLog(@"SceneDelegate: Scene will resign active");
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    NSLog(@"SceneDelegate: Scene will enter foreground");
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"SceneDelegate: Scene did enter background");
}

@end
