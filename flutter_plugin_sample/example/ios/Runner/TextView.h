//
//  TextView.h
//  Runner
//
//  Created by Karthick C on 03/03/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextView : NSObject<FlutterPlatformView>
-(instancetype)initWithFrame: (CGRect) rect messenger: (NSObject<FlutterBinaryMessenger>*) messenger uniqueID:(NSString *) uniqueID;
@end

NS_ASSUME_NONNULL_END
