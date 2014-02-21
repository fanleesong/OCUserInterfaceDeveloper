//
//  HTTPMessageManager.m
//  DemoProject
//
//  Created by administrator on 13-11-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "HTTPMessageManager.h"
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Comment.h"
#import "MyComment.h"

static HTTPMessageManager *instance = nil;

@implementation HTTPMessageManager
@synthesize accessToken;

- (id)init{
    if(self = [super init]){
        requestQueue = [[ASINetworkQueue alloc] init];
        requestQueue.delegate = self;
        [requestQueue setRequestDidFailSelector:@selector(requestFailed:)];
        [requestQueue setRequestDidFinishSelector:@selector(requestFinished:)];
        [requestQueue setShouldCancelAllRequestsOnFailure:NO];
        [self start];
    }
    return self;
}

+ (HTTPMessageManager*)getInstance{
    @synchronized(self) {
        if(instance == nil){
            instance = [[HTTPMessageManager alloc] init];
        }
    }
    return instance;
}

#pragma mark - Methods

- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(RequestType)requestType{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSNumber numberWithInt:requestType] forKey:REQUEST_TYPE];
    [request setUserInfo:dic];
    [dic release];
}

- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(RequestType)requestType{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSNumber numberWithInt:requestType] forKey:REQUEST_TYPE];
    [request setUserInfo:dic];
    [dic release];
}

- (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params{
    if(params){
        NSMutableArray *pairs = [NSMutableArray array];
        for(NSString *key in params.keyEnumerator){
            NSString *value = [params valueForKey:key];
            NSString *escaped_value = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)value, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
            [escaped_value release];     //?????
        }
        NSString *query = [pairs componentsJoinedByString:@"&"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", baseURL, query]];
        return url;
    }else{
        return [NSURL URLWithString:baseURL];
    }
}

#pragma mark - HTTP Operate

- (NSURL*)getOauthCodeUrl{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:nil];
    NSURL *url = [self generateURL:API_AUTHORIZE params:params];
    return url;
}

