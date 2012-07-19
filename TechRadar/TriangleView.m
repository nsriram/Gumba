#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    [self drawBackgroundGradient:context];
    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);    
    CGContextMoveToPoint(context, 0.0, 0.0); 
    CGContextAddLineToPoint(context, 9.0,18.0);
    CGContextAddLineToPoint(context, 18.0,0.0);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
    
    [[UIColor blackColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:9];
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    CGPoint textPoint = CGPointMake(1.0, 7.0);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, textPoint.x, textPoint.y);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-1.046666666666667);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(textPoint.x), -(textPoint.y));
    [entryString drawAtPoint:textPoint withFont:font];
    CGContextRestoreGState(context);
}
@end
