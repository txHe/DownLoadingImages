###多线程下载图片

学习多线程时，顺便使用下多线程来下载图片。如果在主线程下载，页面当然会卡住，多线程实现异步下载，就OK了，很简单。

主要就是在NSURLSession 中downloadTaskWithRequest实现下载，在block中，加入多线程。

核心代码如下：
	
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

####初始界面：![image](https://github.com/txHe/DownLoadingImages/blob/master/Images-Folder/001.png)

####滚动视图显示界面：

![image](https://github.com/txHe/DownLoadingImages/blob/master/Images-Folder/002.png)
![image](https://github.com/txHe/DownLoadingImages/blob/master/Images-Folder/003.png)
![image](https://github.com/txHe/DownLoadingImages/blob/master/Images-Folder/004.png)

