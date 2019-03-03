//
//  TextView.m
//  Runner
//
//  Created by Karthick C on 03/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "TextView.h"
@interface TextView()//<FlutterPlugin>

@end
@implementation TextView {
    FlutterMethodChannel *_channel;
    //UITextView *_textView;
    UILabel * _textView;
}

//+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
//    //I don't have anything
//}


- (instancetype)init {
    return nil;
}

-(instancetype)initWithFrame: (CGRect) frame messenger: (NSObject<FlutterBinaryMessenger>*) messenger uniqueID:(NSString *) uniqueID{
    if(self = [super init]) {
        
        //self->_textView = [[UITextView alloc] initWithFrame:frame];
        self->_textView = [[UILabel alloc] initWithFrame:frame];
        
        self->_channel = [FlutterMethodChannel methodChannelWithName:uniqueID binaryMessenger: messenger];
        
        //[registrar addMethodCallDelegate:self channel:self->_channel];
        
        __weak typeof(self) weakSelf = self;
        [self->_channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            handleMethodCall(weakSelf, call, result);
        }];
    }
    return self;
}

- (nonnull UIView *)view {
    return _textView;
}

//typedef void (^FlutterMethodCallHandler)(FlutterMethodCall* call, FlutterResult result);
static void handleMethodCall(TextView *textView, FlutterMethodCall *call, FlutterResult result) {
    if(textView == nil) {
        result([FlutterError errorWithCode:@"DOES_NOT_EXIST" message:@"TextView doesn't exist!" details:nil]);
        return;
    }
    if ([@"setText" isEqualToString:call.method]) {
        NSString *text = call.arguments;
        [textView->_textView setText:text];
        return;
    }
    result(FlutterMethodNotImplemented);
}

@end
