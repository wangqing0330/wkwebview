//
//  TimeCountView.m
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import "TimeCountView.h"
#import "Util.h"


@interface TimeCountView()

@property (nonatomic,strong)UILabel *dayLabel;
@property (nonatomic,strong)UILabel *hoursLabel;
@property (nonatomic,strong)UILabel *minuteLabel;
@property (nonatomic,strong)UILabel *secondLabel;

@property (nonatomic,strong)UILabel *spaceLabel1;
@property (nonatomic,strong)UILabel *spaceLabel2;
@property (nonatomic,strong)UILabel *spaceLabel3;

@end

@implementation TimeCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dayLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        _dayLabel.font = kFont_Medium(9);
        _dayLabel.backgroundColor  = [Util colorWithHexString:@"ffffff"];
        _dayLabel.textColor  = [Util colorWithHexString:@"#D90008"];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.layer.cornerRadius = 7.5;
        _dayLabel.layer.masksToBounds = YES;
        [self addSubview:_dayLabel];
        
        _spaceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_dayLabel.frame.origin.x+_dayLabel.frame.size.width, 0, 8, 15)];
        _spaceLabel1.font = kFont_Medium(9);
        _spaceLabel1.textColor  = [Util colorWithHexString:@"ffffff"];
        _spaceLabel1.textAlignment = NSTextAlignmentCenter;
        _spaceLabel1.text = @":";
        [self addSubview:_spaceLabel1];
        
        _hoursLabel  = [[UILabel alloc]initWithFrame:CGRectMake(23, 0, 15, 15)];
        _hoursLabel.font = kFont_Medium(9);
        _hoursLabel.backgroundColor  = [Util colorWithHexString:@"ffffff"];
        _hoursLabel.textAlignment = NSTextAlignmentCenter;
        _hoursLabel.textColor  = [Util colorWithHexString:@"#D90008"];
        _hoursLabel.layer.cornerRadius = 7.5;
        _hoursLabel.layer.masksToBounds = YES;
        [self addSubview:_hoursLabel];
        
        _spaceLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(_hoursLabel.frame.origin.x+_hoursLabel.frame.size.width, 0, 8, 15)];
        _spaceLabel2.font = kFont_Medium(9);
        _spaceLabel2.textColor  = [Util colorWithHexString:@"ffffff"];
        _spaceLabel2.textAlignment = NSTextAlignmentCenter;
        _spaceLabel2.text = @":";
        [self addSubview:_spaceLabel2];
        
        _minuteLabel  = [[UILabel alloc]initWithFrame:CGRectMake(_spaceLabel2.frame.origin.x+_spaceLabel2.frame.size.width, 0, 15, 15)];
        _minuteLabel.font = kFont_Medium(9);
        _minuteLabel.backgroundColor  = [Util colorWithHexString:@"ffffff"];
        _minuteLabel.textAlignment = NSTextAlignmentCenter;
        _minuteLabel.textColor  = [Util colorWithHexString:@"#D90008"];
        _minuteLabel.layer.cornerRadius = 7.5;
        _minuteLabel.layer.masksToBounds = YES;
        [self addSubview:_minuteLabel];
        
        _spaceLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(_minuteLabel.frame.origin.x+_minuteLabel.frame.size.width, 0, 8, 15)];
       _spaceLabel3.font = kFont_Medium(9);
       _spaceLabel3.textColor  = [Util colorWithHexString:@"ffffff"];
       _spaceLabel3.textAlignment = NSTextAlignmentCenter;
       _spaceLabel3.text = @":";
       [self addSubview:_spaceLabel3];
        
        
        _secondLabel  = [[UILabel alloc]initWithFrame:CGRectMake(_spaceLabel3.frame.origin.x+_spaceLabel3.frame.size.width, 0, 15, 15)];
        _secondLabel.font = kFont_Medium(9);
        _secondLabel.backgroundColor  = [Util colorWithHexString:@"ffffff"];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.textColor  = [Util colorWithHexString:@"#D90008"];
        _secondLabel.layer.cornerRadius = 7.5;
        _secondLabel.layer.masksToBounds = YES;
        [self addSubview:_secondLabel];
    }
    return self;
}

- (void)setStatus:(BOOL)status withDay:(int)day withHours:(int)hours withMinute:(int)minute withSecond:(int)second
{
    if (status) {
        if (day == 0) {
            _dayLabel.hidden = YES;
            _spaceLabel1.hidden = YES;
        _hoursLabel.text  = [NSString stringWithFormat:@"%02d",hours];
              _minuteLabel.text  = [NSString stringWithFormat:@"%02d",minute];
              _secondLabel.text  = [NSString stringWithFormat:@"%02d",second];
        }else{
            _dayLabel.hidden = NO;
            _spaceLabel1.hidden = NO;
            _dayLabel.text = [NSString stringWithFormat:@"%02d",day];
            _hoursLabel.text  = [NSString stringWithFormat:@"%02d",hours];
                  _minuteLabel.text  = [NSString stringWithFormat:@"%02d",minute];
                  _secondLabel.text  = [NSString stringWithFormat:@"%02d",second];
        }

    }else{
        //结束了
        _spaceLabel1.hidden = YES;
        _spaceLabel2.hidden = YES;
        _spaceLabel3.hidden = YES;
        _secondLabel.hidden = YES;
        _minuteLabel.hidden = YES;
        _hoursLabel.hidden = YES;
        _dayLabel.hidden = NO;
        
        _dayLabel.text = @"当前活动已结束";
        _dayLabel.frame  = self.bounds;
        _dayLabel.backgroundColor  = [UIColor clearColor];
    }
}

@end
