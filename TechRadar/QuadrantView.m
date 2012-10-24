#import "QuadrantView.h"
#import "CircleView.h"
#import "TriangleView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppConstants.h"
#import "Item.h"

@implementation QuadrantView

@synthesize center, frameOrigin, quadrant = _quadrant;

- (void) drawArcTitles :(CGContextRef) context withTitle:(NSString*)label Width:(CGFloat)width Height:(CGFloat)distance{
    
    //a non-distracting color that gels with the background for arc titles
    [[UIColor colorWithRed:189/255.0f green:190/255.0f blue:192/255.0f alpha:1] set];
    
    UIFont *font = [AppConstants labelTextFont];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x + width, self.center.y + distance);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-1.50/2.0);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(self.center.x + width), -(self.center.y+ distance));
    [label drawAtPoint:CGPointMake(self.center.x + width, self.center.y + distance) withFont:font];
    CGContextRestoreGState(context);
}

- (void) resize:(CGRect)fullScreen {
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.50];
	[UIView setAnimationTransition:([self superview] ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromLeft)
                           forView:self
                             cache:NO];
    CGRect resized;
    CGFloat screenWidth = fullScreen.size.width;
    CGFloat screenHeight = fullScreen.size.height;
    if(self.frame.size.height == screenHeight){
        for(CircleView *subView in self.subviews){
            [subView minimize];
            [subView setNeedsDisplay];
        }
        resized = CGRectMake(self.frameOrigin.x, self.frameOrigin.y, screenWidth/2, screenHeight/2);
    } else {
        for(CircleView *subView in self.subviews){
            [subView maximize];
            [subView setNeedsDisplay];
        }
        resized = CGRectMake(0, 0, screenWidth, screenHeight);
        [self.superview bringSubviewToFront:self];
    }
    self.frame = resized;	
	[UIView commitAnimations];	
}


-(void) drawQuadrantLabelInContext:(CGContextRef)context{
    float labelX = self.frame.size.width/3.0;
    float labelYDeltaTop = 20.0;
    float labelYDeltaBottom = 60.0;
    float labelY=0;
    
    if(self.frameOrigin.y == 0){
        labelY = labelYDeltaTop;
    } else {
        labelY = self.frame.size.height - labelYDeltaBottom;
    }
    
    UIGraphicsPushContext(context);
    [[AppConstants textColor] set];
    UIFont *font = [AppConstants boldLabelTextFont];
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
        point.x = self.frame.size.width + point.x;
    } 
    if(point.y <0){
        point.y = (point.y * -1);
    } else {
        point.y = (self.frame.size.height - point.y);
    }
    return CGPointMake(point.x,point.y);
}

-(void) drawBackgroundGradient : (CGContextRef) context{
    CGContextDrawLinearGradient (context, [AppConstants backgroundGradient], CGPointMake(0.0, 0.0), 
                                 CGPointMake(self.frame.size.width, self.frame.size.height), 0);
}

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndQuadrant:(Quadrant*)quadrant{
    self = [super initWithFrame:frame];
    if (self) {
        self.frameOrigin=self.frame.origin;
        self.center = point;
        _quadrant = quadrant;
    }
    return self;
}

- (void)addCircleViews {
    
    NSMutableArray *circles = [_quadrant circles];
    for(Item *circle in circles){
        CGPoint point = [self adjustPoint:[circle raster]];
        CGRect someRect = CGRectMake(point.x-CIRCLE_RADIUS, point.y-CIRCLE_RADIUS, CIRCLE_RADIUS*2.0, CIRCLE_RADIUS*2.0);
        CircleView *circleView = [[CircleView alloc] initWithFrame:someRect Entry:[circle index] Tip:[circle tip]  Description:[circle description] Blip:[circle name] Type:@"circle_blip@2x.png" Radius:[circle radius]];
        circleView.alpha = 0.0;
        [self insertSubview:circleView atIndex:0];
    }
    
}

- (void)addTriangleViews {
    NSMutableArray *triangles = [_quadrant triangles];    
    for(Item *triangle in triangles){
        CGPoint point = [self adjustPoint:[triangle raster]];
        CGRect someRect = CGRectMake(point.x-TRIANGLE_SIDE, point.y-TRIANGLE_SIDE, TRIANGLE_SIDE*2.5, TRIANGLE_SIDE*2.5);
        TriangleView *triangleView = [[TriangleView alloc] initWithFrame:someRect Entry:[triangle index] Tip:[triangle tip] Description:[triangle description] Blip:[triangle name] Type:@"triangle_blip@2x.png" Radius:[triangle radius]];
        triangleView.alpha = 0.0;
        [self insertSubview:triangleView atIndex:0];

    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();     
    
    [self drawBackgroundGradient:context];
    
    CGContextSetLineWidth(context, 1.5);
    [[UIColor colorWithRed:250.0/255.0f green:250.0/255.0f blue:250.0/255.0f alpha:1] setStroke];
//    [[UIColor lightGrayColor] setStroke];
    
    [self drawCircleAtPoint:self.center withRadius:150*RADAR_RATIO inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275*RADAR_RATIO inContext:context];
    [self drawCircleAtPoint:self.center withRadius:345*RADAR_RATIO inContext:context];
    [self drawCircleAtPoint:self.center withRadius:350*RADAR_RATIO inContext:context];
    [self drawCircleAtPoint:self.center withRadius:400*RADAR_RATIO inContext:context];    
    
    CGRect myFrame = self.bounds;
    CGContextSetLineWidth(context, 1);
    CGRectInset(myFrame, 2, 2);
    [[UIColor colorWithRed:250.0/255.0f green:250.0/255.0f blue:250.0/255.0f alpha:1] set];
    UIRectFrame(myFrame);
    
    [self drawArcTitles:context withTitle:@"Adopt" Width:80.0*RADAR_RATIO Height:130.0*RADAR_RATIO];
    [self drawArcTitles:context withTitle:@"Trial" Width:165.0*RADAR_RATIO Height:225.0*RADAR_RATIO];
    [self drawArcTitles:context withTitle:@"Assess" Width:210.0*RADAR_RATIO Height:280.0*RADAR_RATIO];
    [self drawArcTitles:context withTitle:@"Hold" Width:250.0*RADAR_RATIO Height:315.0*RADAR_RATIO];
    
    [self drawQuadrantLabelInContext:context];
}
@end