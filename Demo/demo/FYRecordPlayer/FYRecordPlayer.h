//
//  FYRecordPlayer.h
//  Demo
//
//  Created by Eju on 2019/5/31.
//  Copyright © 2019年 Eju. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@protocol FYRecordPlayerDelegate <NSObject>

-(void)fyrecodePlayerDelegateWithCurrentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress;

-(void)fyrecodeDidComplete;

@end



@interface FYRecordPlayer : NSObject

+ (instancetype)shareRecordPlayer;

- (void)play;
- (void)pause;
- (void)stop;
- (void)jumpedToTime:(NSTimeInterval)time;
- (void)beginPlayWithURL:(NSString *)url;

@property(nonatomic, weak)id <FYRecordPlayerDelegate> delegate;

//清除所有信息，仅仅保留这个单例模式
- (void)clearFYRecord;

@end

NS_ASSUME_NONNULL_END
