//
//  TagLabel.h
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagLabel : UIView
{
    UILabel *tags;
}

@property (nonatomic,strong) NSString *tagString;

@end

NS_ASSUME_NONNULL_END
