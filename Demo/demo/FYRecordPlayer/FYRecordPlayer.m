//
//  FYRecordPlayer.m
//  Demo
//
//  Created by Eju on 2019/5/31.
//  Copyright © 2019年 Eju. All rights reserved.
//

#import "FYRecordPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface FYRecordPlayer ()

@property (nonatomic, strong) AVPlayer * player;

@property(nonatomic, assign)CGFloat progress;
@property(nonatomic, assign)CGFloat currentTime;
@property(nonatomic, assign)CGFloat totalTime;

@end


@implementation FYRecordPlayer


-(AVPlayer *)player{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        
    }
    return _player;
}

+ (instancetype)shareRecordPlayer {
    static FYRecordPlayer * shareRecordPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareRecordPlayer = [[self alloc] init];
        
    });
    return shareRecordPlayer;
}


-(instancetype)init{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)setBackGroundPlay{
    // 1. 设置会话模式
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil]; ;
    // 2. 激活会话
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}



// 开始播放某段音频
- (void)beginPlayWithURL:(NSString *)url{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self.player];

    NSURL *remoteURL = [NSURL URLWithString:url];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:remoteURL];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self play];
    
    AVPlayerItem * songItem = self.player.currentItem;
    __weak typeof(self)weakself = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds(songItem.duration);
        float progress = current / total;
        if (current) {
            if (current != weakself.currentTime || total != weakself.totalTime) {
                weakself.currentTime = current;
                weakself.totalTime = total;
                weakself.progress = progress;
                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(fyrecodePlayerDelegateWithCurrentTime:totalTime:progress:)]) {
                    [weakself.delegate fyrecodePlayerDelegateWithCurrentTime:current totalTime:total progress:progress];
                }
            }
        }
    }];
}

// 暂停后开始
- (void)play{
    [self.player play];
}

// 暂停
- (void)pause{
    [self.player pause];
}

// 停止
- (void)stop{
    __weak typeof(self) tmp = self;
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [tmp pause];
    }];
}

// 跳转到某个时间点播放
- (void)jumpedToTime:(NSTimeInterval)time
{
    __weak typeof(self)weakself = self;
    [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        if (finished){
            [weakself play];
        }
    }];
}


- (void)playbackFinished{
    NSLog(@"播放完成");
    [[NSNotificationCenter defaultCenter] removeObserver:self.player];
    self.player = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyrecodeDidComplete)]) {
        [self.delegate fyrecodeDidComplete];
    }
}

- (void)clearFYRecord{
    [[NSNotificationCenter defaultCenter] removeObserver:self.player];
    self.player = nil;
}




@end
