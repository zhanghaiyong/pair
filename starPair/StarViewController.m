//
//  StarViewController.m
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#define kSTarURl @"http://api.avatardata.cn/XingZuoPeiDui/Lookup"
#define kStarKey @"21ec61e4363f433589a8654add76bf7d"

#import "StarViewController.h"
#import <SVProgressHUD.h>
#import "KSMNetworkRequest.h"
#import "StarView.h"
#import "UIViewExt.h"
#import "Defaults.h"
#import "StarModel.h"
#import <MJExtension/MJExtension.h>
#import "StarDetailViewController.h"
@interface StarViewController (){
    NSString *MainStar;
    NSString *deputyStar;
    StarModel *model;
}
@property (weak, nonatomic) IBOutlet UIImageView *mainImg;
@property (weak, nonatomic) IBOutlet UIImageView *deputyImg;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet UIButton *deputyBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIButton *beginPDBtn;

@property (nonatomic,strong)StarView *starView;

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityView.hidden = YES;
}

- (IBAction)choseImgAction:(UIButton *)sender {
    
    __weak StarViewController *weakSelf = self;
    if (!self.starView) {
        
        if (sender == self.mainBtn) {
            self.starView = [[StarView alloc]initWithFrame:CGRectMake(-kDeviceWidth, self.mainBtn.frame.origin.y+self.mainBtn.height, kDeviceWidth-40, (kDeviceWidth-40)/3*4+10)];
            self.starView.selectStarBlock = ^(NSString *name) {
                weakSelf.mainImg.image = [UIImage imageNamed:name];
                MainStar = name;
                [weakSelf.starView removeFromSuperview];
                weakSelf.starView = nil;
            };
            [self.view addSubview:self.starView];
        }else {
            self.starView = [[StarView alloc]initWithFrame:CGRectMake(kDeviceWidth, self.mainBtn.frame.origin.y+self.mainBtn.height, kDeviceWidth-40, (kDeviceWidth-40)/3*4+10)];
            self.starView.selectStarBlock = ^(NSString *name) {
                weakSelf.deputyImg.image = [UIImage imageNamed:name];
                deputyStar = name;
                [weakSelf.starView removeFromSuperview];
                weakSelf.starView = nil;
            };
            [self.view addSubview:self.starView];
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            self.starView.frame = CGRectMake(kDeviceWidth/2 - (kDeviceWidth-40)/2, self.mainBtn.frame.origin.y+self.mainBtn.height, kDeviceWidth-40, (kDeviceWidth-40)/3*4);
        }];
    }else {
        [self.starView removeFromSuperview];
        self.starView = nil;
    }
}

- (IBAction)beginAction:(UIButton *)sender {
    
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    if (!MainStar) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        [SVProgressHUD showInfoWithStatus:@"请选择主星座"];
        return;
    }
    
    if (!deputyStar) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        [SVProgressHUD showInfoWithStatus:@"请选择副星座"];
        return;
    }
    
    [self.beginPDBtn setTitle:@"配对中..." forState:UIControlStateNormal];
    
    NSDictionary *params = @{@"key":kStarKey,@"xingzuo1":[MainStar stringByAppendingString:@"座"],@"xingzuo2":[deputyStar stringByAppendingString:@"座"],@"dtype":@"JSON",@"format":@"0"};
    [KSMNetworkRequest postRequest:kSTarURl params:params success:^(id responseObj) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        NSLog(@"%@",responseObj);
        [SVProgressHUD showSuccessWithStatus:@"配对成功"];
        if ([responseObj[@"error_code"] integerValue] == 0) {
            [sender setTitle:@"开始配对" forState:UIControlStateNormal];
            model = [StarModel mj_objectWithKeyValues:responseObj[@"result"]];
            
            StarDetailViewController *detail = [StarDetailViewController new];
            detail.model = model;
            [self presentViewController:detail animated:YES completion:nil];
            
        }else {
            [SVProgressHUD showErrorWithStatus:@"配对失败，请检查网络"];
        }
        
    } failure:^(NSError *error) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        [SVProgressHUD showErrorWithStatus:@"配对失败，请检查网络"];
        [sender setTitle:@"开始配对" forState:UIControlStateNormal];
    }];
    
}

@end
