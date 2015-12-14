//
//  MediaFullScreenViewController.m
//  
//
//  Created by Tony  Winslow on 12/13/15.
//
//

#import "MediaFullScreenViewController.h"
#import "MediaPlay.h"


@interface MediaFullScreenViewController () <UIScrollViewDelegate>


@property (nonatomic, strong) MediaPlay *media;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UINavigationBar *shareBar;

@end

@implementation MediaFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    // #2
    self.imageView = [UIImageView new];
    self.imageView.image = self.media.image;
    
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:_shareButton];
    

//    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_shareButton addTarget:self action:@selector(:) forControlEvents:UIControlEventTouchUpInside];
//    [_shareButton setTitle:@"Share" forState:UIControlStateNormal];
//    _shareButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    [self.view addSubview:_shareButton];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Flip"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    self.shareBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    
    [self.view addSubview:self.shareBar];

     _shareButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Flip"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    
    // #3
    self.scrollView.contentSize = self.media.image.size;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
    
    self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapFired:)];
    self.doubleTap.numberOfTapsRequired = 2;
    
    [self.tap requireGestureRecognizerToFail:self.doubleTap];
    
    [self.scrollView addGestureRecognizer:self.tap];
    [self.scrollView addGestureRecognizer:self.doubleTap];
}

-(void)shareAction:(id)sender {
    
    NSLog(@"Action gets called.");
    
}

#pragma mark - Button for sharing

//- (void)addShareButtonWithTitle:(NSString *)title {
//    
//    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [shareButton setTitle:NSLocalizedString(@"Share", @"share button") forState:UIControlStateNormal];
//    [shareButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//    shareButton.backgroundColor = [UIColor whiteColor];
//    [shareButton sizeToFit];
//    [shareButton setFrame:CGRectMake(self.imageView.image.size.width - shareButton.frame.size.width - 10, shareButton.frame.size.height, shareButton.frame.size.width, shareButton.frame.size.height)];
//    [self.imageView addSubview:self.shareButton];
//}

//- (void)shareAction {
//    
//    [_media  ];
//}



#pragma mark - Gesture Recognizers

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) doubleTapFired:(UITapGestureRecognizer *)sender {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        // #8
        CGPoint locationPoint = [sender locationInView:self.imageView];
        
        CGSize scrollViewSize = self.scrollView.bounds.size;
        
        CGFloat width = scrollViewSize.width / self.scrollView.maximumZoomScale;
        CGFloat height = scrollViewSize.height / self.scrollView.maximumZoomScale;
        CGFloat x = locationPoint.x - (width / 2);
        CGFloat y = locationPoint.y - (height / 2);
        
        [self.scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
    } else {
        // #9
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // #4
    self.scrollView.frame = self.view.bounds;
    
    // #5
    CGSize scrollViewFrameSize = self.scrollView.frame.size;
    CGSize scrollViewContentSize = self.scrollView.contentSize;
    
    CGFloat scaleWidth = scrollViewFrameSize.width / scrollViewContentSize.width;
    CGFloat scaleHeight = scrollViewFrameSize.height / scrollViewContentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1;

}

- (void)centerScrollView {
    [self.imageView sizeToFit];
    
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - CGRectGetWidth(contentsFrame)) / 2;
    } else {
        contentsFrame.origin.x = 0;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - CGRectGetHeight(contentsFrame)) / 2;
    } else {
        contentsFrame.origin.y = 0;
    }
    
    self.imageView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate
// #6
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self centerScrollView];
}

// #7
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype) initWithMedia:(MediaPlay*)media {
    self = [super init];
    
    if (self) {
        self.media = media;
    }
    
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
