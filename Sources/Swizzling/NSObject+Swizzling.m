#import "NSObject+Swizzling.h"

#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)swizzleOriginalSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    if (originalMethod && swizzledMethod) {
        BOOL didAddMethod = class_addMethod(self, originalSelector,
                                            method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(self, swizzledSelector,
                                method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

@end
