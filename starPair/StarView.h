//
//  StarView.h
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
@property (nonatomic,copy)void (^selectStarBlock)(NSString *name);
@end
