//
//  CellZoomCenterCell.m
//  CollectionViewCenterzoomDemo
//
//  Created by XieHenry on 2020/3/23.
//  Copyright © 2020 XieHenry. All rights reserved.
//

#import "CellZoomCenterCell.h"

@implementation CellZoomCenterCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self initUI];
    }
    return self;
}

-(void)initUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.titleLabel];
}

@end
