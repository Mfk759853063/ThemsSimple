//
//  KNThemManager.h
//  KNThemSimple
//
//  Created by vbn on 16/3/18.
//  Copyright © 2016年 iClip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"

extern NSString *kThemeChangedNotification;

#define THEMCOLOR(name)  [[KNThemManager shareInstance] themsColorWithName:name]
#define THEMIMAGE(name)  [[KNThemManager shareInstance] imageWithName:name]

@interface KNThemManager : NSObject

@property (strong, nonatomic) NSString *themName;

+ (instancetype)shareInstance;

- (UIImage *)imageWithName:(NSString *)imageName;

- (UIColor *)themsColorWithName:(NSString *)name;

@end
