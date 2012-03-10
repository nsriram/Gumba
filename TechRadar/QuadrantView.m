#import "QuadrantView.h"
#import <QuartzCore/QuartzCore.h>
#import "BackgroundLayer.h"


@interface QuadrantView()
@property (nonatomic, assign) CGPoint frameOrigin;
@end

@implementation QuadrantView

@synthesize center,rotation;
@synthesize frameOrigin;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndRotation:(BOOL)arcRotation
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameOrigin=self.frame.origin;
        self.center = point;
        self.rotation = arcRotation;
        
        UITapGestureRecognizer *doubleTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resizeQuadrant)];
        
        [doubleTap setNumberOfTapsRequired:2];
        [doubleTap setNumberOfTouchesRequired:1];
        
        [self addGestureRecognizer:doubleTap];
        
    }
    return self;
}

- (void)resizeQuadrant
{
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.75];
	
	[UIView setAnimationTransition:([self superview] ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
                           forView:self
                             cache:YES];
    CGRect resized;
    if(self.frame.size.height == 1004){
        resized = CGRectMake(self.frameOrigin.x, self.frameOrigin.y, 384, 502);
    } else {
        resized = CGRectMake(0, 0, 768, 1004);
        [self.superview bringSubviewToFront:self];
    }
    self.frame = resized;
	
	[UIView commitAnimations];
	
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, M_PI, self.rotation);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}   

-(void) drawTriangleAtPoint1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3 inContext:(CGContextRef)context{

    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);
    [[UIColor whiteColor] setStroke];    
    
    CGContextMoveToPoint(context, p1.x, p1.y); 
    CGContextAddLineToPoint(context, p2.x,p2.y);
    CGContextAddLineToPoint(context, p3.x,p3.y);
    CGContextAddLineToPoint(context, p1.x, p1.y);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    // Fill the path
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect    myFrame = self.bounds;
    CGContextSetLineWidth(context, 2);
    CGRectInset(myFrame, 2, 2);
    [[UIColor blackColor] set];
    UIRectFrame(myFrame);
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor whiteColor] setStroke];
    
    [self drawCircleAtPoint:self.center withRadius:125 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:200 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275 inContext:context];    
    [self drawCircleAtPoint:self.center withRadius:350 inContext:context];    

    [self drawTriangleAtPoint1:CGPointMake(300, 380) point2:CGPointMake(310, 390) point3:CGPointMake(290,390) inContext:context];
    [self drawTriangleAtPoint1:CGPointMake(260, 380) point2:CGPointMake(270, 390) point3:CGPointMake(250,390) inContext:context];
}

@end
