//
//  Util.h
//  WKWebViewTest
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//苹方-简 中黑体
#define kFont_Medium(font)  [UIFont fontWithName:@"PingFangSC-Medium" size:font]
//苹方-简 常规体
#define kFont_Regular(font) [UIFont fontWithName:@"PingFangSC-Regular" size:font]
//苹方-简 中粗体
#define kFont_Bold(font) [UIFont fontWithName:@"PingFangSC-Semibold" size:font]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (UIColor *)colorWithHexString: (NSString *)color;

+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect ;

@end

NS_ASSUME_NONNULL_END
