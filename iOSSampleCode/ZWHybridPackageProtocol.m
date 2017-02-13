//
//  ZWHybridPackageProtocol.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/29.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWHybridPackageProtocol.h"
#import "ZWHybridPackageFileManager.h"

static NSString *const HybridResourceProtocolKey = @"HybridResourceProtocolKey";

@interface ZWHybridPackageProtocol ()<NSURLConnectionDataDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>

//@property (nonatomic, strong)NSURLConnection *connection;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ZWHybridPackageProtocol

/**
 *  @author 钟武, 16-06-29 18:06:47
 *
 *  @brief 如果返回NO，则request会进入默认的URL Loading System进行处理
 *
 *  @param request
 *
 *  @return
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    if ([NSURLProtocol propertyForKey:HybridResourceProtocolKey inRequest:request]) {
        return NO;
    }
    return [ZWHybridPackageFileManager hasPackageWithURL:request.URL];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    NSData *data = [ZWHybridPackageFileManager dataWithURL:self.request.URL];
    
    if (data) {
        NSMutableDictionary *header = [[NSMutableDictionary alloc] initWithCapacity:2];
        NSString *contentType = @"text/HTML;charset=UTF-8";
        header[@"Content-Type"] = contentType;
        header[@"Content-Length"] = [NSString stringWithFormat:@"%lu",(unsigned long)data.length];
        
        NSHTTPURLResponse *httpResponse = [[NSHTTPURLResponse alloc] initWithURL:self.request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:header];
        
        
        [self.client URLProtocol:self didReceiveResponse:httpResponse cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else
    {
        NSMutableURLRequest *newRequest = [self.request mutableCopy];
        newRequest.allHTTPHeaderFields = self.request.allHTTPHeaderFields;
        
        [NSURLProtocol setProperty:@YES forKey:HybridResourceProtocolKey inRequest:newRequest];

        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        self.task = [self.session dataTaskWithRequest:newRequest];
        [self.task resume];

        //使用NSURLSession替换NSURLConnection
//        self.connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
    }
}

- (void)stopLoading
{
//    [self.connection cancel];
    [self.task cancel];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        [self.client URLProtocol:self didFailWithError:error];
    }
    else
        [self.client URLProtocolDidFinishLoading:self];
}

#pragma mark - Dealloc

- (void)dealloc{
    [self.session invalidateAndCancel];
}

@end
