#import "ReferenceViewController.h"
#import "PreviewViewController.h"
#import "AppConstants.h"

static NSMutableDictionary *referenceLinks = nil;
 
@implementation ReferenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(IBAction) link:(UIButton*)button {
    NSString *label = button.currentTitle;
    NSString *urlString = [referenceLinks objectForKey:label];
    if (urlString) {
        self.currentURL = urlString;
        [self performSegueWithIdentifier:@"ref-to-preview" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ref-to-preview"]) {
    	PreviewViewController *controller = (PreviewViewController*)segue.destinationViewController;
        controller.url = self.currentURL;
	}
}

- (void)viewDidLoad {
    if (!referenceLinks) {
        referenceLinks = [NSMutableDictionary dictionaryWithCapacity:20];
        [referenceLinks setObject:@"http://alice.org" forKey:@"Alice"];
        [referenceLinks setObject:@"http://pig.apache.org" forKey:@"Apache Pig"];
        [referenceLinks setObject:@"http://calatrava.github.com" forKey:@"Calatrava"];
        [referenceLinks setObject:@"http://d3js.org" forKey:@"D3"];
        [referenceLinks setObject:@"http://dropwizard.codahale.com" forKey:@"Dropwizard"];
        [referenceLinks setObject:@"http://kodowa.com" forKey:@"Light Table"];
        [referenceLinks setObject:@"http://locust.io" forKey:@"Locust"];
        [referenceLinks setObject:@"http://lua.org" forKey:@"Lua"];
        [referenceLinks setObject:@"http://aphyr.github.com/riemann/" forKey:@"Riemann"];
        [referenceLinks setObject:@"http://scratch.mit.edu" forKey:@"Scratch"];
        [referenceLinks setObject:@"http://silverbackapp.com" forKey:@"Silverback"];
        [referenceLinks setObject:@"http://zucchiniframework.org" forKey:@"Zucchini"];
    }
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end