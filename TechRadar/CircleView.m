#import "CircleView.h"

@implementation CircleView
@synthesize entry;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndEntry:(NSInteger)entry {
    self = [super initWithFrame:frame];
    if (self) {
        self.entry = entry;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     
    UIColor *lightBlue = [UIColor colorWithRed: 0.0/255.0 
                                         green: 191.0/255.0 
                                          blue: 255.0/255.0
                                         alpha: 1.0];
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, 0.0,0.0, 7.0, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [lightBlue CGColor]);
    CGContextSetStrokeColorWithColor(context, [lightBlue CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    [[UIColor whiteColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:14];
    NSString *entryString = [NSString stringWithFormat:@"%d", self.entry]; 
    [entryString drawAtPoint:CGPointMake((0.0-7.0+1.0), (0.0+7.0-2.0)) withFont:font];
    UIGraphicsPopContext();
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint point= [touch locationInView:touch.view];
    NSLog(@"%f,%f",point.x,point.y);
}
@end
