//
//  DraggableImageView.h
//  CoffeeMachine
//
//  Created by dancho on 9/11/13.
//  Copyright (c) 2013 graci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraggableImageView : UIImageView
//@property (weak, nonatomic) id <> delegate;

@property CGPoint startLocation;
@property (strong, nonatomic) DraggableImageView *copied;

@end
