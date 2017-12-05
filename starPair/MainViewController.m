//
//  MainViewController.m
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#import "MainViewController.h"
#import "AnimalsViewController.h"
#import "StarViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AnimalsViewController *animals = [[AnimalsViewController alloc]init];
    animals.title = @"PAIR";
    animals.tabBarItem.selectedImage = [UIImage imageNamed:@"底部-竞猜-选择后"];
    animals.tabBarItem.image = [UIImage imageNamed:@"底部-竞猜"];
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:animals];
   
    StarViewController *star = [[StarViewController alloc]init];
    star.title = @"STAR";
    star.tabBarItem.selectedImage = [UIImage imageNamed:@"底部-约呗-选择后"];
    star.tabBarItem.image = [UIImage imageNamed:@"底部-约呗"];
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:star];
 
    self.viewControllers = @[navi1,navi2];
    
}




@end
