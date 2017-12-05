//
//  PairView.m
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#import "PairView.h"
@interface PairView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    NSArray *pairNameArr;
    NSArray *pairImgArr;
}
@end
@implementation PairView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        pairNameArr = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪", nil];
        pairImgArr = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎肖",@"兔子",@"龙肖",@"蛇肖",@"马肖",@"羊肖",@"猴肖",@"鸡",@"狗",@"猪", nil];
        
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    tableView.frame = self.bounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pairNameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuser = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser];
    }
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.imageView.image = [UIImage imageNamed:pairImgArr[indexPath.row]];
    cell.textLabel.text = pairNameArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectPairBlock) {
        _selectPairBlock(pairNameArr[indexPath.row]);
    }
}


@end
