//
//  LoginViewController.h
//  
//
//  Created by Tony  Winslow on 12/3/15.
//
//

#import <UIKit/UIKit.h>

#import "DataStores.h"

@interface LoginViewController : UIViewController

@property (nonatomic, weak) UIWebView *webView;


extern NSString *const LoginViewControllerDidGetAccessTokenNotification;



@end
