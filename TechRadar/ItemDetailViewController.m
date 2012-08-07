#import "ItemDetailViewController.h"
#import "AppConstants.h"

@implementation ItemDetailViewController
@synthesize detail,detailText,itemType,imageText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    NSLog(@"view loading");
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants backgroundColor]];        
    [self.detail setText:detailText];
    [self.detail setNumberOfLines:0];
    [self.itemType setImage:[UIImage imageNamed:imageText]];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
