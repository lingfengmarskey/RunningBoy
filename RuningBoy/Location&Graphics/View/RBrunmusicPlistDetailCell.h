//
//  RBrunmusicPlistDetailCell.h
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBrunmusicPlistDetailCell : UITableViewCell
// head imageview
@property (nonatomic, retain) UIImageView *headImageView;
// 歌曲名字
@property (nonatomic, retain) UILabel *songNameLable;
// 歌手名称
@property (nonatomic, retain) UILabel *singerNameLable;
// 歌曲时间
@property (nonatomic, retain) UILabel *songTimeLable;
// 更多
@property (nonatomic, retain) UILabel *moreLable;

@end
