//
//  ItemBankHeadCell.m
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import "ItemBankHeadCell.h"
#import "TagLabel.h"
#import "TimeCountView.h"
#import "TimeHelper.h"
#import "Util.h"

@implementation ItemBankHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.itemImageView.image=[UIImage imageNamed:@"detail_bg"];
    
    NSString * content = @"                      高级卫生专业技术资格认证（副高)题库高级卫生专业技术资格认证（副高）题库";
    NSMutableAttributedString *attributedString  =[[NSMutableAttributedString alloc]initWithString:content];
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
       paragraph.lineSpacing = 3;
       
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, attributedString.length)];

    [attributedString addAttribute:NSForegroundColorAttributeName value:[Util colorWithHexString:@"333333"] range:[[attributedString string] rangeOfString:content]];

      [attributedString addAttribute:NSFontAttributeName value:kFont_Regular(15) range:NSMakeRange(0, attributedString.length)];
      self.itemdescriptionLabel.attributedText = attributedString;
    
    NSArray *arr =  @[[Util colorWithHexString:@"#F1673C"],[Util colorWithHexString:@"#EE3742"]];
    CGRect frame  = self.itemLowPriceView.frame;
    frame.size.height = 58;
    frame.size.width = kScreenWidth;
    self.itemLowPriceView.frame = frame;
    UIImage *barImg = [Util gradientImageWithColors:arr rect:self.itemLowPriceView.frame];
    UIColor *color=[UIColor colorWithPatternImage:barImg];
    self.itemLowPriceView.backgroundColor = color;
    
    
    // 倒计时的时间 测试数据
   NSString *deadlineStr = @"2020-03-25 13:51:00";
   TimeCountView *timeCountView = [[TimeCountView alloc]initWithFrame:CGRectMake(0, 0, 90, 15)];
   [self.countLabel addSubview:timeCountView];
   
    NSString *nowStr = [[TimeHelper share] getCurrentTimeyyyymmdd];
    NSInteger secondsCountDown = [[TimeHelper share]getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
   [[TimeHelper share]getCountDownTime:secondsCountDown callback:^(BOOL status, int days, int hours, int minute, int second) {
       dispatch_async(dispatch_get_main_queue(), ^{
               [timeCountView setStatus:status withDay:days withHours:hours withMinute:minute withSecond:second];
           });
   }];
    
}

- (void)setCostPriceView:(BOOL)hide
{
    _costPriceLabel.hidden = hide;
    _totalSellLabel.hidden = hide;
    _limitTimeImageView.hidden = hide;
    _countLabel.hidden = hide;
    _reducePriceView.hidden = hide;
    
    if (!hide) {
        _favorablePriceLabel.text  = @"88";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTagArray:(NSArray *)tagArray
{
    for (int i=0; i<tagArray.count; i++) {
        TagLabel *tLabel  = [[TagLabel alloc]initWithFrame:CGRectMake(15 + (48+5)*i, 18, 48, 19)];
        tLabel.tagString = [tagArray objectAtIndex:i];
        [self.itemDescriptionView addSubview:tLabel];
    }
}

@end
