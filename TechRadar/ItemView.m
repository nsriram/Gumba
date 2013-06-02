#import "ItemView.h"
#import "AppConstants.h"

@implementation ItemView

@synthesize entry = _entry, blipName = _blipName, type = _type, isMinized = _isMinized, radius = _radius, tip = _tip, description = _description;

- (void)drawTextWithContext:(CGContextRef)context Text:(NSString *)text Font:(UIFont *)font At:(CGPoint)point Angle:(CGFloat)angle {
    [[UIColor blackColor] set];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, point.x, point.y);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(angle);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(point.x), -(point.y));
    CGFloat y = point.y;
    CGFloat height = self.frame.size.height * 0.82;
    if ([text length] < 8) {
        font = [AppConstants blipTextLargeFont];
        y = self.frame.size.height * 0.25;
        height = self.frame.size.height * 0.55;
    } else if ([text length] < 10) {
        font = [AppConstants blipTextMediumFont];
        y = self.frame.size.height * 0.15;
        height = self.frame.size.height * 0.65;
    } else if ([text length] < 14) {
        font = [AppConstants blipTextSemiMediumFont];
    } else if ([text length] < 21) {
        font = [AppConstants blipTextSmallFont];
    }
    [text drawInRect:CGRectMake(0.0, y, self.frame.size.width, height) withFont:font
       lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    CGContextRestoreGState(context);
}

- (void)minimize {
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x / 2.0, currentFrame.origin.y / 2.0, currentFrame.size.width / 2.0, currentFrame.size.height / 2.0)];
    _isMinized = TRUE;
}

- (void)maximize {
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x * 2.0, currentFrame.origin.y * 2.0, currentFrame.size.width * 2.0, currentFrame.size.height * 2.0)];
    _isMinized = FALSE;
}

- (id)initWithFrame:(CGRect)frame Entry:(NSInteger)entry Tip:(NSString *)tip Description:(NSString *)description Blip:(NSString *)blipName Type:(NSString *)type Radius:(NSInteger)radius {
    self = [super initWithFrame:frame];
    if (self) {
        self.isMinized = TRUE;
        self.entry = entry;
        self.blipName = blipName;
        self.tip = tip;
        self.description = description;
        self.radius = radius;
        self.backgroundColor = [UIColor clearColor];
        self.type = type;
    }
    return self;
}
@end