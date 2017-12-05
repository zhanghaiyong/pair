//
//  PairView.h
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PairView : UIView
@property (nonatomic,copy)void (^selectPairBlock)(NSString *pair);
@end
