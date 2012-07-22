#import "QuadrantView.h"
#import "CircleView.h"
#import "TriangleView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppConstants.h"
#import "Item.h"

@interface QuadrantView()
@property (nonatomic, assign) CGPoint frameOrigin;
@end

@implementation QuadrantView

@synthesize center, frameOrigin, quadrant = _quadrant;

- (void)resizeQuadrant {
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.50];
	[UIView setAnimationTransition:([self superview] ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromLeft)
                           forView:self
                             cache:NO];
    CGRect resized;


    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if(self.frame.size.height == screenHeight){
        for(CircleView *subView in self.subviews){
            [subView minimize];
        }
        resized = CGRectMake(self.frameOrigin.x, self.frameOrigin.y, screenWidth/2, screenHeight/2);
    } else {
        for(CircleView *subView in self.subviews){
            [subView maximize];
        }
        resized = CGRectMake(0, 0, screenWidth, screenHeight);
        [self.superview bringSubviewToFront:self];
    }
    self.frame = resized;	
	[UIView commitAnimations];	
}

- (void) drawArcTitles :(CGContextRef) context withTitle:(NSString*)label Width:(CGFloat)width Height:(CGFloat)distance{
    [[UIColor whiteColor] set];
    UIFont *font = [UIFont systemFontOfSize:18];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x +width, self.center.y+distance);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-1.57/2.0);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(self.center.x +width), -(self.center.y+distance));
    [label drawAtPoint:CGPointMake(self.center.x +width, self.center.y+distance) withFont:font];
    CGContextRestoreGState(context);
}

-(void) drawQuadrantLabelInContext:(CGContextRef)context{
    float labelX = self.frame.size.width/3.0;
    float labelYDelta = 60.0;
    float labelY=0;
    
    if(self.frameOrigin.y == 0){
        labelY = labelYDelta;
    } else {
        labelY = self.frame.size.height - labelYDelta;
    }
    
    UIGraphicsPushContext(context);
    [[UIColor whiteColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:20];
    CGPoint textPoint = CGPointMake(labelX,labelY);
    [[_quadrant name] drawAtPoint:textPoint withFont:font];
    UIGraphicsPopContext();
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, M_PI*2.0, true);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}   

-( CGPoint) adjustPoint:(CGPoint) point {
    if(point.x < 0){
        point.x = 378.0 + point.x;
    } 
    if(point.y <0){
        point.y = (point.y * -1);
    } else {
        point.y = (494.0 - point.y);
    }
    return CGPointMake(point.x,point.y);
}

-(void) drawBackgroundGradient : (CGContextRef) context{
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0};
    CGFloat components[12] = {  70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8, 
        70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8 };
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (CGColorSpaceCreateDeviceRGB(), 
                                                                    components,locations, 
                                                                    num_locations);
    CGContextDrawLinearGradient (context, myGradient, CGPointMake(0.0, 0.0), 
                                 CGPointMake(self.frame.size.width, self.frame.size.height), 0);
}

-(void) bindDoubleTap {
    UITapGestureRecognizer *doubleTap = 
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resizeQuadrant)];        
    [doubleTap setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTap];        
}

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndQuadrant:(Quadrant*)quadrant{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameOrigin=self.frame.origin;
        self.center = point;
        _quadrant = quadrant;
    }
    [self bindDoubleTap];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     
    [self drawBackgroundGradient:context];
    
    NSMutableArray *circles = [_quadrant circles];
    NSMutableArray *triangles = [_quadrant triangles];
    
    for(Item *circle in circles){
        CGPoint point = [self adjustPoint:[circle raster]];
        CGRect someRect = CGRectMake(point.x, point.y, 20.0, 20.0);
        CircleView *circleView = [[CircleView alloc] initWithFrame:someRect AndEntry:[circle index] AndBlip:[circle name]];
        [self insertSubview:circleView atIndex:0];
    }
    
    for(Item *triangle in triangles){
        CGPoint point = [self adjustPoint:[triangle raster]];
        CGRect someRect = CGRectMake(point.x, point.y, 20.0, 20.0);
        TriangleView *triangleView = [[TriangleView alloc] initWithFrame:someRect AndEntry:[triangle index] AndBlip:[triangle name]];
        [self insertSubview:triangleView atIndex:0];
    }
    
    CGContextSetLineWidth(context, 2.0);
    [[UIColor whiteColor] setStroke];
    
    [self drawCircleAtPoint:self.center withRadius:150 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:350 inContext:context];    
    [self drawCircleAtPoint:self.center withRadius:400 inContext:context];    
    
    CGRect    myFrame = self.bounds;
    CGContextSetLineWidth(context, 1);
    CGRectInset(myFrame, 2, 2);
    [[UIColor whiteColor] set];
    UIRectFrame(myFrame);
    
    [self drawArcTitles:context withTitle:@"Adopt" Width:80.0 Height:130.0];
    [self drawArcTitles:context withTitle:@"Trial" Width:165.0 Height:225.0];
    [self drawArcTitles:context withTitle:@"Assess" Width:210.0 Height:280.0];
    [self drawArcTitles:context withTitle:@"Hold" Width:250.0 Height:315.0];    
    
    [self drawQuadrantLabelInContext:context];
}
@end