//
//  ViewController.m
//  Demo
//
//  Created by Eju on 2019/2/25.
//  Copyright © 2019年 Eju. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FYRecordPlayer.h"


#import "FSAES128.h"
#import "FYTestXibViewController.h"


@interface ViewController ()<AVAudioPlayerDelegate, FYRecordPlayerDelegate>

//@property (nonatomic, strong) AVAudioPlayer *audioPlayer;


@property (nonatomic, strong) AVPlayer * player;

@property(nonatomic, strong)UILabel * label;
@property(nonatomic, strong)UILabel * label1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 64, [UIScreen mainScreen].bounds.size.width-100, 200)];
    label1.backgroundColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:15];
    label1.numberOfLines = 0;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor blackColor];
    [self.view addSubview:label1];
    self.label1 = label1;
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, [UIScreen mainScreen].bounds.size.width-100, 200)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    self.label = label;
    

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开始播放" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];

    btn.frame = CGRectMake(50, 550, [UIScreen mainScreen].bounds.size.width-100, 45);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

    return;
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"暂停" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 3;
    btn2.layer.masksToBounds = YES;
    btn2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn2];
    
    btn2.frame = CGRectMake(50, 280, [UIScreen mainScreen].bounds.size.width-100, 45);
    [btn2 addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"停止" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn3.layer.cornerRadius = 3;
    btn3.layer.masksToBounds = YES;
    btn3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn3];
    btn3.frame = CGRectMake(50, 360, [UIScreen mainScreen].bounds.size.width-100, 45);
    [btn3 addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setTitle:@"继续播放" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn4.layer.cornerRadius = 3;
    btn4.layer.masksToBounds = YES;
    btn4.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn4];
    btn4.frame = CGRectMake(50, 420, [UIScreen mainScreen].bounds.size.width-100, 45);
    [btn4 addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitle:@"快进10s" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn5.layer.cornerRadius = 3;
    btn5.layer.masksToBounds = YES;
    btn5.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn5];
    btn5.frame = CGRectMake(50, 490, [UIScreen mainScreen].bounds.size.width-100, 45);
    [btn5 addTarget:self action:@selector(jumpedToTime) forControlEvents:UIControlEventTouchUpInside];
    
}
//开始播放
- (void)btnClick{
    
    
    UIViewController * vc = [NSClassFromString(@"LLLoadViewController") new];
    
    
//    FYTestXibViewController * vc = [FYTestXibViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    return;

    
    
    
    NSString * str = @"Zv9hE69IUTdARCkn47A0uyTmUYnWPx3CWqmcMLAqzKHCh6uYWZVsurkBUpDfH3j0PJRGkC1otcuNsvMrGU35f1ewHsjbYoAlfPzFJTXhTOZmlIO8SE3I0T4sux0WMwXKdcTkI1c4pngc9T/Q/Z1Xu91CGl45CmRUIer2RKm3Au3HJyL31TMDbsH3x+QAsnrChW6HpE9kH42Ub2MtEAnmfpsUKQ0oBVZdM438XvwS2w/XPzPcuTsa1TPUkpKOEoE3znNb4ANXFXC2yJ94YsxSCKFQBikl16mWFhjmTeJiRSOVfT7EkUlOGgdTgRE6/DiV5pRrpM+uXmAnNt+P+1iU86Cn51yspuyx7nT0Qioi5wZPZBogIL3Fui/tJA++Nc9SJE/jn2vMUIP2zHRZWhnTLUfmjJ3Z2b30PFbbJme0qscMA+pXl7EjQQ8ZpYiDlkWqlFuZZjpJmWPIB3Aia/Yjb8Ee2SFMrlWGx442iaSA0ewec5uzRuqczv9ouBxstbk7q3gEmMxtK4/wyHm5fD0zvtY0qMkk2QsORYKmutgbedxANrDlC0Vj9gEGIFBldLih29ubRz2izL/4xvZPHstX9/A5H01hJMiL6gx+bo2dPT0=";
    self.label.text = str;
    
    NSString * aes = [FSAES128 AES128EncryptStrig:str];
    NSString * newString = [FSAES128 AES128DecryptString:aes];
    self.label1.text = newString;
    
    
    if ([str isEqualToString:newString]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"完全一致" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alert show];
        
    }
    
    
    
    NSLog(@"%@", newString);
    
    
    
    return;
    
    
    [[FYRecordPlayer shareRecordPlayer] beginPlayWithURL:@"http://music.163.com/song/media/outer/url?id=25906124.mp3"];
    [FYRecordPlayer shareRecordPlayer].delegate = self;
}

- (void)jumpedToTime{
    [[FYRecordPlayer shareRecordPlayer] jumpedToTime:260];
    [[FYRecordPlayer shareRecordPlayer] play];
}


- (void)pause{
    [[FYRecordPlayer shareRecordPlayer] pause];

}
- (void)play{
    [[FYRecordPlayer shareRecordPlayer] play];

}
- (void)stop{
    [[FYRecordPlayer shareRecordPlayer] stop];
}







-(void)fyrecodePlayerDelegateWithCurrentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress{
    self.label1.text = [NSString stringWithFormat:@"%.2f / %.2f", currentTime, totalTime];
    NSInteger a = (NSInteger)(progress*100);
    self.label.text = [NSString stringWithFormat:@"%ld %%", a];
}

-(void)fyrecodeDidComplete{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"播放完成了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"确定", nil];
    [alert show];
}


@end
