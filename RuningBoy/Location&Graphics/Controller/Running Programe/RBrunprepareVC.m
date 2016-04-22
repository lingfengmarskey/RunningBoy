//
//  RBrunprepareVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunprepareVC.h"
#import "RBrunprepareCell.h"
#import "RBrunprepareView.h"
#import "RBrunningBeginVC.h"
@interface RBrunprepareVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
// background ScrollView
@property (nonatomic, retain) UIScrollView *bgscrollView;
// bottom start btn
@property (nonatomic, retain) UIButton *bottmstartBtn;

// selection collectionView -- deprecated
@property (nonatomic, retain) UICollectionView *collectionView;

@end
static NSString *RunCollectionCell = @"RunCollectionCell";
@implementation RBrunprepareVC

// 背景scrollView
- (UIScrollView *)bgscrollView{
    if (!_bgscrollView) {
        _bgscrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49)];
        _bgscrollView.contentSize = CGSizeMake(WIDTH * 2, 0);
        for (int i = 0; i < 3; i++) {
            RBrunprepareView *temp = [[RBrunprepareView alloc] initWithFrame:CGRectMake(0.25 * WIDTH + 0.5 * WIDTH * i, 0, 0.5 * WIDTH, HEIGHT - 49 - 64)];
            temp.runprepareViewTitle.text = @[@"基本跑步", @"定时跑步", @"距离跑步"][i];
            temp.runprepareViewImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"runprepare_%d", i + 1]];
            temp.alpha = 0.4;
            if (i == 0) {
                temp.alpha = 1;
            }
            temp.tag = 1001 + i;
            [_bgscrollView addSubview:temp];
        }
        _bgscrollView.showsHorizontalScrollIndicator = NO;
        _bgscrollView.showsVerticalScrollIndicator = NO;
        _bgscrollView.delegate = self;
        _bgscrollView.backgroundColor = Mlf_Color(248, 248, 248);
        [self.view addSubview:_bgscrollView];
    }
    return _bgscrollView;
}

// bottom start btn
- (UIButton *)bottmstartBtn{
    if (!_bottmstartBtn) {
        _bottmstartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottmstartBtn.frame = CGRectMake(0, HEIGHT - 49, WIDTH, 49);
        _bottmstartBtn.backgroundColor = [UIColor redColor];
        [_bottmstartBtn setTitle:@"开始" forState:UIControlStateNormal];
        [self.view addSubview:_bottmstartBtn];
    }
    return _bottmstartBtn;
}
// collection View - deprecated************
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout new];
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.itemSize = CGSizeMake(WIDTH * 0.5, HEIGHT);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, - WIDTH * 0.25, 0, 0);
        flowlayout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) collectionViewLayout:flowlayout];
        _collectionView.contentOffset = CGPointMake( -WIDTH * 0.25, -64);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor grayColor];
        [_collectionView registerClass:[RBrunprepareCell class] forCellWithReuseIdentifier:RunCollectionCell];
    }
    return _collectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollView];
//    [self.view addSubview:self.collectionView];
    [self.bottmstartBtn addTarget:self action:@selector(startRun) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - start Action
- (void)startRun {
    RBrunningBeginVC *beginVC = [RBrunningBeginVC new];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confrim = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController pushViewController:beginVC animated:YES];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    [alert addAction:confrim];
    [alert addAction:cancle];

    if (self.bgscrollView.contentOffset.x < 0.5 * WIDTH) {
        // basic mode
        [self.navigationController pushViewController:beginVC animated:YES];
    }else if (self.bgscrollView.contentOffset.x == WIDTH){
        // distance mode
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
           textField.placeholder = @"输入距离";
        }];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }else{
        // limit time mode
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"输入时间";
        }];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    
}
#pragma mark - collectionView Delegate Method --- Deprecated
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RBrunprepareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RunCollectionCell forIndexPath:indexPath];
    cell.backgroundColor = COLOR;
    cell.titleLable.text = @[@"基本跑步", @"定时跑步", @"距离跑步"][indexPath.row];
    return cell;
}
#pragma mark - scrollview Delegate Method
// 滑动停止定位
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < 0.25 * WIDTH) {
        self.bgscrollView.contentOffset = CGPointMake(0, -64);
    }else if (scrollView.contentOffset.x > 0.25 * WIDTH && scrollView.contentOffset.x < 0.5 * WIDTH)
    {
        self.bgscrollView.contentOffset = CGPointMake(0.5 * WIDTH, -64);
    }else if (scrollView.contentOffset.x > 0.5 * WIDTH && scrollView.contentOffset.x < 0.75 * WIDTH)
    {
        self.bgscrollView.contentOffset = CGPointMake(0.5 * WIDTH, -64);
    }else{
        self.bgscrollView.contentOffset = CGPointMake( WIDTH, -64);
    }
    CGFloat dynamicX = scrollView.contentOffset.x;
    for (int i = 0; i < 3; i++) {
        RBrunprepareView *temp = [scrollView viewWithTag:1001 + i];
        if (dynamicX + 0.25 * WIDTH == temp.frame.origin.x) {
            temp.alpha = 1;
        }else{
            temp.alpha = 0.4;
        }
    }

}
// 拽动停止定位
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    __weak typeof(self) WeakSelf = self;
    if (scrollView.contentOffset.x < 0.25 * WIDTH) {
        [UIView animateWithDuration:0.3 animations:^{
            WeakSelf.bgscrollView.contentOffset = CGPointMake(0, -64);
        }];
    }else if (scrollView.contentOffset.x > 0.25 * WIDTH && scrollView.contentOffset.x < 0.5 * WIDTH)
    {
        [UIView animateWithDuration:0.3 animations:^{
            WeakSelf.bgscrollView.contentOffset = CGPointMake(0.5 * WIDTH, -64);
        }];
    }else if (scrollView.contentOffset.x > 0.5 * WIDTH && scrollView.contentOffset.x < 0.75 * WIDTH)
    {
        [UIView animateWithDuration:0.3 animations:^{
            WeakSelf.bgscrollView.contentOffset = CGPointMake(0.5 * WIDTH, -64);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            WeakSelf.bgscrollView.contentOffset = CGPointMake( WIDTH, -64);
        }];
    }
    CGFloat dynamicX = scrollView.contentOffset.x;
    for (int i = 0; i < 3; i++) {
        RBrunprepareView *temp = [scrollView viewWithTag:1001 + i];
        if (dynamicX + 0.25 * WIDTH == temp.frame.origin.x) {
            temp.alpha = 1;
        }else{
            temp.alpha = 0.4;
        }
    }
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
