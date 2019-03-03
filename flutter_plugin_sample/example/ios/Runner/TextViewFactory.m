//
//  TextViewFactor.m
//  Runner
//
//  Created by Karthick C on 03/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "TextViewFactory.h"
#import "TextView.h"
static NSString * const GROUP_NAME = @"Runner/PlatoformView/Text";
static NSString * const VIEW_TYPE = @"in.flutter.karthick/textview";

@implementation TextViewFactory {
    NSObject<FlutterBinaryMessenger> *_messenger;
}


//Called Only ONCE in App's lifetime. So no need to check if the registry already has plugin
+(void) registerWithRegistry: (NSObject<FlutterPluginRegistry>*) registry {
    NSLog(@"TextViewFactory: %s", __PRETTY_FUNCTION__);
    NSObject<FlutterPluginRegistrar> *registrar = [registry registrarForPlugin:GROUP_NAME];
    [registrar registerViewFactory:[[TextViewFactory alloc]initWithMessenger:[registrar messenger]] withId:VIEW_TYPE];
}

-(instancetype) init {
    return nil;
}

-(instancetype) initWithMessenger: (NSObject<FlutterBinaryMessenger> *) messenger {
    if(self = [super init]) {
        _messenger = messenger;
    }
    return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    NSLog(@"TextViewFactory#create: %s", __PRETTY_FUNCTION__);
    return [[TextView alloc] initWithFrame:frame messenger:_messenger uniqueID:[NSString stringWithFormat:@"%@_%lld", VIEW_TYPE, viewId]];
}
@end
