//
//  SoundPlayer.m
//  CoffeeMachine
//
//  Created by dancho on 9/19/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer

- (id)initWithFileNameAndType:(NSString *)filename filetype : (NSString *)fileType
{
    self = [super init];
    if (self) {
        self.fileName = filename;
        self.fileType = fileType;
    }
    return self;
}

-(void)play
{
	SystemSoundID SoundID;
	NSString *soundFile = [[NSBundle mainBundle] pathForResource: self.fileName ofType:self.fileType];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) [NSURL fileURLWithPath:soundFile], &SoundID);
	AudioServicesPlaySystemSound(SoundID);
}

@end
