#import "TriangleView.h"
#import "AppConstants.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
//    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);
    
    CGRect enclosure = CGRectMake(3.0, 0.0, rect.size.width/1.35, rect.size.height/1.35);
    if(!self.isMinized) {
        UIImage *myImage = [UIImage imageNamed:@"triangle_blip@2x.png"];
        [myImage drawInRect:enclosure];
    }
    else {
        UIImage *myImage = [UIImage imageNamed:@"triangle_blip.png"];
        [myImage drawInRect:enclosure];
    }
    
//    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.width;
//    if(!self.isMinized){
//        CGContextMoveToPoint(context, width/2.0, 0.0); 
//        CGContextAddLineToPoint(context, width*0.2,height*0.6);
//        CGContextAddLineToPoint(context, width*0.8,height*0.6);
//        CGContextAddLineToPoint(context, width/2.0, 0.0);
//    } else {    
//        CGContextMoveToPoint(context, width/2.0, 0.0); 
//        CGContextAddLineToPoint(context, 0.0,height);
//        CGContextAddLineToPoint(context, width,height);
//        CGContextAddLineToPoint(context, width/2.0, 0.0);
//    }
//    CGContextClosePath(context);
//    CGContextAddPath(context, a_path);
//    
//    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
//    CGContextFillPath(context);
//    CGPathRelease(a_path);    
    if(!self.isMinized) {
        UIFont *font = [UIFont fontWithName:@"TrebuchetMS" size:9.0];
        CGFloat x=0.0;
        if(self.tip.length < 9){
            x = (11 - self.tip.length)/1.5;
        }
        CGPoint textPoint = CGPointMake(x, height * 0.6);
        [self drawTextWithContext:context Text:self.tip Font:font At:textPoint Angle:TRIANGLE_TEXT_ANGLE];
    }
}
@end
