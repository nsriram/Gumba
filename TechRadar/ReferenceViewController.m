#import "ReferenceViewController.h"
#import "PreviewViewController.h"
#import "AppConstants.h"

static NSMutableDictionary *referenceLinks = nil;

@implementation ReferenceViewController
@synthesize references;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (IBAction)link:(UIButton *)button {
    NSString *label = button.currentTitle;
    NSString *urlString = [referenceLinks objectForKey:label];
    if (urlString) {
        self.currentURL = urlString;
        [self performSegueWithIdentifier:@"ref-to-preview" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ref-to-preview"]) {
        PreviewViewController *controller = (PreviewViewController *) segue.destinationViewController;
        controller.url = self.currentURL;
    }
}

- (void)viewDidLoad {
    for (UIButton *reference in self.references) {
        reference.titleLabel.font = [AppConstants labelTextFont];
    }
    if (!referenceLinks) {
        referenceLinks = [NSMutableDictionary dictionaryWithCapacity:31];
        [referenceLinks setObject:@"http://cordova.apache.org/" forKey:@"Apache Cordova"];
        [referenceLinks setObject:@"http://martinfowler.com/articles/bigQueryPOC.html" forKey:@"BigQuery"];
        [referenceLinks setObject:@"http://openmymind.net/2012/4/4/You-Really-Should-Log-Client-Side-Error/" forKey:@"Client Side Error Logging"];
        [referenceLinks setObject:@"https://github.com/raganwald/homoiconic/blob/master/2011/12/jargon.md" forKey:@"CoffeeScript is not a language worth learning"];
        [referenceLinks setObject:@"http://coffeescript.org/#source-maps" forKey:@"CoffeeScript Source Maps"];
        [referenceLinks setObject:@"https://tech.dropbox.com/2012/09/dropbox-dives-into-coffeescript/" forKey:@"Dropbox dives into CoffeeScript"];
        [referenceLinks setObject:@"http://dropwizard.codahale.com/" forKey:@"DropWizard"];
        [referenceLinks setObject:@"https://github.com/lostisland/faraday" forKey:@"Faraday"];
        [referenceLinks setObject:@"http://graylog2.org/" forKey:@"Graylog2"];
        [referenceLinks setObject:@"http://www.opscode.com/hosted-chef/" forKey:@"Hosted Chef"];
        [referenceLinks setObject:@"http://devblog.pipelinedeals.com/pipelinedeals-dev-blog/2012/2/12/javascript-error-reporting-for-fun-and-profit-1.html" forKey:@"JavaScript error reporting"];
        [referenceLinks setObject:@"http://logstash.net/" forKey:@"Logstash"];
        [referenceLinks setObject:@"http://www.idc.com/getdoc.jsp?containerId=prUS23982813#.UTTAZzCG2TU" forKey:@"Mobile phone Usage"];
        [referenceLinks setObject:@"http://www.mongodb.org/" forKey:@"MongoDB"];
        [referenceLinks setObject:@"http://nancyfx.org/" forKey:@"Nancy Framework"];
        [referenceLinks setObject:@"https://npmjs.org/" forKey:@"NPM"];
        [referenceLinks setObject:@"https://npmjs.org/doc/json.html" forKey:@"NPM Docs"];
        [referenceLinks setObject:@"http://octopusdeploy.com/" forKey:@"Octopus"];
        [referenceLinks setObject:@"http://owin.org" forKey:@"OWIN"];
        [referenceLinks setObject:@"http://phantomjs.org/" forKey:@"PhantomJS"];
        [referenceLinks setObject:@"http://phonegap.com/" forKey:@"PhoneGap"];
        [referenceLinks setObject:@"https://github.com/plans" forKey:@"Plans"];
        [referenceLinks setObject:@"https://rx.codeplex.com/" forKey:@"Reactive Extension"];
        [referenceLinks setObject:@"http://requirejs.org/" forKey:@"RequireJS"];
        [referenceLinks setObject:@"https://snap-ci.com/" forKey:@"SnapCI"];
        [referenceLinks setObject:@"http://martinfowler.com/bliki/SnowflakeServer.html" forKey:@"Snowflake servers"];
        [referenceLinks setObject:@"https://docs.google.com/document/d/1U1RGAehQwRypUTovF1KRlpiOFze0b-_2gc6fAH0KY0k/edit" forKey:@"Source Map Revision 3 Proposal"];
        [referenceLinks setObject:@"http://developer.android.com/tools/help/uiautomator/index.html" forKey:@"UIAutomator"];
        [referenceLinks setObject:@"http://en.wikipedia.org/wiki/Unstructured_Supplementary_Service_Data" forKey:@"USSD"];
        [referenceLinks setObject:@"http://vumi.org/" forKey:@"Vumi"];
        [referenceLinks setObject:@"http://nealford.com/memeagora/2013/01/22/why_everyone_eventually_hates_maven.html" forKey:@"Why Everyone Either Hates or Leaves Maven"];
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