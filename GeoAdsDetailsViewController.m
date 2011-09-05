//
//  GeoAdsDetailsViewController.m
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/19/10.
//  Copyright 2010 Viewlity.com. All rights reserved.
//

#import "GeoAdsDetailsViewController.h"

@implementation GeoAdsDetailsViewController

@synthesize geoAdURL;
@synthesize geoAdWebView, webViewActivityIndicator;
@synthesize closeButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    
    // The web view is initialized in the XIB file.
    geoAdWebView.delegate = self;
    geoAdWebView.scalesPageToFit = YES;
    geoAdWebView.multipleTouchEnabled = YES;
    geoAdWebView.hidden = NO;
    
    // The activity indicator is initialized in the XIB file.
    webViewActivityIndicator.hidesWhenStopped = YES;
    webViewActivityIndicator.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
    
    // Clear web view previous content.
    [geoAdWebView stringByEvaluatingJavaScriptFromString:@"document.open();document.close();"];
    
    [webViewActivityIndicator startAnimating];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:geoAdURL];
    [geoAdWebView loadRequest:requestObj];
}

- (void)dealloc 
{
    [geoAdURL release];
    [geoAdWebView release];
    [webViewActivityIndicator release];
    [closeButton release];
    [super dealloc];
}

/* 
// Uncomment this method to enable auto-rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    return YES;
}
*/

#pragma mark UIWebView Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webViewActivityIndicator stopAnimating];    
}

- (IBAction)closeModalViewController:(id)sender
{
    [webViewActivityIndicator stopAnimating];
    [self dismissModalViewControllerAnimated:YES];
}

@end
