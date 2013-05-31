#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CircleView.h"
#import "AppConstants.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    CGRect enclosure = CGRectMake(0.0, 0.0, rect.size.width, rect.size.height);
    if(!self.isMinized) {
        UIFont *font = [AppConstants blipTextTinyFont];
        CGPoint textPoint = CGPointMake(0.0, 0.0);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:CIRCLE_TEXT_ANGLE];
        enclosure = CGRectMake(rect.size.width*0.4, rect.size.height*0.8,rect.size.width*0.2,rect.size.height*0.2);
        UIImage *myImage = [UIImage imageNamed:@"circle_blip.png"];
        [myImage drawInRect:enclosure];
    }
    else {
        enclosure = CGRectMake(0.0, 0.0, rect.size.width*0.6, rect.size.height*0.6
        );
        UIImage *myImage = [UIImage imageNamed:@"circle_blip.png"];
        [myImage drawInRect:enclosure];
    }
}
@end