//
//  KNThemManager.m
//  KNThemSimple
//
//  Created by vbn on 16/3/18.
//  Copyright © 2016年 iClip. All rights reserved.
//

#import "KNThemManager.h"

#define kThemeChangedNotification @"themChangedNotification"

@interface KNThemManager()

@end


@implementation KNThemManager

+ (instancetype)shareInstance {
    static KNThemManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (UIColor *)themsColorWithName:(NSString *)name {
    NSString *colorPath = [[self themPath] stringByAppendingPathComponent:@"ThemsColor.plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:colorPath];
    NSString *colorString = [plist valueForKey:name];
    if (!colorString) {
        colorPath = [[self commonPath] stringByAppendingPathComponent:@"ThemsColor.plist"];
        plist = [NSDictionary dictionaryWithContentsOfFile:colorPath];
        colorString = [plist valueForKey:name];
    }
    if (colorString) {
        NSArray *colors = [colorString componentsSeparatedByString:@","];
        if (colors.count == 3) {
            UIColor *color = [UIColor colorWithRed:[colors[0] floatValue]/255.0f green:[colors[1] floatValue]/255.0f blue:[colors[2] floatValue]/255.0f alpha:1.0f];
            return color;
        }
    }
    return nil;
}

- (UIImage *)imageWithName:(NSString *)imageName {
    if (imageName == nil || [[imageName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return nil;
    }
    NSString *path = [self themPath];
    path = [path stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (!image) {
        path = [self commonPath];
        path = [path stringByAppendingPathComponent:imageName];
        image = [UIImage imageWithContentsOfFile:path];
    }
    return image;
}

- (NSString *)themPath {
    NSString *themPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",@"Skins",self.themName]];
    return themPath;
}

- (NSString *)commonPath {
    NSString *themPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",@"Skins",@"Common"]];
    return themPath;
}

- (void)setThemName:(NSString *)themName {
    if (_themName) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedNotification object:self];
    }
    _themName = themName;
}

@end
