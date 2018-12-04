//
//  NNHVoiceSynthesisHelper.m
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/7/14.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHVoiceSynthesisHelper.h"


@interface NNHVoiceSynthesisHelper ()<AVSpeechSynthesizerDelegate>

/** 语音播放合成器 */
@property (nonatomic, strong) AVSpeechSynthesizer *voicePlayer;

/** 串行队列 */
@property (nonatomic, strong) dispatch_queue_t serialQueue;

/** 语音数组 */
@property (nonatomic, strong) NSMutableArray *textArray;

/** 正在播放语音队列 */
@property (nonatomic, assign) BOOL isSpeech;


/** <#注释#> */
@property (nonatomic, strong) NSString *currentText;

@end

@implementation NNHVoiceSynthesisHelper
NNHSingletonM


- (void)speechText:(NSString *)text
{
    [self.textArray addObject:text];
    
    if (!self.isSpeech) {
        //如果没有播放，则播放第一个音频
        
        dispatch_async(self.serialQueue, ^{
            [self startSpeakingWithText:self.textArray[0]];
        });
        self.currentText = self.textArray[0];
        self.isSpeech = YES;
    }
}

- (void)startSpeakingWithText:(NSString *)text
{
    //语音播报
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    
    utterance.pitchMultiplier = 0.8;
    
    //中式发音
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];

    utterance.voice = voice;
    
    [self.voicePlayer speakUtterance:utterance];
}


#pragma mark - AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    if (self.textArray.count) {
        [self.textArray removeObjectAtIndex:0];
    }
    if (self.textArray.count != 0) {
        dispatch_async(self.serialQueue, ^{
            [self startSpeakingWithText:self.textArray[0]];
        });
    }else {
        self.isSpeech = NO;
    }
}

- (NSMutableArray *)textArray
{
    if (_textArray == nil) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}

- (dispatch_queue_t)serialQueue
{
    if (_serialQueue == nil) {
        _serialQueue = dispatch_queue_create("DISPATCH_QUEUE_SERIAL_speech", DISPATCH_QUEUE_SERIAL);
    }
    return _serialQueue;
}

- (AVSpeechSynthesizer *)voicePlayer
{
    if (_voicePlayer == nil) {
        _voicePlayer = [[AVSpeechSynthesizer alloc] init];
        _voicePlayer.delegate = self;
    }
    return _voicePlayer;
}


@end
