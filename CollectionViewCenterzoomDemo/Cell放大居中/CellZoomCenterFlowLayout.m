//
//  CellZoomCenterFlowLayout.m
//  CollectionViewCenterzoomDemo
//
//  Created by XieHenry on 2020/3/23.
//  Copyright © 2020 XieHenry. All rights reserved.
//

#import "CellZoomCenterFlowLayout.h"
#define CellWidth 300  //卡片的宽度

@implementation CellZoomCenterFlowLayout


- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*CellWidth;
    bigRect.origin.x = rect.origin.x - CellWidth;

    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

//设置左右缩进
- (CGFloat)collectionInset {
    return (self.collectionView.bounds.size.width - CellWidth)/2.0f;
}

//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

//collectionView停止滚动时最终的偏移量（contentOffset）
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {

    // 计算出最终显示的矩形框
    CGRect visableRect = CGRectMake(proposedContentOffset.x, 0,self.collectionView.bounds.size.width , self.collectionView.bounds.size.height);

    // 获得super已经计算好的布局属性
    NSArray *attrArr = [super layoutAttributesForElementsInRect:visableRect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrArr) {
        CGFloat delta = fabs(attr.center.x - centerX);
        if (delta < fabs(minDelta)) {
            minDelta = attr.center.x - centerX;
        }
    }

    proposedContentOffset.x += minDelta;
    if (proposedContentOffset.x <= 0) {
        proposedContentOffset.x = 0;
    }

    return proposedContentOffset;
}


@end
