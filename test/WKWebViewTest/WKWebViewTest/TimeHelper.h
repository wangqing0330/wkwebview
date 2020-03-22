//
//  TimeHelper.h
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//  倒计时类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeHelper : NSObject

+ (instancetype)share;

- (NSString *)getCurrentTimeyyyymmdd;

- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr ;

- (void)getCountDownTime:(NSInteger)secondsCountDown callback:(void(^)(BOOL status,int days,int hours,int minute,int second)) callback ;

-(void) pauseTimer;

-(void) resumeTimer;

-(void) stopTimer;

@end

NS_ASSUME_NONNULL_END
