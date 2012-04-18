//
//  DisqusThread.h
//  DisqusWrapperSample
//
//  Created by Thibaut LE LEVIER on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisqusThread : NSObject

// service method
+(void)getPostsForThreadLink:(NSString *)link 
                  withSuccess:(void (^)(NSArray *feedItems))success
                   andFailure:(void (^)(NSError *error))failure;

// atributs

/*
 isJuliaFlagged": true,
 "isFlagged": false,
 "forum": "therudebaguette",
 "parent": null,
 "author": {
     "name": "Tonytigre",
     "url": "",
     "profileUrl": "http://disqus.com/guest/3dfbda4113bea5c1c49b7ec62e56ef44/",
     "emailHash": "3dfbda4113bea5c1c49b7ec62e56ef44",
     "avatar": {
         "permalink": "http://www.gravatar.com/avatar.php?gravatar_id=3dfbda4113bea5c1c49b7ec62e56ef44&size=32&default=http://mediacdn.disqus.com/1334693674/images/noavatar32.png",
         "cache": "http://www.gravatar.com/avatar.php?gravatar_id=3dfbda4113bea5c1c49b7ec62e56ef44&size=32&default=http://mediacdn.disqus.com/1334693674/images/noavatar32.png"
    },
     "isAnonymous": true
},
 "media": [],
 "isDeleted": false,
 "isApproved": true,
 "dislikes": 0,
 "raw_message": "Viadeo is the Enron of social networks and Dan Serfaty is the Madoff of social networks. They make up their figures - look at Hitwise, Google trends anything and they have no traffic outside of France. Even Tianji is nowhere in China. Do these investors do no due diligence. If I was a French taxpayer I would be livid at the waste of the Sovereign Fund's money!",
 "createdAt": "2012-04-15T10:25:22",
 "id": "498119443",
 "thread": "647819608",
 "numReports": 0,
 "likes": 0,
 "isEdited": false,
 "points": 0,
 "message": "<p>Viadeo is the Enron of social networks and Dan Serfaty is the Madoff of social networks. They make up their figures - look at Hitwise, Google trends anything and they have no traffic outside of France. Even Tianji is nowhere in China. Do these investors do no due diligence. If I was a French taxpayer I would be livid at the waste of the Sovereign Fund's money!</p>",
 "isSpam": false,
 "isHighlighted": false,
 "userScore": 0
 */

@property (retain, nonatomic) NSNumber *identifier;
@property (retain, nonatomic) NSNumber *parentIdenfier;
@property (retain, nonatomic) NSString *authorUsername;
@property (retain, nonatomic) NSString *authorName;
@property (retain, nonatomic) NSURL *authorURL;
@property (retain, nonatomic) NSURL *authorAvatarURL;
@property (retain, nonatomic) NSString *rawMessage;
@property (retain, nonatomic) NSDate *creationDate;

// init
- (id)initWithJSONDictionary:(NSDictionary *)dictionary;

@end
