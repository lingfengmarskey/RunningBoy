//
//  RBMusicPlayerView.h
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBMusicPlayerView : UIView
@property (nonatomic, retain) UIImageView *musicLlistImageView;
@property (nonatomic, retain) UIButton *musicLastBtn;
@property (nonatomic, retain) UIButton *musicNextBtn;
@property (nonatomic, retain) UIButton *musicPlayBtn;
@property (nonatomic, retain) UIProgressView *musicProgressView;
@property (nonatomic, retain) UIImageView *musicPosterImageView;
@property (nonatomic, retain) UILabel *musicCurrentListLable;
@property (nonatomic, retain) UILabel *musicProgressTimeLable;
@property (nonatomic, retain) UILabel *musicTotalTimeLable;

@end
