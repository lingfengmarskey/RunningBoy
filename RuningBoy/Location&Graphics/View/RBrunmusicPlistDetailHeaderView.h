//
//  RBrunmusicPlistDetailHeaderView.h
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBrunmusicPlistDetailHeaderView : UITableViewHeaderFooterView
// 列表图片
@property (nonatomic, retain) UIImageView *plistImageView;
// 列表名称
@property (nonatomic, retain) UILabel *plistTitleLable;
// 列表简介
@property (nonatomic, retain) UILabel *plistInfoLable;
// 列表曲数
@property (nonatomic, retain) UILabel *plistCountLable;
// 分享按钮
@property (nonatomic, retain) UIButton *musicShareBtn;
// 喜欢按钮
@property (nonatomic, retain) UIButton *musicLikeBtn;
// 添加到播放列表
@property (nonatomic, retain) UIButton *musicPlistAddBtn;
// etc.
@property (nonatomic, retain) UIButton *etcBtn;

@end
