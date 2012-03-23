#import "ViewController.h"
#import "QuadrantView.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"


#define GUMBA @"gumba"
#define JSON @"json"
#define TECHNIQUES @"techniques"

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

-(CGPoint) rasterFromAngle:(int) angle AndRadius:(int)radius {
    CGFloat x = radius * cos((angle * M_PI/180));
    CGFloat y = radius * sin((angle * M_PI/180));  
    return CGPointMake(x,y);
}

+(NSString *)fetchGumbaData {
    NSString *gumbaJSON = @"";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:GUMBA ofType:JSON];  
    if (filePath) {
        gumbaJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];  
    }
    return gumbaJSON;
}

-(NSMutableDictionary *) parseGumbaJSON:(NSString *) gumbaJSON {
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    return [parser objectWithString:gumbaJSON error:nil];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *gumbaJSON = [ViewController fetchGumbaData];
    NSMutableDictionary *allQuadrants = [self parseGumbaJSON:gumbaJSON];
    NSMutableArray *names = [allQuadrants objectForKey:TECHNIQUES];

    for(NSMutableDictionary *technology in names){
        NSString *technologyName = [technology objectForKey:@"name"];
        NSMutableDictionary *pcMap = [technology objectForKey:@"pc"];
        NSString *r = [pcMap objectForKey:@"r"];
        NSString *t = [pcMap objectForKey:@"t"];
        CGPoint point = [self rasterFromAngle:[t intValue] AndRadius:[r intValue]];
        NSLog(@"%@,%f,%f",technologyName,point.x,point.y);
    }
    
	CGPoint midPoint; // center of our bounds in our coordinate system
    midPoint.x = self.view.bounds.origin.x + self.view.bounds.size.width/2;
    midPoint.y = self.view.bounds.origin.y + self.view.bounds.size.height/2;
    
    NSLog(@"Midpoint: %f, %f", midPoint.x, midPoint.y);
    
    QuadrantView *quadrantView1 = [[QuadrantView alloc]initWithFrame:CGRectMake(0, 0, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(midPoint.x, midPoint.y)
                                                        AndRotation:YES];
    [self.view insertSubview:quadrantView1 atIndex:1];
    
    QuadrantView *quadrantView2 = [[QuadrantView alloc]initWithFrame:CGRectMake(midPoint.x, 0, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(0, midPoint.y)
                                                         AndRotation:YES];
    [self.view insertSubview:quadrantView2 atIndex:1];

    
    QuadrantView *quadrantView3 = [[QuadrantView alloc]initWithFrame:CGRectMake(0, midPoint.y, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(midPoint.x, 0)
                                                         AndRotation:NO];
    [self.view insertSubview:quadrantView3 atIndex:1];
    
    QuadrantView *quadrantView4 = [[QuadrantView alloc]initWithFrame:CGRectMake(midPoint.x, midPoint.y, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(0, 0)
                                                         AndRotation:NO];
    [self.view insertSubview:quadrantView4 atIndex:1];    

    [self.view setBackgroundColor:[UIColor grayColor]];
//    [quadrantView1 setBackgroundColor:[UIColor lightGrayColor]];
//    [quadrantView2 setBackgroundColor:[UIColor lightGrayColor]];
//    [quadrantView3 setBackgroundColor:[UIColor lightGrayColor]];
//    [quadrantView4 setBackgroundColor:[UIColor lightGrayColor]];
    
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc] 
                                                initWithTarget:self 
                                                action:@selector(twoFingerPinch:)];
    
    [[self view] addGestureRecognizer:twoFingerPinch];
}

- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer 
{
    NSLog(@"Pinch scale: %f", recognizer.scale);
    if (recognizer.scale < 1.0) return;
    CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
    self.view.transform = transform;
} 


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
