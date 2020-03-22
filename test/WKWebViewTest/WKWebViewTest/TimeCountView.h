//
//  TimeCountView.h
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeCountView : UIView

- (void)setStatus:(BOOL)status withDay:(int)day withHours:(int)hours withMinute:(int)minute withSecond:(int)second;

@end

NS_ASSUME_NONNULL_END
