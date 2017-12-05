//
//  StarView.m
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#import "StarView.h"
#import "StarCell.h"
#import "UIViewExt.h"
@interface StarView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *collectionV;
    NSArray *starArr;
}
@end

@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        starArr = [NSArray arrayWithObjects:@"白羊",@"金牛",@"双子",@"巨蟹",@"狮子",@"处女",@"天秤",@"天蝎",@"射手",@"摩羯",@"水瓶",@"双鱼", nil];
        
        [self setUp];
    }
    return self;
}

- (void)setUp {

    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake((self.width-40)/3, (self.width-40)/3);
    flow.minimumLineSpacing = 10;
    flow.minimumInteritemSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    collectionV = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flow];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.backgroundColor = [UIColor clearColor];
    [collectionV registerNib:[UINib nibWithNibName:[StarCell.class description] bundle:nil] forCellWithReuseIdentifier:@"reuser"];
    [self addSubview:collectionV];
    
}

//刷新frame
- (void)layoutSubviews {
    [super layoutSubviews];
    collectionV.frame = self.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return starArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuser" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.img.image = [UIImage imageNamed:starArr[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectStarBlock) {
        _selectStarBlock(starArr[indexPath.item]);
    }
}

@end
