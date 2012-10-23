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

- (void)goBack:(UIPinchGestureRecognizer *)recognizer  {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void) bindBack {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionRight)];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)] ;
    singleTap.numberOfTapsRequired = 1;
    
    [[self view] addGestureRecognizer:swipe];
    [[self view] addGestureRecognizer:singleTap];
}

- (void)paintRadarItemDetailHeader {
    //Create outer glow
    detail.layer.shadowColor = [UIColor whiteColor].CGColor;
    detail.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    detail.layer.shadowRadius = 10.0;
    detail.layer.shadowOpacity = 0.3;
    detail.layer.masksToBounds = NO;
    [self.detail setText:detailText];
    [self.detail setNumberOfLines:0];
}

- (void)paintRadarItemDescription {
    //create drop-down shadow for text-view
    description.layer.shadowColor = [UIColor blackColor].CGColor;
    description.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    description.layer.shadowRadius = 10.0;
    description.layer.shadowOpacity = 0.5;
    description.layer.masksToBounds = NO;
    [self.description setBackgroundColor:[AppConstants detailBackgroundColor]];
    [self.description setText:[@"\n" stringByAppendingString:self.descriptionText]];
    [self.description setFont:[UIFont fontWithName:@"Georgia" size:20]];
    [self.description setTextColor:[UIColor blackColor]];
    self.description.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"notebook_line.png"]];
    //auto-adjust text-view height by content height
    CGRect frame = self.description.frame;
    frame.size.height = [self.description contentSize].height;
    self.description.frame = frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];
    self.title = @"Radar Notes";
    [self bindBack];
    [self.itemType setImage:[UIImage imageNamed:imageText]];
    [self paintRadarItemDetailHeader];
    [self paintRadarItemDescription];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