- (void)getUserInfo{
    RequestType requestType = GetUserProfileInfo;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/users/profile.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"userProfile = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getHotHomePageInfo{
    RequestType requestType = GetHotHomePageInfo;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/hot.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"HotHomePageInfo = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getNewsHomePageInfo{
    RequestType requestType = GetNewsHomePageInfo;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/v2/r/news.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"NewsHomePageInfo = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getScoffHomePageInfo{
    RequestType requestType = GetScoffHomePageInfo;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/v2/r/scoff.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"ScoffHomePageInfo = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getPicHomePageInfo{
    RequestType requestType = GetPicHomePageInfo;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/v2/r/pic.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"PicHomePageInfo = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getTecHomePageInfo{
    RequestType requestType = GetTecHomePageInfo;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/v2/r/tec.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"TecHomePageInfo = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getAskHomePageInfo{
    RequestType requestType = GetAskHomePageInfo;
     self.accessToken = USER_STORE_ACCESS_TOKEN;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/v2/r/ask.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"AskHomePageInfo = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getCommentList:(NSNumber*)linkId{
    NSMutableDictionary *params;
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@", linkId], @"link_id", accessToken, @"access_token", nil];
    RequestType requestType = GetCommentsListIds;
    NSString *baseUrl = [NSString stringWithFormat:@"%@/comments_tree.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"CommentIdsUrl = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getRealComments:(NSArray*)ids{
    NSMutableDictionary *params;
    NSString *idStr = [ids componentsJoinedByString:@","];
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    params = [NSMutableDictionary dictionaryWithObjectsAndKeys:idStr, @"ids", accessToken, @"access_token", nil];
    RequestType requestType = GetCommentsList;
    NSString *baseUrl = [NSString stringWithFormat:@"%@/comments/batch.json",URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"CommentListUrl = %@",baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getMyPublishList{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = GetMyPublishList;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/users/publish.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"myPublishListUrl = %@", baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getMyCommentsList{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = GetMyCommentsList;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/users/comments.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"myCommentsListUrl = %@", baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getMySavedList{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = GetMySaveList;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/users/save.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"mySaveListUrl = %@", baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)getMyRecommendList{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = GetMySaveList;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
    NSString *baseUrl = [NSString stringWithFormat:@"%@/users/liked.json", URL_DOMAIN];
    NSURL *url = [self generateURL:baseUrl params:params];
    NSLog(@"myLikedListUrl = %@", baseUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:url];
    [self setGetUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)postUpMessage:(NSNumber*)linkId{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = UpTrend;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/links/up.json", URL_DOMAIN]];
    NSLog(@"upurl=====%@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%@", linkId] forKey:@"link_id"];
    [request setPostValue:accessToken forKey:@"access_token"];
    
    [self setPostUserInfo:request withRequestType:requestType];
    
    [requestQueue addOperation:request];
    [request release];
}

- (void)postCancelUpMessage:(NSNumber*)linkId{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = CancelUpTrend;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/links/removeup.json",URL_DOMAIN]];
    NSLog(@"cancelupurl=======%@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%@",linkId] forKey:@"link_id"];
    [request setPostValue:accessToken forKey:@"access_token"];
    
    [self setPostUserInfo:request withRequestType:requestType];
    
    [requestQueue addOperation:request];
    [request release];
}

- (void)postSaveMessage:(NSNumber*)linkId{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = SaveTrend;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/save/add.json", URL_DOMAIN]];
    NSLog(@"saveurl=====%@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%@", linkId] forKey:@"ids"];
    [request setPostValue:accessToken forKey:@"access_token"];
    [self setPostUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)postCancelSaveMessage:(NSNumber*)linkId{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = CancelSaveTrend;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/save/del.json", URL_DOMAIN]];
    NSLog(@"cancelsaveurl========%@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%@", linkId] forKey:@"ids"];
    [request setPostValue:accessToken forKey:@"access_token"];
    [self setPostUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)postUpOrDownComment:(NSNumber*)commentId andVote:(NSNumber*)vote{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = UpOrDownComment;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/comments/vote.json", URL_DOMAIN]];
    NSLog(@"postUpOrDownmComment = %@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%@", commentId] forKey:@"id"];
    [request setPostValue:[NSString stringWithFormat:@"%@", vote] forKey:@"vote"];
    [request setPostValue:accessToken forKey:@"access_token"];
    [self setPostUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)postResponseToMessage:(NSNumber*)messageId andParentId:(NSNumber*)parentId andContent:(NSString*)content{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = ResponseComment;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/comments/create.json", URL_DOMAIN]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%@", messageId] forKey:@"id"];
    [request setPostValue:[NSString stringWithFormat:@"%@", content] forKey:@"content"];
    [request setPostValue:[NSString stringWithFormat:@"%@", parentId] forKey:@"parent_id"];
    [request setPostValue:accessToken forKey:@"access_token"];
    [self setPostUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)postTextMessage:(NSString*)title{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = PostText;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/r/scoff/create.json", URL_DOMAIN]];
    NSLog(@"publishText===========%@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:@"2" forKey:@"id"];
    [request setPostValue:title forKey:@"title"];
    [request setPostValue:accessToken forKey:@"access_token"];
    [self setPostUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

- (void)postPicMessage:(NSData*)data andText:(NSString*)text{
    self.accessToken = USER_STORE_ACCESS_TOKEN;
    RequestType requestType = PostImage;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/r/pic/create.json", URL_DOMAIN]];
    NSLog(@"publishImage===========%@",url);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:@"4" forKey:@"id"];
    [request setPostValue:text forKey:@"title"];
    [request setPostValue:data forKey:@"pic"];
    [request setPostValue:accessToken forKey:@"access_token"];
    [self setPostUserInfo:request withRequestType:requestType];
    [requestQueue addOperation:request];
    [request release];
}

#pragma mark - Operate Queue

- (BOOL)isRunning
{
	return ![requestQueue isSuspended];
}

- (void)start
{
	if( [requestQueue isSuspended] )
		[requestQueue go];
}

- (void)pause
{
	[requestQueue setSuspended:YES];
}

- (void)resume
{
	[requestQueue setSuspended:NO];
}

- (void)cancel
{
	[requestQueue cancelAllOperations];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"requestFailed:%@,%@,",request.responseString,[request.error localizedDescription]);
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *userInfomation = [request userInfo];
    RequestType requestType = [[userInfomation objectForKey:REQUEST_TYPE] intValue];
    NSData *responseData = [request responseData];
    // 获取各模块主页面信息
    if(requestType == GetHotHomePageInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *statusArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *links = [responseDic objectForKey:@"links"];
        for(id item in links){
            Status *status = [Status StatusWithJSONDictionary:item];
            [statusArr addObject:status];
        }
        [self didGetHotHomePageInfo:statusArr];
        [statusArr release];
    }
    if(requestType == GetNewsHomePageInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *statusArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *links = [responseDic objectForKey:@"links"];
        for(id item in links){
            Status *status = [Status StatusWithJSONDictionary:item];
            [statusArr addObject:status];
        }
        [self didGetNewsHomePageInfo:statusArr];
        [statusArr release];
    }
    if(requestType == GetScoffHomePageInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *statusArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *links = [responseDic objectForKey:@"links"];
        for(id item in links){
            Status *status = [Status StatusWithJSONDictionary:item];
            [statusArr addObject:status];
        }
        [self didGetScoffHomePageInfo:statusArr];
        [statusArr release];
    }
    if(requestType == GetUserProfileInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        [self didGetUserInfo:responseDic];
    }
    if(requestType == GetPicHomePageInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *statusArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *links = [responseDic objectForKey:@"links"];
        for(id item in links){
            Status *status = [Status StatusWithJSONDictionary:item];
            [statusArr addObject:status];
        }
        [self didGetPicHomePageInfo:statusArr];
        [statusArr release];
    }
    if(requestType == GetTecHomePageInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *statusArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *links = [responseDic objectForKey:@"links"];
        for(id item in links){
            Status *status = [Status StatusWithJSONDictionary:item];
            [statusArr addObject:status];
        }
        [self didGetTecHomePageInfo:statusArr];
        [statusArr release];
    }
    if(requestType == GetAskHomePageInfo){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *statusArr = [[NSMutableArray alloc]initWithCapacity:0];
        NSArray *links = [responseDic objectForKey:@"links"];
        for(id item in links){
            Status *status = [Status StatusWithJSONDictionary:item];
            [statusArr addObject:status];
        }
        [self didGetAskHomePageInfo:statusArr];
        [statusArr release];
    }
    // 获取某条信息评论者的id
    if(requestType == GetCommentsListIds){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSDictionary *idsDic = [responseDic objectForKey:@"comments"];
        NSArray *ids = [idsDic objectForKey:@"ids"];
        [self didGetCommentList:ids];
    }
    // 获取某条信息的具体评论
    if(requestType == GetCommentsList){
        NSArray *responseArr = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSMutableArray *commentArr = [[NSMutableArray alloc]initWithCapacity:0];
        for(id item in responseArr){
            Comment *comment = [Comment CommentWithJSONDictionary:item];
            [commentArr addObject:comment];
        }
        [self didGetRealComments:commentArr];
        [commentArr release];
    }
    // 获取登录用户发布过的内容
    if(requestType == GetMyPublishList){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSArray *publishList = [responseDic objectForKey:@"links"];
        NSMutableArray *publishArr = [[NSMutableArray alloc]initWithCapacity:0];
        for(id item in publishList){
            Status *status = [Status StatusWithJSONDictionary:item];
            [publishArr addObject:status];
        }
        [self didGetMyPublishList:publishArr];
    }
    // 获取用户评论的内容
    if(requestType == GetMyCommentsList){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSArray *commentsList = [responseDic objectForKey:@"comments"];
        NSMutableArray *commentsArr = [[NSMutableArray alloc]initWithCapacity:0];
        for(id item in commentsList){
            MyComment *myComment = [MyComment CommentWithJSONDictionary:item];
            [commentsArr addObject:myComment];
        }
        [self didGetMyCommentsList:commentsArr];
    }
    // 获取用户私藏的内容
    if(requestType == GetMySaveList){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSArray *saveList = [responseDic objectForKey:@"links"];
        NSMutableArray *saveArr = [[NSMutableArray alloc]initWithCapacity:0];
        for(id item in saveList){
            Status *status = [Status StatusWithJSONDictionary:item];
            [saveArr addObject:status];
        }
        [self didGetMySaveList:saveArr];
    }
    // 获取用户推荐的内容
    if(requestType == GetMyRecommentList){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSArray *recommendList = [responseDic objectForKey:@"links"];
        NSMutableArray *recommendArr = [[NSMutableArray alloc]initWithCapacity:0];
        for(id item in recommendList){
            Status *status = [Status StatusWithJSONDictionary:item];
            [recommendArr addObject:status];
        }
        [self didGetMyRecommendList:recommendArr];
    }
    // 赞某条信息
    if(requestType == UpTrend){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSNumber *ups = [[responseDic objectForKey:@"ups"] retain];
        [self didPostUpMessage:ups];
        [ups release];
    }
    // 取消赞某条信息
    if(requestType == CancelUpTrend){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSNumber *ups = [[responseDic objectForKey:@"ups"] retain];
        [self didPostCancelUpMessage:ups];
        [ups release];
    }
    // 私藏某条信息
    if(requestType == SaveTrend){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSNumber *ids = [[responseDic objectForKey:@"ids"] retain];
        [self didPostSaveMessage:ids];
        [ids release];
    }
    // 取消私藏某条信息
    if(requestType == CancelSaveTrend){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        NSNumber *ids = [[responseDic objectForKey:@"ids"] retain];
        [self didPostCancelSaveMessage:ids];
        [ids release];
    }
    // 踩或顶某条评论
    if(requestType == UpOrDownComment){
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        [self didPostUpOrDownComment:responseDic];
    }
    // 对某条消息进行评论或回复某条评论
    if(requestType == ResponseComment){
        NSDictionary *commentDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        [self didPostResponseToMessage:commentDic];
    }
    // 发布文字信息
    if(requestType == PostText){
        NSDictionary *mainDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        [self didPostTextMessage:mainDic];
    }
    // 发布图片信息
    if(requestType == PostImage){
        NSDictionary *mainDic = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        [self didPostPicMessage:mainDic];
    }
}

#pragma mark - AfterGetMessages

- (void)didGetUserInfo:(NSDictionary*)infoDic{
    if(infoDic == nil){
        return;
    }
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[infoDic objectForKey:@"comments_count"],@"commentsCount",[infoDic objectForKey:@"liked_count"],@"likedCount",[infoDic objectForKey:@"save_count"],@"saveCount",[infoDic objectForKey:@"submitted_count"],@"submittedCount", nil];
    NSNotification *notification = [NSNotification notificationWithName:GotUserInfo object:dic];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    [dic release];
}

- (void)didGetHotHomePageInfo:(NSArray*)statusArray{
    if(statusArray == nil || [statusArray count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotHotHomePageInfo object:statusArray];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetNewsHomePageInfo:(NSArray*)statusArray{
    if(statusArray == nil || [statusArray count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotNewsHomePageInfo object:statusArray];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetScoffHomePageInfo:(NSArray*)statusArray{
    if(statusArray == nil || [statusArray count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotScoffHomePageInfo object:statusArray];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetPicHomePageInfo:(NSArray*)statusArray{
    if(statusArray == nil || [statusArray count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotPicHomePageInfo object:statusArray];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetTecHomePageInfo:(NSArray*)statusArray{
    if(statusArray == nil || [statusArray count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotTecHomePageInfo object:statusArray];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetAskHomePageInfo:(NSArray*)statusArray{
    if(statusArray == nil || [statusArray count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotAskHomePageInfo object:statusArray];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetCommentList:(NSArray*)commentsIdsArr{
    if(commentsIdsArr == nil || [commentsIdsArr count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotCommentlistIds object:commentsIdsArr];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetRealComments:(NSArray*)commentsArr{
    if(commentsArr == nil || [commentsArr count] == 0){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotCommentList object:commentsArr];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetMyPublishList:(NSArray*)publishList{
    if(publishList == nil){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotMyPublishList object:publishList];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetMyCommentsList:(NSArray*)commentsList{
    if(commentsList == nil){
        return;
    }
    NSLog(@"comments==========%@", commentsList);
    NSNotification *notification = [NSNotification notificationWithName:GotMyCommentsList object:commentsList];
    [[NSNotificationCenter defaultCenter]postNotification: notification];
}

- (void)didGetMySaveList:(NSArray*)savedList{
    if(savedList == nil){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotMySaveList object:savedList];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didGetMyRecommendList:(NSArray*)recommendList{
    if(recommendList == nil){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:GotMyRecommentList object:recommendList];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostUpMessage:(NSNumber*)upsCount{
    if(upsCount == nil){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:PostUpMessage object:upsCount];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostCancelUpMessage:(NSNumber*)upsCount{
    if(upsCount == nil){
        return;
    }
    NSNotification *notification = [NSNotification notificationWithName:PostCancelUpMessage object:upsCount];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostSaveMessage:(NSNumber*)ids{
    NSNotification *notification = [NSNotification notificationWithName:PostSaveMessage object:ids];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostCancelSaveMessage:(NSNumber*)ids{
    NSNotification *notification = [NSNotification notificationWithName:PostCancelSaveMessage object:ids];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostUpOrDownComment:(NSDictionary*)responseDic{
    NSNotification *notification = [NSNotification notificationWithName:PostUpOrDownComment object:responseDic];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostResponseToMessage:(NSDictionary*)commentDic{
    NSDictionary *mainDic = [commentDic objectForKey:@"comment"];
    NSNotification *notification = [NSNotification notificationWithName:PostResponseToMessage object:mainDic];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
}

- (void)didPostTextMessage:(NSDictionary*)responseDic{
    NSLog(@"=======publish text %@", responseDic);
}

- (void)didPostPicMessage:(NSDictionary*)responseDic{
    NSLog(@"=======punlish pic %@", responseDic);
}

@end
