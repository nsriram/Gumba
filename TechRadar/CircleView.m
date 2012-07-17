#import "CircleView.h"

@implementation CircleView
@synthesize entry;
@synthesize blipName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entryVal AndBlip: (NSString*)blip {
    self = [super initWithFrame:frame];
    if (self) {
        self.entry = entryVal;
        self.blipName = blip;
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

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     
    [self drawBackgroundGradient:context];
    UIColor *lightBlue = [UIColor colorWithRed: 0.0/255.0 
                                         green: 191.0/255.0 
                                          blue: 255.0/255.0
                                         alpha: 1.0];

    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, 9.0,9.0, 8.0, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [lightBlue CGColor]);
    CGContextSetStrokeColorWithColor(context, [lightBlue CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    [[UIColor blackColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:9];
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    CGPoint textPoint = CGPointMake(1.0,7.0);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, textPoint.x, textPoint.y);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-0.785);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(textPoint.x), -(textPoint.y));
    [entryString drawAtPoint:textPoint withFont:font];
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint point= [touch locationInView:touch.view];
    NSLog(@"Circle View %f,%f,%@",point.x,point.y,self.blipName);
    
    CGPoint parentOrigin = self.superview.frame.origin;

    CGRect someFrame = CGRectMake(parentOrigin.x, parentOrigin.y, 100.0, 60.0);
    UILabel *technology = [[UILabel alloc]initWithFrame:someFrame];
    technology.text=@"Testing";
    [self.superview insertSubview:technology atIndex:2];
}
@end
