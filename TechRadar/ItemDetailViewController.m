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
    [self.detail setTextColor:[AppConstants textColor]];
    detail.layer.masksToBounds = NO;
    [self.detail setText:detailText];
    [self.detail setNumberOfLines:0];
}

- (void)paintRadarItemDescription {
    description.layer.masksToBounds = NO;
    [self.description setBackgroundColor:[AppConstants detailBackgroundColor]];
    [self.description setText:[@"\n" stringByAppendingString:self.descriptionText]];
    [self.description setFont:[AppConstants labelTextFont]];
    [self.description setTextColor:[AppConstants textColor]];
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
