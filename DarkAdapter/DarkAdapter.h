//
//  DarkMode.h
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

#import <Foundation/Foundation.h>

//! Project version number for DarkMode.
FOUNDATION_EXPORT double DarkModeVersionNumber;

//! Project version string for DarkMode.
FOUNDATION_EXPORT const unsigned char DarkModeVersionString[];


@protocol DASwizzlingProtocolOfUIView <NSObject>
@optional
+ (void)swizzlingMomentOfUIView;
@end


@protocol DASwizzlingProtocolOfUILabel <NSObject>
@optional
+ (void)swizzlingMomentOfUILabel;
@end


@protocol DASwizzlingProtocolOfUIButton <NSObject>
@optional
+ (void)swizzlingMomentOfUIButton;
@end


@protocol DASwizzlingProtocolOfUIImageView <NSObject>
@optional
+ (void)swizzlingMomentOfUIImageView;
@end
