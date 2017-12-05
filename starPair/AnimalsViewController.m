//
//  AnimalsViewController.m
//  starPair
//
//  Created by edianzu on 2017/12/4.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//
#define kURL @"http://api.avatardata.cn/ShengXiaoPeiDui/Lookup"
#define kKEY @"320868cbc4a140f5a208a77ab42a9d7d"

#import "AnimalsViewController.h"
#import "PairView.h"
#import "UIViewExt.h"
#import "KSMNetworkRequest.h"
#import <SVProgressHUD.h>
#import "PairModel.h"
#import <MJExtension/MJExtension.h>
#import <Social/Social.h>
@interface AnimalsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    PairModel *model;
}
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet UIButton *deputyBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic,strong)PairView *pairView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@end

@implementation AnimalsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityView.hidden = YES;
    self.tableV.tableFooterView = [UIView new];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
}

- (IBAction)chosePairAction:(UIButton *)sender {
    
    __weak AnimalsViewController *weakSelf = self;
    if (!self.pairView) {
        self.pairView = [[PairView alloc]initWithFrame:CGRectZero];
        
        self.pairView.selectPairBlock = ^(NSString *pair) {
            
            if (sender == self.mainBtn) {
                [weakSelf.mainBtn setTitle:pair forState:UIControlStateNormal];
            }else {
                [weakSelf.deputyBtn setTitle:pair forState:UIControlStateNormal];
            }
            [weakSelf.pairView removeFromSuperview];
            weakSelf.pairView = nil;
        };
        
        [self.view addSubview:self.pairView];
        CGRect viewFrame;
        if (sender == self.mainBtn) {
            
           viewFrame = CGRectMake(self.mainBtn.frame.origin.x, self.mainBtn.frame.origin.y+self.mainBtn.height, self.mainBtn.width, 12*30);
        }else {
           viewFrame = CGRectMake(self.deputyBtn.frame.origin.x, self.deputyBtn.frame.origin.y+self.deputyBtn.height, self.deputyBtn.width, 12*30);
        }
        self.pairView.frame = viewFrame;
    }else {
        [self.pairView removeFromSuperview];
        self.pairView = nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return model == nil ? 0 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuser = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuser];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuser];
    }
    
    if (model) {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0) {
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = model.title;
        }else if (indexPath.row == 1) {
            cell.textLabel.text = model.content1;
        }else {
            cell.textLabel.text = model.content2;
        }
    }

    return cell;
}

- (IBAction)baginMateAction:(UIButton *)sender {
    
    model = nil;
    [self.tableV reloadData];
    self.shareBtn.hidden = YES;
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    [sender setTitle:@"匹配中..." forState:UIControlStateNormal];
    if ([self.mainBtn.currentTitle isEqualToString:@"点击选择"]) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        [sender setTitle:@"开始匹配" forState:UIControlStateNormal];
        [SVProgressHUD showInfoWithStatus:@"请点击选择主生肖"];
        return;
    }
    
    if ([self.deputyBtn.currentTitle isEqualToString:@"点击选择"]) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        [sender setTitle:@"点击匹配" forState:UIControlStateNormal];
        [SVProgressHUD showInfoWithStatus:@"请点击选择副生肖"];
        return;
    }
    
    NSDictionary *params = @{@"key":kKEY,
                             @"shengxiao1":self.mainBtn.currentTitle
                             ,@"shengxiao2":self.deputyBtn.currentTitle,
                             @"dtype":@"JSON",
                             @"format":@"0"};
    [KSMNetworkRequest postRequest:kURL params:params success:^(id responseObj) {
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        NSLog(@"%@",responseObj);
        [SVProgressHUD showSuccessWithStatus:@"匹配成功"];
        self.shareBtn.hidden = NO;
        if ([responseObj[@"error_code"] integerValue] == 0) {
            
            self.shareBtn.hidden = NO;
            [sender setTitle:@"开始匹配" forState:UIControlStateNormal];
            model = [PairModel mj_objectWithKeyValues:responseObj[@"result"]];
            [self.tableV reloadData];
            
        }else {
            self.shareBtn.hidden = YES;
            [SVProgressHUD showErrorWithStatus:@"匹配失败，请检查网络"];
        }
        
    } failure:^(NSError *error) {
        self.shareBtn.hidden = YES;
        self.activityView.hidden = YES;
        [self.activityView stopAnimating];
        [SVProgressHUD showErrorWithStatus:@"匹配失败，请检查网络"];
        [sender setTitle:@"开始匹配" forState:UIControlStateNormal];
    }];
}

- (IBAction)shareBAction:(id)sender {
    
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[[NSString stringWithFormat:@"%@\n%@\n%@",model.title,model.content1,model.content2]] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
    
//    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//        [SVProgressHUD showInfoWithStatus:@"不可用,请到系统设置中配置账号和密码"];
//        return;
//    }
//
//    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//    // 预设文字
//    [composeVC setInitialText:[NSString stringWithFormat:@"title:%@ \n content1:%@ \n content2:%@",model.title,model.content1,model.content2]];
//    // 预设图片
//    [composeVC addImage:[UIImage imageNamed:model.shengxiao1]];
//
//    [self presentViewController:composeVC animated:YES completion:nil];
    

}

@end
