//
//  RBTabBarController.m
//  RuningBoy
//
//  Created by marskey on 16/3/23.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBTabBarController.h"
#import "RBLocationGraphicsVeiwController.h"
@interface RBTabBarController ()

@end

@implementation RBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
#pragma mark - setting TabBarTitle&Icon
- (void)setup{
    RBLocationGraphicsVeiwController *locVC = [[RBLocationGraphicsVeiwController alloc] init];
    [Tools addchildViewControllerNav:locVC ForTabBar:self TabBarItemTitle:@"RUN" TabBarImageNameOfNormalState:@"tabbar_run" TabBarImageNameOfSlected:@"tabbar_run"];
    
//    UIView *temp = [UIView new];
//    temp.layer.contents;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
