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
    
    UIFont *font = [UIFont systemFontOfSize:10];
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    CGPoint textPoint = CGPointMake(2.5,3.0);
    if([entryString length] > 2) {
        textPoint = CGPointMake(1.0,3.0);        
    }else if([entryString length] == 1){
        textPoint = CGPointMake(6.0,3.0);
    }
    [self drawTextWithContext:context Text:entryString Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
    UIGraphicsPopContext();
}
@end