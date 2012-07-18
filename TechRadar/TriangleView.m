#import "TriangleView.h"

@implementation TriangleView

@synthesize entry, blipName;

- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry AndBlip:(NSString*)blipName{
    self = [super initWithFrame:frame];
    if (self) {
        self.entry = entry;
        self.blipName = blipName;
    }
    return self;
}

-(void) drawBackgroundGradient : (CGContextRef) context{
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8, 
        70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8 };
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, 
                                                                    components,locations, 
                                                                    num_locations);
    CGPoint myStartPoint, myEndPoint;    
    myStartPoint.x = 0.0;    
    myStartPoint.y = 0.0;
    myEndPoint.x = self.frame.size.width;
    myEndPoint.y = self.frame.size.height;    
    CGContextDrawLinearGradient (context, myGradient, myStartPoint, myEndPoint, 0);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    [self drawBackgroundGradient:context];
    UIColor *lightBlue = [UIColor colorWithRed: 0.0/255.0 
                                         green: 191.0/255.0 
                                          blue: 255.0/255.0
                                         alpha: 1.0];
    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);    
    CGContextMoveToPoint(context, 0.0, 0.0); 
    CGContextAddLineToPoint(context, 9.0,18.0);
    CGContextAddLineToPoint(context, 18.0,0.0);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    // Fill the path
    CGContextSetFillColorWithColor(context, [lightBlue CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
    
    [[UIColor blackColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:9];
    NSString *entryString = [NSString stringWithFormat:@"%d", entry]; 
    CGPoint textPoint = CGPointMake(1.0, 7.0);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, textPoint.x, textPoint.y);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-1.046666666666667);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(textPoint.x), -(textPoint.y));
    [entryString drawAtPoint:textPoint withFont:font];
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

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint point= [touch locationInView:touch.view];
}
@end
