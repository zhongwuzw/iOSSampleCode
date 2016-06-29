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

@interface ZWHybridPackageProtocol ()<NSURLConnectionDataDelegate>

@property (nonatomic, strong)NSURLConnection *connection;

@end

@implementation ZWHybridPackageProtocol

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
        
        self.connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
    }
}

- (void)stopLoading
{
    [self.connection cancel];
}

#pragma mark -NSURLConnectionDelegate

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

@end
