#import "UIView+Swizzling.h"

#import "NSObject+Swizzling.h"

@implementation UIView (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleOriginalSelector:@selector(initWithFrame:) withSwizzledSelector:@selector(initWithFrame_swizzle:)];
        [self swizzleOriginalSelector:@selector(initWithCoder:) withSwizzledSelector:@selector(initWithCoder_swizzle:)];
        [self swizzleOriginalSelector:@selector(awakeFromNib) withSwizzledSelector:@selector(awakeFromNib_swizzle)];
        [self swizzleOriginalSelector:@selector(traitCollectionDidChange:) withSwizzledSelector:@selector(traitCollectionDidChange_swizzle:)];
    });
}

- (instancetype)initWithFrame_swizzle:(CGRect)frame {
    self = [self initWithFrame_swizzle:frame];
    [self customInitialization];
    [self customizeUI];
    return self;
}

- (instancetype)initWithCoder_swizzle:(NSCoder *)coder {
    self = [self initWithCoder_swizzle:coder];
    [self customInitialization];
    return self;
}

- (void)awakeFromNib_swizzle {
    [self awakeFromNib_swizzle];
    [self customizeUI];
}

- (void)traitCollectionDidChange_swizzle:(UITraitCollection *)previousTraitCollection {
    [self traitCollectionDidChange_swizzle:previousTraitCollection];
//    if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
//        self.layer.borderColor = self.borderColor.CGColor;
//    }
}

- (void)customizeUI { }
- (void)customInitialization { }
@end
