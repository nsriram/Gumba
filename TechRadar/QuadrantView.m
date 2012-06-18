#import "QuadrantView.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"

@interface QuadrantView()
@property (nonatomic, assign) CGPoint frameOrigin;
@end

#define GUMBA @"gumba"
#define JSON @"json"

@implementation QuadrantView

@synthesize center,rotation;
@synthesize frameOrigin;
@synthesize quadrantName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(CGPoint) rasterFromAngle:(int) angle AndRadius:(int)radius {
    CGFloat x = radius * cos((angle * M_PI/180));
    CGFloat y = radius * sin((angle * M_PI/180));  
    return CGPointMake(x,y);
}

- (void)resizeQuadrant
{
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:animationIDfinished:finished:context:)];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.50];
	[UIView setAnimationTransition:([self superview] ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromLeft)
                           forView:self
                             cache:NO];
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

- (id)initWithFrame:(CGRect)frame WithCenter:(CGPoint)point AndRotation:(BOOL)arcRotation AndName:(NSString*) quadName {
    self = [super initWithFrame:frame];
    if (self) {
        self.frameOrigin=self.frame.origin;
        self.center = point;
        self.rotation = arcRotation;
        self.quadrantName = quadName;

        UITapGestureRecognizer *singleTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resizeQuadrant)];
        
        [singleTap setNumberOfTapsRequired:1];
        [singleTap setNumberOfTouchesRequired:1];
        
        [self addGestureRecognizer:singleTap];        

    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, M_PI, self.rotation);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}   

- (void)drawFilledCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillPath(context);
    UIGraphicsPopContext();
}   

-(void) drawTriangleAtPoint:(CGPoint)p1 inContext:(CGContextRef)context{

    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);
    [[UIColor yellowColor] setStroke];    
    
    CGContextMoveToPoint(context, p1.x, p1.y); 
    CGContextAddLineToPoint(context, p1.x + 15.0,p1.y + 15.0);
    CGContextAddLineToPoint(context, p1.x - 15.0,p1.y + 15.0);
    CGContextAddLineToPoint(context, p1.x, p1.y);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    // Fill the path
    CGContextSetFillColorWithColor(context, [[UIColor yellowColor] CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    
}

+(NSMutableDictionary *)readJSON {
    NSString *gumbaJSON = @"";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:GUMBA ofType:JSON];  
    if (filePath) {
        gumbaJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];  
    }
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    return [parser objectWithString:gumbaJSON error:nil];    
}

-(void) drawBackgroundGradient : (CGContextRef) context{
    size_t num_locations = 3;
    CGFloat locations[3] = { 0.0, 0.0, 0.3};
    CGFloat components[12] = {  0.6, 0.6, 0.6, 1.0,        
        0.5, 0.5, 0.5, 1.0,
        0.7, 0.7, 0.7, 0.7 };
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

    NSMutableDictionary *allQuadrants = [QuadrantView readJSON];
    NSMutableArray *names = [allQuadrants objectForKey:quadrantName];

    for(NSMutableDictionary *blip in names){
        NSString *blipName = [blip objectForKey:@"name"];
        NSString *movement = [blip objectForKey:@"movement"];

        NSMutableDictionary *pcMap = [blip objectForKey:@"pc"];
        NSString *r = [pcMap objectForKey:@"r"];
        NSString *t = [pcMap objectForKey:@"t"];
        CGPoint point = [self rasterFromAngle:[t intValue] AndRadius:[r intValue]];

        if(point.x < 0){
            point.x = 384.0 + point.x;
        } 


        if(point.y <0){
            point.y = (point.y * -2)/2;
        } else {
            point.y = 502.0 - point.y;
        }

        if([movement isEqualToString:@"t"]){
            [self drawTriangleAtPoint:point inContext:context];                
        }else {
            [self drawFilledCircleAtPoint:point withRadius:10.0 inContext:context];                
        }        
    }
    [self drawBackgroundGradient:context];

    CGContextSetLineWidth(context, 3.0);
    [[UIColor whiteColor] setStroke];
    
    [self drawCircleAtPoint:self.center withRadius:150 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:350 inContext:context];    
    [self drawCircleAtPoint:self.center withRadius:400 inContext:context];    

    CGRect    myFrame = self.bounds;
    CGContextSetLineWidth(context, 2);
    CGRectInset(myFrame, 2, 2);
    [[UIColor blackColor] set];
    UIRectFrame(myFrame);
}

@end
