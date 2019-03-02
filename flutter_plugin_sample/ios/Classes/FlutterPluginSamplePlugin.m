#import "FlutterPluginSamplePlugin.h"

@implementation FlutterPluginSamplePlugin {
    FlutterMethodChannel* _customChannel;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin_sample"
            binaryMessenger:[registrar messenger]];
  FlutterPluginSamplePlugin* instance = [[FlutterPluginSamplePlugin alloc] initWithRegistrar:registrar];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype) init {
    return nil;
}
- (instancetype)initWithRegistrar: (NSObject<FlutterPluginRegistrar>*)registrar {
    if(self = [super init]) {
        _customChannel = [FlutterMethodChannel methodChannelWithName:@"flutter_plugin_sample_custom_channel" binaryMessenger: [registrar messenger]];
        [registrar addMethodCallDelegate:self channel:_customChannel];
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSLog(@"call is %@", call.method);
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"helloWorld" isEqualToString:call.method]) {
    result(@"Hello World From iOS");
  }else {
      result(FlutterMethodNotImplemented);
  }
}

@end
