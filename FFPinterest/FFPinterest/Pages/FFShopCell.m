//
//  FFShopCell.m
//  FFPinterest
//
//  Created by 张玲玉 on 16/7/16.
//  Copyright © 2016年 张玲玉. All rights reserved.
//

#import "FFShopCell.h"
#import "UIImageView+WebCache.h"

@interface FFShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation FFShopCell

- (void)setShopModel:(FFShopModel *)shopModel
{
    _shopModel=shopModel;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shopModel.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.priceLabel.text = shopModel.price;
}

@end
