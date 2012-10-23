#import "CircleView.h"
#import "AppConstants.h"


@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    UIGraphicsPushContext(context);
    CGFloat radius = self.frame.size.width/2;
    CGRect enclosure = CGRectMake(0.125*self.frame.size.width, 0.0, rect.size.width * 0.75, rect.size.height * 0.75);
    if(!self.isMinized) {
        radius = radius * 0.6;
        UIImage *myImage = [UIImage imageNamed:@"circle_blip@2x.png"];
        [myImage drawInRect:enclosure];
        UIFont *font = [UIFont fontWithName:@"Georgia" size:12.0];
        CGFloat x=0.0;
        if(self.tip.length < 7){
            CGFloat textWidth = (self.tip.length * self.frame.size.width)/6.0;
            x = (self.frame.size.width - textWidth)/2.0;
        }
        CGPoint textPoint = CGPointMake(x, radius*2.15);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
    }
    else {
        UIImage *myImage = [UIImage imageNamed:@"circle_blip.png"];
        [myImage drawInRect:enclosure];
    }
    UIGraphicsPopContext();
}
@end