//
//  ViewController.m
//  FFPinterest
//
//  Created by 张玲玉 on 16/7/16.
//  Copyright © 2016年 张玲玉. All rights reserved.
//

#import "ViewController.h"
#import "FFPinterestLayout.h"
#import "FFShopCell.h"
#import "FFShopModel.h"

static NSString *const ID=@"shop";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *shops;

@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (_shops==nil) {
        self.shops=[NSMutableArray array];
        [self.shops addObjectsFromArray:[NSArray arrayWithContentsOfFile:@"1.plist"]];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[FFPinterestLayout alloc]init]];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [_collectionView registerNib:[UINib nibWithNibName:@"FFShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:_collectionView];
    
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

@end
