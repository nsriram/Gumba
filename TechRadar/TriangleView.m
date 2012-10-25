#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect enclosure = CGRectMake(0.125*self.frame.size.width, 0.0, rect.size.width * 0.75, rect.size.height * 0.75);
    if(!self.isMinized) {
        UIImage *myImage = [UIImage imageNamed:@"triangle_blip@2x.png"];
        [myImage drawInRect:enclosure];
        UIFont *font =  [AppConstants blipTextFont];
        CGFloat x=0.0;
        if(self.tip.length < 7){
            CGFloat textWidth = (self.tip.length * self.frame.size.width)/6.5;
            x = (self.frame.size.width - textWidth)/2.0;
        }
        CGPoint textPoint = CGPointMake(x, self.frame.size.height*0.69);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:TRIANGLE_TEXT_ANGLE];
    }
    else {
        UIImage *myImage = [UIImage imageNamed:@"triangle_blip.png"];
        [myImage drawInRect:enclosure];
    }
}
@end