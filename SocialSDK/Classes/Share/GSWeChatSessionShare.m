
//
//  GSWeChatSessionShare.m
//  SocialSDKDemo
//
//  Created by lvjialin on 2016/12/20.
//  Copyright © 2016年 GagSquad. All rights reserved.
//

#import "GSWeChatSessionShare.h"
#import "WXApi.h"

@interface GSWeChatSessionShare ()<WXApiDelegate>

@end

@implementation GSWeChatSessionShare

+ (void)load
{
    [[GSShareManager share] addChannelWithChannelType:[GSWeChatSessionShare channelType] channel:[GSWeChatSessionShare class]];
}

+ (GSPlatformType)platformType
{
    return GSPlatformTypeWeChat;
}

+ (GSShareChannelType)channelType;
{
    return GSShareChannelTypeWechatSession;
}

- (void)shareSimpleText:(NSString *)text
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.scene = WXSceneSession;
    req.text = text;
    [WXApi sendReq:req];
}

- (void)shareSingleImage:(id)image title:(NSString *)title description:(NSString *)description
{
    WXImageObject *ext = [WXImageObject object];
    if ([image isKindOfClass:[NSData class]]) {
        ext.imageData = image;
    } else if ([image isKindOfClass:[UIImage class]]) {
        ext.imageData = UIImagePNGRepresentation(image);
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = ext;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = WXSceneSession;
    req.message = message;
    [WXApi sendReq:req];
}

- (void)shareURL:(NSString *)url title:(NSString *)title description:(NSString *)description thumbnail:(id)thumbnail
{
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = ext;
    
    if ([thumbnail isKindOfClass:[NSData class]]) {
        message.thumbData = thumbnail;
    } else if ([thumbnail isKindOfClass:[UIImage class]]) {
        message.thumbData = UIImagePNGRepresentation(thumbnail);
    }
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = WXSceneSession;
    req.message = message;
    [WXApi sendReq:req];
}

- (void)onResp:(BaseResp *)resp
{
    [self completionWithResult:[self createResultWithResponse:resp]];
}

- (id<GSShareResultProtocol>)createResultWithResponse:(BaseResp *)response
{
    int errCode = response.errCode;
    GSShareResult *res = [[GSShareResult alloc] init];
    res.sourceCode = errCode;
    res.soucreMessage = @"";
    res.status = GSShareResultStatusFailing;
    switch (errCode) {
        case 0: {
            res.status = GSShareResultStatusSuccess;
            break;
        }
        case -2: {
            res.status = GSShareResultStatusCancel;
            break;
        }
        default:
            break;
    }
    return res;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}
@end
