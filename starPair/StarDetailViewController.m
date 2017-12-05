//
//  StarDetailViewController.m
//  starPair
//
//  Created by edianzu on 2017/12/5.
//  Copyright © 2017年 com.zhy.gvgcn. All rights reserved.
//

#import "StarDetailViewController.h"
#import <Social/Social.h>
#import <SVProgressHUD.h>
@interface StarDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *content1Lab;
@property (weak, nonatomic) IBOutlet UILabel *content2Lab;

@end

@implementation StarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

-(void)setModel:(StarModel *)model {
    _model = model;
    self.titleLab.text = model.title;
    self.content1Lab.text = model.content1;
    self.content2Lab.text = model.content2;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.titleLab.text = self.model.title;
    self.content1Lab.text = self.model.content1;
    self.content2Lab.text = self.model.content2;
}


- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareAction:(id)sender {
    
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[[NSString stringWithFormat:@"%@\n%@\n%@",self.model.title,self.model.content1,self.model.content2]] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}


@end
