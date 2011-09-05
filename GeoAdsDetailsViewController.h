//
//  GeoAdsDetailsViewController.h
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/19/10.
//  Copyright 2010 Viewlity.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeoAdsDetailsViewController : UIViewController <UIWebViewDelegate>
{
    NSURL *geoAdURL;
    
    UIWebView *geoAdWebView;
    UIActivityIndicatorView *webViewActivityIndicator;
    UIButton *closeButton;
}

@property (nonatomic, retain) NSURL *geoAdURL;
@property (nonatomic, retain) IBOutlet UIWebView *geoAdWebView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *webViewActivityIndicator;
@property (nonatomic, retain) IBOutlet UIButton *closeButton;

- (IBAction)closeModalViewController:(id)sender;

@end
