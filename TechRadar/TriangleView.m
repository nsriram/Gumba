#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);    
    CGContextMoveToPoint(context, 10.0, 0.0); 
    CGContextAddLineToPoint(context, 0.0,20.0);
    CGContextAddLineToPoint(context, 20.0,20.0);
    CGContextAddLineToPoint(context, 10.0, 0.0);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
    
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    CGFloat xPos = 4.0;
    CGFloat fontSize = 10.0;
    if([entryString length] == 1){
        xPos = 4.5;
    } else if([entryString length] > 2){
        xPos = 2.5;
        fontSize=8.5;
    }
    UIFont *font = [UIFont systemFontOfSize:        fontSize];
    CGPoint textPoint = CGPointMake(xPos, 8.0);
    [self drawTextWithContext:context Text:entryString Font:font At:textPoint Angle:TRIANGLE_TEXT_ANGLE];
}
@end
