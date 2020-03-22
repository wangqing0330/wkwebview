//
//  TagLabel.m
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import "TagLabel.h"
#import "Util.h"


@implementation TagLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        tags = [[UILabel alloc]initWithFrame:self.bounds];
        tags.layer.cornerRadius= 3;
        tags.layer.masksToBounds = YES;
        tags.layer.borderColor  = [Util colorWithHexString: @"#14C5AA"].CGColor;
        tags.layer.borderWidth = 0.2;
        tags.font = kFont_Regular(9);
        tags.textColor =  [Util colorWithHexString: @"#14C5AA"];
        tags.textAlignment = NSTextAlignmentCenter;
        [self addSubview:tags];
        
    }
    return self;
}

- (void)setTagString:(NSString *)tagString
{
    tags.text = tagString;
}

@end
