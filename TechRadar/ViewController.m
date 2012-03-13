#import "ViewController.h"
#import "QuadrantView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
