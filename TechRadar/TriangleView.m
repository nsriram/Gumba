#import <QuartzCore/QuartzCore.h>
#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect enclosure;
    if(!self.isMinized) {
        UIFont *font = [AppConstants blipTextTinyFont];
        CGPoint textPoint = CGPointMake(0.0, 0.0);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:TRIANGLE_TEXT_ANGLE];
        enclosure = CGRectMake(rect.size.width*0.4, rect.size.height*0.82,rect.size.width*0.18,rect.size.height*0.18);
        UIImage *myImage = [UIImage imageNamed:@"triangle_blip.png"];
        [myImage drawInRect:enclosure];
    }
    else {
        enclosure = CGRectMake(0.0, 0.0, rect.size.width*0.6, rect.size.height*0.6);
        UIImage *myImage = [UIImage imageNamed:@"triangle_blip.png"];
        [myImage drawInRect:enclosure];
    }
}
@end