//
//  DarkMode.m
//  
//
//  Created by yaozuopan on 2021/03/17.
//  Copyright © 2021 yaozuopan. All rights reserved.
//

#import "DarkAdapter.h"
#import <UIKit/UIKit.h>

@implementation UIView(DASwizzlingSupportOfUIView)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUIView)]) {
        [[self class] swizzlingMomentOfUIView];
    }
}
@end


@implementation UILabel(DASwizzlingSupportOfUILabel)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUILabel)]) {
        [[self class] swizzlingMomentOfUILabel];
    }
}
@end


@implementation UIButton(DASwizzlingSupportOfUIButton)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUIButton)]) {
        [[self class] swizzlingMomentOfUIButton];
    }
}
@end


@implementation UIImageView(DASwizzlingSupportOfUIImageView)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUIImageView)]) {
        [[self class] swizzlingMomentOfUIImageView];
    }
}
@end


@implementation UITextView(DASwizzlingSupportOfUITextView)
+ (void)load {
    if ([[self class] respondsToSelector:@selector(swizzlingMomentOfUITextView)]) {
        [[self class] swizzlingMomentOfUITextView];
    }
}
@end
