//
//  RBrunbeginView.h
//  RuningBoy
//
//  Created by marskey on 16/3/28.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBrunbeginView : UIView
// bgImageView
@property (nonatomic, retain) UIImageView *bgImageView;
// topMapBtn
@property (nonatomic, retain) UIButton *topMapBtn;
// topLockBtn
@property (nonatomic, retain) UIButton *topLockBtn;
// showDataLable
@property (nonatomic, retain) UILabel *showDataLable;
// dataUniteLable
@property (nonatomic, retain) UILabel *dataUnitLabe;
// sequence time lable --- tempo
@property (nonatomic, retain) UILabel *sequenceTimeLable;
// reverse time lable --- time
@property (nonatomic, retain) UILabel *reverseTimeLable;
// stop btn
@property (nonatomic, retain) UIButton *stopBtn;
// start btn
@property (nonatomic, retain) UIButton *startBtn;
// stop lable
//@property (nonatomic, retain) UILabel *stopLable;
// start lable
//@property (nonatomic, retain) UILabel *startLable;
// unlock lable
@property (nonatomic, retain) UILabel *unlockLable;
// current music lable
@property (nonatomic, retain) UILabel *currentLable;
// last song btn
@property (nonatomic, retain) UIButton *lastSongBtn;
// next song btn
@property (nonatomic, retain) UIButton *nextSontBtn;
// play btn
@property (nonatomic, retain) UIButton *playOrPauseBtn;
// photo btn
@property (nonatomic, retain) UIButton *photoBtn;
// blurview
@property (nonatomic, retain) UIVisualEffectView *blurView;
@end
