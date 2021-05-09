//
//  DarkAdapter.h
//  DarkAdapter
//
//  Created by Harvey on 2021/4/22.
//

#import <Foundation/Foundation.h>

//! Project version number for DarkAdapter.
FOUNDATION_EXPORT double DarkAdapterVersionNumber;

//! Project version string for DarkAdapter.
FOUNDATION_EXPORT const unsigned char DarkAdapterVersionString[];


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


@protocol DASwizzlingProtocolOfUITextView <NSObject>
@optional
+ (void)swizzlingMomentOfUITextView;
@end
