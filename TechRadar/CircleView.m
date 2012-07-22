#import "CircleView.h"
#import "AppConstants.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, 9.0, 9.0, 8.0, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIFont *font = [UIFont systemFontOfSize:9];
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    CGPoint textPoint;
    if([entryString length] > 2) {
        textPoint = CGPointMake(0.0,9.0);        
    }else {
        textPoint = CGPointMake(1.0,7.0);
    }
    [self drawTextWithContext:context Text:entryString Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
    UIGraphicsPopContext();
}
@end