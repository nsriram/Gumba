#import "CircleView.h"
#import "AppConstants.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entryVal AndBlip: (NSString*)blip {
    self = [super initWithFrame:frame AndEntry:entryVal AndBlip:blip];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     
    [self drawBackgroundGradient:context];    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, 9.0, 9.0, 8.5, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextSetStrokeColorWithColor(context, [[AppConstants blipColor] CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    [[UIColor blackColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:9];
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    CGPoint textPoint;
    if([entryString length] > 2) {
        textPoint = CGPointMake(0.0,9.0);        
    }else {
        textPoint = CGPointMake(1.0,7.0);
    }

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, textPoint.x, textPoint.y);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-0.785);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(textPoint.x), -(textPoint.y));
    [entryString drawAtPoint:textPoint withFont:font];
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}
@end
