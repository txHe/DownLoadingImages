//
//  ViewController.m
//  DownLoadingImages
//
//  Created by zhhz on 15/6/6.
//  Copyright (c) 2015年 zhhz. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
@interface ViewController ()

@end

@implementation ViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        //NSLog(@"%@",segue.identifier);
        if ([segue.identifier isEqual: @"First_Image"])
        {
            ivc.imageURL = [NSURL URLWithString:@"http://f1.vkofs.xinyou.com/27694c/albums/9ba80/image.jpg"];
        }
        else if ([segue.identifier isEqualToString: @"Second_Image"])
        {
            ivc.imageURL = [NSURL URLWithString:@"http://pic1.bbzhi.com/dongwubizhi/labuladuoxunhuiquanbizhi/animal_labrador_retriever_1600x1200_44205_2.jpg"];
        }
        else
        {
            ivc.imageURL = [NSURL URLWithString:@"http://www.fiito.com/thumb/s/-hKrPwC94J.jpg"];
        }
        ivc.title = segue.identifier;
    }
}
@end
