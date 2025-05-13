#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

+ (void)swizzleOriginalSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector NS_SWIFT_NAME(swizzle(original:with:));
@end

NS_ASSUME_NONNULL_END
