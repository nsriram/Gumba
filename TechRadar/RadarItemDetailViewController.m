#import "RadarItemDetailViewController.h"
#import "AppConstants.h"
#import <QuartzCore/QuartzCore.h>

@implementation RadarItemDetailViewController
@synthesize detail,detailText,delegate,itemType,imageText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];

    UIView *v = self.view;

    [v.layer setCornerRadius:30.0f];
    [v.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [v.layer setBorderWidth:1.5f];
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.8];
    [v.layer setShadowRadius:3.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];

    [self.detail setText:detailText];
    [self.detail setNumberOfLines:0];
    [self.detail sizeToFit];    
    [self.itemType setImage:[UIImage imageNamed:imageText]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

-(IBAction) ok:(UIButton *)ok {
    [self.delegate radarItemViewController:self];
}
@end
