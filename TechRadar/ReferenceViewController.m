#import "ReferenceViewController.h"
#import "AppConstants.h"

@implementation ReferenceViewController
@synthesize referencesWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppConstants detailBackgroundColor]];
    NSString *myHTML = @"<html><body><ul><li><a href=\"http://martinfowler.com/articles/lmax.html\"> LMAX Disruptor </a></li><li><a href=\"http://martinfowler.com/bliki/PolyglotPersistence.html\"> Polyglot persistence </a></li><li><a href=\"http://microjs.com/\"> JavaScript microframeworks </a></li><li><a href=\"http://testingwithfrank.com/\"> Frank – IOS testing </a></li><li><a href=\"http://functionaljava.org/%20\"> Functional Java </a></li></ul></body></html>";
    [referencesWebView setBackgroundColor:[AppConstants detailBackgroundColor]];
    [referencesWebView loadHTMLString:myHTML baseURL:nil];
    [self bindSwipeRight];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
