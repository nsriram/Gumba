#import "UserGuideViewController.h"
#import "AppConstants.h"

@interface UserGuideViewController ()
@end

@implementation UserGuideViewController
@synthesize scrollView,pageControl,pageControlBeingUsed;

- (IBAction)changePage {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed=YES;
}

- (void)singleTap:(UIPinchGestureRecognizer *)recognizer  {
    if(self.pageControl.currentPage == 2) {
        self.pageControl.currentPage = 0;
        [self changePage];
    }
    else if(self.pageControl.currentPage < 2) {
        self.pageControl.currentPage += 1;
        [self changePage];
    }
}

-(void) bindTap {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)] ;
    singleTap.numberOfTapsRequired = 1;
    [[self scrollView] addGestureRecognizer:singleTap];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindTap];
    [self.scrollView setBackgroundColor:[UIColor colorWithRed: 19.0/255.0 green: 91.0/255.0 blue: 146.0/255.0 alpha: 1.0]];
    pageControlBeingUsed = NO;
    NSArray *images = [NSArray arrayWithObjects:@"userguide1", @"userguide2", @"userguide3",nil];
    for (int i = 0; i < images.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        NSString *fullpath = [[NSBundle mainBundle] pathForResource:[images objectAtIndex:i] ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:fullpath];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
        [subview addSubview:imgView];
        [self.scrollView addSubview:subview];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * images.count,
                                             self.scrollView.frame.size.height);
    self.title = @"User Guide";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}
@end