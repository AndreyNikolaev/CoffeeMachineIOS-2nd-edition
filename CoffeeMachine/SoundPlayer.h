//
//  SoundPlayer.h
//  CoffeeMachine
//
//  Created by dancho on 9/19/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SoundPlayer : NSObject
@property NSString* fileName;
@property NSString* fileType;

<<<<<<< HEAD
- (id)initWithFileName: (NSString *)theFileName andFileType: (NSString *) TheFileType;
=======
- (id)initWithFileNameAndType:(NSString *)filename filetype : (NSString *)fileType;
>>>>>>> 884ed34fb99eed0df139c201e5359f79c4d9ed9a
-(void)play;
@end
