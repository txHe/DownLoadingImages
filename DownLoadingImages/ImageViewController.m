//
//  ImageViewController.m
//  DownLoadingImages
//
//  Created by zhhz on 15/6/6.
//  Copyright (c) 2015年 zhhz. All rights reserved.
//

#import "ImageViewController.h"
@interface ImageViewController()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImage *image;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController

-(void)setScrollview:(UIScrollView *)scrollview
{
    _scrollview = scrollview;
    _scrollview.minimumZoomScale = 0.2;
    _scrollview.maximumZoomScale = 2.0;
    _scrollview.delegate = self;
    
    self.scrollview.contentSize = self.image? self.image.size:CGSizeZero;

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;
}

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    //self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownloadingImage];
}

-(void)startDownloadingImage
{
    self.image = nil; //在下载时清除图像
    if (self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];//后台会话设置
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
            if (!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{self.image = image;});
                }
            }
        }];
        [task resume]; //不设置，task会被挂起。
    }
    
}
//延迟实例化
-(UIImageView *)imageView
{
    if(!_imageView)
        _imageView = [[UIImageView alloc] init];
    
    return _imageView;
}

-(UIImage *)image
{
    return  self.imageView.image;
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image =  image;
    [self.imageView sizeToFit];
    self.scrollview.contentSize = self.image? self.image.size:CGSizeZero;
    [self.spinner stopAnimating];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self.view addSubview:self.imageView];
    [self.scrollview addSubview:self.imageView];
}

@end
