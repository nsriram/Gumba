#import "ItemDetailViewController.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation ItemDetailViewController
@synthesize detail,description, descriptionText, detailText,itemType,imageText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)swipeRight:(UIPinchGestureRecognizer *)recognizer  {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) bindSwipeRight {
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];
    [self bindSwipeRight];
    [self.detail setText:detailText];
    [self.detail setNumberOfLines:0];
    [self.description setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:40]];
    [self.description setBackgroundColor:[AppConstants detailBackgroundColor]];
    [self.description setText:descriptionText];
    [self.description setFont:[UIFont fontWithName:@"TrebuchetMS" size:22]];
    [self.description setTextColor:[UIColor whiteColor]];
    [self.itemType setImage:[UIImage imageNamed:imageText]];
    self.description.layer.cornerRadius = 5;
    self.description.clipsToBounds=YES;
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
