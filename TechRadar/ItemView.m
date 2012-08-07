#import "ItemView.h"
@implementation ItemView

@synthesize entry = _entry, blipName =_blipName, type = _type, isMinized = _isMinized, radius = _radius, tip=_tip;

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
    _isMinized=TRUE;
}

-(void) maximize {
    CGRect currentFrame = self.frame;
    [self setFrame:CGRectMake(currentFrame.origin.x*2.0, currentFrame.origin.y*2.0, currentFrame.size.width*2.0, currentFrame.size.height*2.0)];
    _isMinized=FALSE;
}

- (id)initWithFrame:(CGRect)frame Entry:(NSInteger)entry Tip:(NSString*)tip Blip:(NSString*)blipName Type:(NSString*)type Radius:(NSInteger) radius{
    self = [super initWithFrame:frame];
    if (self) {
        self.isMinized = TRUE;
        self.entry = entry;
        self.blipName = blipName;
        self.tip = tip;
        self.radius=radius;
        self.backgroundColor =[UIColor clearColor];
        self.type = type;
    }
    return self;
}
@end