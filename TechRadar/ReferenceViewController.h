#import <UIKit/UIKit.h>

@interface ReferenceViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *referencesWebView;
}
@property (nonatomic,strong) IBOutlet UIWebView *referencesWebView;
@end
