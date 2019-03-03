#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "TextViewFactory.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [TextViewFactory registerWithRegistry:self];
  // Override point for customization after application launch.
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
