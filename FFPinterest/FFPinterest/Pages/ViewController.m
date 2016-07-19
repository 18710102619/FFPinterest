//
//  ViewController.m
//  FFPinterest
//
//  Created by 张玲玉 on 16/7/16.
//  Copyright © 2016年 张玲玉. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "FFPinterestLayout.h"
#import "FFShopCell.h"
#import "FFShopModel.h"

static NSString *const ID=@"shop";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,FFPinterestLayoutDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *shops;

@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (_shops==nil) {
        _shops=[[NSMutableArray alloc]initWithArray:[FFShopModel objectArrayWithFilename:@"1.plist"]];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    
    FFPinterestLayout *layout=[[FFPinterestLayout alloc]init];
    layout.delegate=self;
    
    CGSize size=self.view.frame.size;
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 22, size.width, size.height-22) collectionViewLayout:layout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [_collectionView registerNib:[UINib nibWithNibName:@"FFShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:_collectionView];
    
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreShops)];
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shopArray = [FFShopModel objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shopArray];
        [self.collectionView reloadData];
        [self.collectionView footerEndRefreshing];
    });
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FFShopCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shopModel=self.shops[indexPath.row];
    return cell;
}

#pragma mark - FFPinterestLayoutDelegate

- (CGFloat)pinterestLayout:(FFPinterestLayout *)pinterestLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    FFShopModel *shopModel=self.shops[indexPath.row];
    CGFloat height=shopModel.h/shopModel.w*width;
    return height;
}

@end
