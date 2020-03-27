//
//  CellZoomCenterViewController.m
//  CollectionViewCenterzoomDemo
//
//  Created by XieHenry on 2020/3/26.
//  Copyright © 2020 XieHenry. All rights reserved.
//

#import "CellZoomCenterViewController.h"
#import "CellZoomCenterFlowLayout.h"
#import "CellZoomCenterCell.h"

#define CellWidth 300  //卡片宽度
@interface CellZoomCenterViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CellZoomCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CellZoomCenterFlowLayout *layout = [[CellZoomCenterFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400) collectionViewLayout:layout];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blueColor];
        _collectionView.pagingEnabled = NO;
        [_collectionView registerClass:[CellZoomCenterCell class] forCellWithReuseIdentifier:@"CellZoomCenterCell"];
    }
    
    return _collectionView;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(CellWidth, 280);;
    return cellSize;
}

//定义每个UICollectionView 的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


//定义每个UICollectionView 的横向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 50;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}


//设置左右缩进
- (CGFloat)collectionInset {
    return (self.collectionView.frame.size.width - CellWidth)/2.0f;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellZoomCenterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellZoomCenterCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}
 


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(BOOL)shouldAutorotate {
    return NO;
}

@end
