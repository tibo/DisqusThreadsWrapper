//
//  DisqusThread.m
//  DisqusWrapperSample
//
//  Created by Thibaut LE LEVIER on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisqusThread.h"
#import "AFJSONRequestOperation.h"

#define GetPostsForThreadLink @"http://disqus.com/api/3.0/threads/listPosts.json?forum=%@&thread%%3Alink=%@&api_key=%@&order=asc"
#define GetPostsForThreadIdent @"http://disqus.com/api/3.0/threads/listPosts.json?forum=%@&thread%%3Aident=%@&api_key=%@&order=asc"
#define GetDetailsForThreadIdent @"https://disqus.com/api/3.0/threads/details.json?forum=%@&thread%3Aident=%@&api_key=%@"

@interface DisqusThread (Private)

-(NSDate *)dateFromISO8601:(NSString *)str;

@end

@implementation DisqusThread

+(void)getPostsForThreadLink:(NSString *)link 
                      withSuccess:(void (^)(NSArray *feedItems))success
                   andFailure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:GetPostsForThreadLink,DSIQUS_FORUM,link,DISQUS_API_KEY];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            NSMutableArray *postsArray = [[NSMutableArray alloc] init];
                                                                                            
                                                                                            [[JSON objectForKey:@"response"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                                                
                                                                                                DisqusThread *post = [[DisqusThread alloc] initWithJSONDictionary:obj];
                                                                                                
                                                                                                [postsArray addObject:post];
                                                                                                
                                                                                            }];
                                                                                            success(postsArray);
                                                                                            
                                                                                        } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }];
    
    [operation start];
}

+(void)getPostsForThreadIdent:(NSString *)ident 
                 withSuccess:(void (^)(NSArray *feedItems))success
                  andFailure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:GetPostsForThreadIdent,DSIQUS_FORUM,ident,DISQUS_API_KEY];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            NSNumber *threadID = [[JSON objectForKey:@"response"] objectForKey:@"id"];
                                                                                            
                                                                                            success(threadID);
                                                                                        } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }];
    
    [operation start];
}

+(void)getThreadIDForThreadIdent:(NSString *)ident 
                  withSuccess:(void (^)(NSNumber *threadID))success
                   andFailure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:GetDetailsForThreadIdent,DSIQUS_FORUM,ident,DISQUS_API_KEY];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:req 
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            
                                                                                            NSMutableArray *postsArray = [[NSMutableArray alloc] init];
                                                                                            
                                                                                            [[JSON objectForKey:@"response"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                                                
                                                                                                DisqusThread *post = [[DisqusThread alloc] initWithJSONDictionary:obj];
                                                                                                
                                                                                                [postsArray addObject:post];
                                                                                                
                                                                                            }];
                                                                                            success(postsArray);
                                                                                            
                                                                                        } 
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            failure(error);
                                                                                        }];
    
    [operation start];
}


@synthesize identifier;
@synthesize parentIdenfier;
@synthesize authorUsername;
@synthesize authorName;
@synthesize authorURL;
@synthesize authorAvatarURL;
@synthesize rawMessage;
@synthesize creationDate;
@synthesize threadId;

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        id obj = [dictionary valueForKey:@"id"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.identifier = [NSNumber numberWithInt:[obj intValue]];
        }
        
        obj = [dictionary valueForKey:@"parent"];
        if (obj && [obj isKindOfClass:[NSNumber class]]) {
            self.parentIdenfier = obj;
        }
        
        obj = [dictionary valueForKey:@"author"];
        if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            
            id authorObj = [obj valueForKey:@"username"];
            if (authorObj && [authorObj isKindOfClass:[NSString class]]) {
                self.authorUsername = authorObj;
            }
            
            authorObj = [obj valueForKey:@"name"];
            if (authorObj && [authorObj isKindOfClass:[NSString class]]) {
                self.authorName = authorObj;
            }
            
            authorObj = [obj valueForKey:@"url"];
            if (authorObj && [authorObj isKindOfClass:[NSString class]]) {
                self.authorURL = [NSURL URLWithString:authorObj];
            }
            
            authorObj = [obj valueForKey:@"avatar"];
            if (authorObj && [authorObj isKindOfClass:[NSDictionary class]]) {
                self.authorAvatarURL = [NSURL URLWithString:[authorObj valueForKey:@"permalink"]];
            }
        }
        
        obj = [dictionary valueForKey:@"raw_message"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.rawMessage = obj;
        }
        
        obj = [dictionary valueForKey:@"createdAt"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.creationDate = [self dateFromISO8601:obj];
        }
        
        obj = [dictionary valueForKey:@"thread"];
        if (obj && [obj isKindOfClass:[NSNumber class]]) {
            self.threadId = obj;
        }
        
        
        
    }
    return self;
}

-(NSDate *)dateFromISO8601:(NSString *)str 
{
    NSDateFormatter* sISO8601 = [[NSDateFormatter alloc] init];
    [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
    [sISO8601 setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    NSDate *d = [sISO8601 dateFromString:str];
    return d;
    
}


@end
