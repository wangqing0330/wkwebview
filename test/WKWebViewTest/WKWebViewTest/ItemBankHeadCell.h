//
//  ItemBankHeadCell.h
//  Project
//
//  Created by zs on 2020/2/23.
//  Copyright © 2020年 zs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemBankHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UIView *itemDescriptionView;
@property (weak, nonatomic) IBOutlet UILabel *itemdescriptionLabel;


@property (weak, nonatomic) IBOutlet UIView *itemLowPriceView;
@property (weak, nonatomic) IBOutlet UILabel *costPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *favorablePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalSellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *limitTimeImageView;
@property (weak, nonatomic) IBOutlet UILabel *reducePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *reducePriceView;


- (void)setCostPriceView:(BOOL)hide ;
@property (nonatomic,strong) NSArray *tagArray;


@end

NS_ASSUME_NONNULL_END
