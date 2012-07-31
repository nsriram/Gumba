#import "CircleView.h"
#import "AppConstants.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGFloat radius = self.frame.size.width/2;
    CGContextAddArc(context, radius, radius, radius*.8, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    if(!self.isMinized) {        
        UIFont *font = [UIFont systemFontOfSize:radius];
        NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
        
        CGPoint textPoint = CGPointMake(radius*0.25,radius*0.3);
        if([entryString length] > 2) {
            textPoint = CGPointMake(radius*0.1,radius*0.3);
        }else if([entryString length] == 1){
            textPoint = CGPointMake(radius*0.5,radius*0.2);
        }
        
        [self drawTextWithContext:context Text:entryString Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];}
    UIGraphicsPopContext();
}
@end