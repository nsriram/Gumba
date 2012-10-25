#import "CircleView.h"
#import "AppConstants.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    CGRect enclosure = CGRectMake(0.125*self.frame.size.width, 0.0, rect.size.width * 0.5, rect.size.height * 0.375);
    if(!self.isMinized) {
        enclosure = CGRectMake(0.0, 0.0, rect.size.width * 0.25, rect.size.height * 0.2);
        UIImage *myImage = [UIImage imageNamed:@"circle_blip@2x.png"];
        [myImage drawInRect:enclosure];
        UIFont *font = [AppConstants blipTextFont];
        CGPoint textPoint = CGPointMake(0.0, self.frame.size.height*0.175);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
    }
    else {
        UIImage *myImage = [UIImage imageNamed:@"circle_blip.png"];
        [myImage drawInRect:enclosure];
    }
}
@end