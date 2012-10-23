#import "TWViewController.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>

@interface TWViewController ()

@end

@implementation TWViewController
@synthesize peopleImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)swipeRight:(UIPinchGestureRecognizer *)recognizer  {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) bindSwipeRight {
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)] ;
    singleTap.numberOfTapsRequired = 1;
    [[self view] addGestureRecognizer:singleTap];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *l = [self.peopleImage layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];
    [self bindSwipeRight];
    self.title = @"About Us";
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
