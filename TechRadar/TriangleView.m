#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);    
    CGContextMoveToPoint(context, 0.0, 0.0); 
    CGContextAddLineToPoint(context, 10.0,20.0);
    CGContextAddLineToPoint(context, 20.0,0.0);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
    
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    int fontSize = 9;
    if([entryString length] > 2){
        fontSize = 8;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGPoint textPoint = CGPointMake(2.0, 9.0);
    [self drawTextWithContext:context Text:entryString Font:font At:textPoint Angle:TRIANGLE_TEXT_ANGLE];
}
@end
