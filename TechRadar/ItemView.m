#import "ItemView.h"
@implementation ItemView

@synthesize entry = _entry, blipName =_blipName, type = _type;

-(void) drawTextWithContext:(CGContextRef)context Text:(NSString*)text Font:(UIFont*)font At:(CGPoint) point Angle:(CGFloat)angle{
    [[UIColor blackColor] set]; 
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, point.x, point.y);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(angle);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(point.x), -(point.y));
    [text drawAtPoint:point withFont:font];
    CGContextRestoreGState(context);    
}

-(void) minimize{
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x/2.0, currentFrame.origin.y/2.0, currentFrame.size.width/2.0, currentFrame.size.height/2.0)];
}

-(void) maximize {
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x*2.0, currentFrame.origin.y*2.0, currentFrame.size.width*2.0, currentFrame.size.height*2.0)];
}

- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry AndBlip:(NSString*)blipName AndType:(NSString*)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.entry = entry;
        self.blipName = blipName;
        self.backgroundColor =[UIColor clearColor];
        self.type = type;
    }
    return self;
}
@end