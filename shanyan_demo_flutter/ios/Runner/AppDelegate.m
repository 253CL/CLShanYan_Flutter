#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "ShanYanManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [ShanYanManager registerWithRegistry:self];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
