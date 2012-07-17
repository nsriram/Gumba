#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "QuadrantView.h"
#import "Radar.h"

#define TECHNIQUES @"Techniques"
#define LANGUAGES @"Languages"
#define TOOLS @"Tools"
#define PLATFORMS @"Platforms"

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    Radar *radar = [Radar radarFromFile:@"radar"];
    NSLog(@"radar ready");
    [radar print];

	CGPoint midPoint; // center of our bounds in our coordinate system
    midPoint.x = self.view.bounds.origin.x + self.view.bounds.size.width/2;
    midPoint.y = self.view.bounds.origin.y + self.view.bounds.size.height/2;
    
    NSLog(@"Midpoint: %f, %f", midPoint.x, midPoint.y);
    
    QuadrantView *quadrantView1 = [[QuadrantView alloc]initWithFrame:CGRectMake(0, 0, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(midPoint.x, midPoint.y)
                                                        AndRotation:YES AndName:TECHNIQUES];
    [self.view insertSubview:quadrantView1 atIndex:1];
    
    QuadrantView *quadrantView2 = [[QuadrantView alloc]initWithFrame:CGRectMake(midPoint.x, 0, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(0, midPoint.y)
                                                         AndRotation:YES AndName:TOOLS];
    [self.view insertSubview:quadrantView2 atIndex:1];

    
    QuadrantView *quadrantView3 = [[QuadrantView alloc]initWithFrame:CGRectMake(0, midPoint.y, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(midPoint.x, 0)
                                                         AndRotation:NO AndName:PLATFORMS];
    [self.view insertSubview:quadrantView3 atIndex:1];
    
    QuadrantView *quadrantView4 = [[QuadrantView alloc]initWithFrame:CGRectMake(midPoint.x, midPoint.y, midPoint.x, midPoint.y) 
                                                          WithCenter:CGPointMake(0, 0)
                                                         AndRotation:NO AndName:LANGUAGES];
    [self.view insertSubview:quadrantView4 atIndex:1];
    

    UIColor *lightBlue = [UIColor colorWithRed: 70.0/255.0 
                                         green: 130.0/255.0 
                                          blue: 170.0/255.0
                                         alpha: 1.0]; 
    [self.view setBackgroundColor:lightBlue];
    
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
