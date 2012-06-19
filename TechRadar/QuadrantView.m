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

        UITapGestureRecognizer *doubleTap = 
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resizeQuadrant)];        
        [doubleTap setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTap];        

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

- (void)drawFilledCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context withEntry:(NSInteger)entry
{
    UIColor *lightBlue = [UIColor colorWithRed: 0.0/255.0 
                                         green: 191.0/255.0 
                                          blue: 255.0/255.0
                                         alpha: 1.0];
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextSetFillColorWithColor(context, [lightBlue CGColor]);
    CGContextSetStrokeColorWithColor(context, [lightBlue CGColor]);
    CGContextDrawPath(context, kCGPathFillStroke);

    [[UIColor whiteColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:14];
    NSString *entryString = [NSString stringWithFormat:@"%d", entry]; 
    [entryString drawAtPoint:CGPointMake((p.x-radius+1.0), (p.y+radius-2.0)) withFont:font];
    UIGraphicsPopContext();
}   

-(void) drawTriangleAtPoint:(CGPoint)point inContext:(CGContextRef)context withEntry:(NSInteger)entry{
    UIColor *lightBlue = [UIColor colorWithRed: 0.0/255.0 
                                         green: 191.0/255.0 
                                          blue: 255.0/255.0
                                         alpha: 1.0];

    CGMutablePathRef a_path = CGPathCreateMutable();
    CGContextBeginPath(context);
    [lightBlue setStroke];
    
    CGContextMoveToPoint(context, point.x, point.y); 
    CGContextAddLineToPoint(context, point.x + 10.0,point.y + 16.0);
    CGContextAddLineToPoint(context, point.x - 10.0,point.y + 16.0);
    CGContextAddLineToPoint(context, point.x, point.y);
    
    CGContextClosePath(context);
    CGContextAddPath(context, a_path);
    
    // Fill the path
    CGContextSetFillColorWithColor(context, [lightBlue CGColor]);
    CGContextFillPath(context);
    CGPathRelease(a_path);    

    [[UIColor whiteColor] set]; 
    UIFont *font = [UIFont systemFontOfSize:14];
    NSString *entryString = [NSString stringWithFormat:@"%d", entry]; 
    [entryString drawAtPoint:CGPointMake((point.x-7.0), (point.y+14.0)) withFont:font];
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
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 0.8};
    CGFloat components[12] = {  70.0/255.0, 130.0/255.0, 170.0/255.0, 0.8, 
        70.0/255.0, 130.0/255.0, 170.0/255.0, 1.0 };
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

- (void) drawArcTitles :(CGContextRef) context withTitle:(NSString*)label Width:(CGFloat)width Height:(CGFloat)distance{
    UIFont *font = [UIFont systemFontOfSize:24];
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x +width, self.center.y+distance);
    CGAffineTransform textTransform = CGAffineTransformMakeRotation(-1.57/2.0);
    CGContextConcatCTM(context, textTransform);
    CGContextTranslateCTM(context, -(self.center.x +width), -(self.center.y+distance));
    [label drawAtPoint:CGPointMake(self.center.x +width, self.center.y+distance) withFont:font];
    CGContextRestoreGState(context);
}

-(NSInteger) rangeBegin :(NSMutableDictionary*) allQuadrants {
    NSMutableArray *allRanges = [allQuadrants objectForKey:@"radar_quadrants"];
    NSInteger rangeBegin;
    for(NSMutableDictionary *range in allRanges){
        NSString *name =  [range objectForKey:@"name"];
        if([[name lowercaseString] isEqualToString:quadrantName]){
            rangeBegin = [[range objectForKey:@"start"] integerValue];
        }
    }
    return rangeBegin + 1;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();     

    [self drawBackgroundGradient:context];
    CGContextSetLineWidth(context, 3.0);
    [[UIColor whiteColor] setStroke];

    [self drawCircleAtPoint:self.center withRadius:150 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:275 inContext:context];
    [self drawCircleAtPoint:self.center withRadius:350 inContext:context];    
    [self drawCircleAtPoint:self.center withRadius:400 inContext:context];    

    [self drawArcTitles:context withTitle:@"Adopt" Width:90.0 Height:120.0];
    [self drawArcTitles:context withTitle:@"Trial" Width:165.0 Height:220.0];
    [self drawArcTitles:context withTitle:@"Assess" Width:210.0 Height:280.0];
    [self drawArcTitles:context withTitle:@"Hold" Width:250.0 Height:315.0];

    CGRect    myFrame = self.bounds;
    CGContextSetLineWidth(context, 1);
    CGRectInset(myFrame, 2, 2);
    [[UIColor whiteColor] set];
    UIRectFrame(myFrame);


    NSMutableDictionary *allQuadrants = [QuadrantView readJSON];
    NSMutableArray *names = [allQuadrants objectForKey:quadrantName];
    NSInteger rangeBegin = [self rangeBegin:allQuadrants];
    
    for(NSMutableDictionary *blip in names){
        NSString *blipName = [blip objectForKey:@"name"];
        NSString *movement = [blip objectForKey:@"movement"];
        
        NSMutableDictionary *pcMap = [blip objectForKey:@"pc"];
        NSString *r = [pcMap objectForKey:@"r"];
        NSString *t = [pcMap objectForKey:@"t"];
        CGPoint point = [self rasterFromAngle:[t intValue] AndRadius:[r intValue]];
        
        if(point.x < 0){
            point.x = 378.0 + point.x;
        } 
        if(point.y <0){
            point.y = (point.y * -1);
        } else {
            point.y = (494.0 - point.y);
        }
        if([movement isEqualToString:@"t"]){
            [self drawTriangleAtPoint:point inContext:context withEntry:rangeBegin];
        }else {
            [self drawFilledCircleAtPoint:point withRadius:7.0 inContext:context withEntry:rangeBegin];
        }        
        rangeBegin = rangeBegin +1;
    }
}
@end
