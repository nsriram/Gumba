#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);    
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.width;
    
    CGContextMoveToPoint(context, width/2.0, 0.0); 
    CGContextAddLineToPoint(context, 0.0,height);
    CGContextAddLineToPoint(context, width,height);
    CGContextAddLineToPoint(context, width/2.0, 0.0);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
    if(!self.isMinized) {
        NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
        CGFloat xPos = width * 0.2;
        CGFloat fontSize = width * 0.5;
        if([entryString length] == 1){
            xPos = width * 0.25;
        } else if([entryString length] > 2){
            xPos = width * 0.125;
            fontSize=width * 0.425;
        }
        UIFont *font = [UIFont systemFontOfSize:        fontSize];
        CGPoint textPoint = CGPointMake(xPos, width * 0.4);
        [self drawTextWithContext:context Text:entryString Font:font At:textPoint Angle:TRIANGLE_TEXT_ANGLE];
    }
}
@end
