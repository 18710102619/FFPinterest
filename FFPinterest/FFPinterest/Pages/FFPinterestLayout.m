//
//  FFPinterestLayout.m
//  FFPinterest
//
//  Created by 张玲玉 on 16/7/16.
//  Copyright © 2016年 张玲玉. All rights reserved.
//

#import "FFPinterestLayout.h"

@interface FFPinterestLayout ()

@property(nonatomic,strong)NSMutableDictionary *maxY;
@property(nonatomic,strong)NSMutableArray *itemArray;
@property(nonatomic,assign)CGFloat itemWidth;
@end

@implementation FFPinterestLayout

- (NSMutableDictionary *)maxY
{
    if (_maxY==nil) {
        _maxY=[NSMutableDictionary dictionary];
        for (int i=0; i<_colCount; i++) {
            [_maxY setObject:[NSString stringWithFormat:@"%f",self.sectionInset.top] forKey:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _maxY;
}

- (NSMutableArray *)itemArray
{
    if (_itemArray==nil) {
        _itemArray=[[NSMutableArray alloc]init];
    }
    return _itemArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        self.rowMargin=3;
        self.colMargin=3;
        self.colCount=3;
    }
    return self;
}

/**
 *  每次布局之前的准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.maxY=nil;
    
    [self.itemArray removeAllObjects];
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        [self.itemArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxY enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxY[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    CGFloat height=[self.maxY[maxColumn] floatValue] + self.sectionInset.bottom;
    
    return CGSizeMake(0, height);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  返回rect范围内的布局属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemArray;
}

/**
 *  返回indexPath这个位置Item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 默认第一列最短
    __block NSString *minCol=@"0";
    
    // 找出最短的一列
    [self.maxY enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj floatValue] < [self.maxY[minCol] floatValue]) {
            minCol=key;
        }
    }];
    
    // 计算宽度
    CGFloat width=(self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-(self.colCount-1)*self.colMargin)/self.colCount;
    
    // 计算高度
    CGFloat height=[self.delegate pinterestLayout:self heightForWidth:width atIndexPath:indexPath];
    
    // 计算位置
    CGFloat x=self.sectionInset.left+(width+self.colMargin)*[minCol intValue];
    CGFloat y=0;
    if (indexPath.item>2) {
        y=[self.maxY[minCol] floatValue]+self.rowMargin;
    }
 
    // 更新Y值
    self.maxY[minCol]=@(y+height);
    
    //创建属性
    UICollectionViewLayoutAttributes *item=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    item.frame=CGRectMake(x, y, width, height);
    
    return item;
}

@end
