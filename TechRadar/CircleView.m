#import "CircleView.h"
#import "AppConstants.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGFloat radius = self.frame.size.width/2;
    CGFloat x = radius;
    if(!self.isMinized) {        
        radius = radius * 0.6;
    }
    CGContextAddArc(context, x, radius*.9, radius*.8, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextSetShadow(context, CGSizeMake(2.0f, 2.0f), 2.0f);
    CGContextDrawPath(context, kCGPathFillStroke);
    if(!self.isMinized) {
        UIFont *font = [UIFont systemFontOfSize:10.5];
        CGPoint textPoint = CGPointMake(0.0, radius*1.75);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
    }
    UIGraphicsPopContext();
}
@end