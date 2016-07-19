//
//  FFPinterestLayout.h
//  FFPinterest
//
//  Created by 张玲玉 on 16/7/16.
//  Copyright © 2016年 张玲玉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFPinterestLayout;

@protocol FFPinterestLayoutDelegate <NSObject>

- (CGFloat)pinterestLayout:(FFPinterestLayout *)pinterestLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface FFPinterestLayout : UICollectionViewLayout

@property(nonatomic,weak)id<FFPinterestLayoutDelegate> delegate;
@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGFloat rowMargin;
@property(nonatomic,assign)CGFloat colMargin;
@property(nonatomic,assign)int colCount;

@end
