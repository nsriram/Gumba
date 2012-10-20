#import "CircleView.h"
#import "AppConstants.h"


@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    
    CGFloat radius = self.frame.size.width/2;
    
    CGRect enclosure = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width/1.1, rect.size.height/1.1);
    
//    CGFloat x = radius;
    
    if(!self.isMinized) {
        radius = radius * 0.6;
        UIImage *myImage = [UIImage imageNamed:@"circle_blip@2x.png"];
        [myImage drawInRect:enclosure];
    }
    else {
        UIImage *myImage = [UIImage imageNamed:@"circle_blip.png"];
        [myImage drawInRect:enclosure];
    }
    
//    CGContextAddArc(context, x, radius*.9, radius*.8, 0, 2*M_PI, YES);
//    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
//    CGContextSetStrokeColorWithColor(context, [[AppConstants blipColor] CGColor]);
//    CGContextDrawPath(context, kCGPathFillStroke);
    if(!self.isMinized) {
        UIFont *font = [UIFont fontWithName:@"Verdana" size:9.0];
        CGPoint textPoint = CGPointMake(0.0, radius * 2.4);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
    }
    UIGraphicsPopContext();
}
@end