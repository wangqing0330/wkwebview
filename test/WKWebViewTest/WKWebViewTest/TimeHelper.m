//
//  TimeHelper.m
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import "TimeHelper.h"
#import "Util.h"

@interface TimeHelper()

@property (nonatomic,strong) dispatch_source_t timer;

@end

@implementation TimeHelper

+ (instancetype)share {
    static TimeHelper *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared =  [[self alloc] init] ;
    }) ;
    return _shared ;
}


/**
 *  获取当天的字符串
 *
 *  @return 格式为年-月-日 时分秒
 */
- (NSString *)getCurrentTimeyyyymmdd {

    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];

    return dayStr;
}

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    NSInteger timeDifference = 0;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;

    return timeDifference;
}

- (void)getCountDownTime:(NSInteger)secondsCountDown callback:(void(^)(BOOL status,int days,int hours,int minute,int second)) callback
{
        if (_timer == nil) {
            __block NSInteger timeout = secondsCountDown; // 倒计时时间

            if (timeout!=0) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                        dispatch_source_cancel(_timer);
                        _timer = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (callback) {
                                callback(NO,0,0,0,0);
                            }
                        });
                    } else { // 倒计时重新计算 时/分/秒
                        NSInteger days = (int)(timeout/(3600*24));
                        NSInteger hours = (int)((timeout-days*24*3600)/3600);
                        NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                        NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                        if (callback) {
                            callback(YES,days,hours,minute,second);
                        }
                        timeout--; // 递减 倒计时-1(  总时间以秒来计算)
                    }
                });
                dispatch_resume(_timer);
            }
        }
}

-(void) pauseTimer{
    if(self.timer){
        dispatch_suspend(_timer);
    }
}
-(void) resumeTimer{
    if(self.timer){
        dispatch_resume(_timer);
    }
}
-(void) stopTimer{
    if(self.timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}



@end
