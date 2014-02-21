//
//  SinaUser.m
//  ChouTi
//
//  Created by zj on 13-11-10.
//
//

#import "SinaUser.h"
#import "StringUtil.h"

@implementation SinaUser

@synthesize userId;
@synthesize screenName;
@synthesize name;
@synthesize province;
@synthesize city;
@synthesize location;
@synthesize description;
@synthesize url;
@synthesize profileImageUrl;
@synthesize profileLargeImageUrl;
@synthesize domain;
@synthesize gender;
@synthesize statusesCount;
@synthesize favoritesCount;
@synthesize createdAt;
//@synthesize verified;
@synthesize allowAllActMsg;
@synthesize geoEnabled;
@synthesize userKey;
@synthesize avatarImage;


- (SinaUser*)initWithJsonDictionary:(NSDictionary*)dic
{
	self = [super init];
    
    [self updateWithJSonDictionary:dic];
	
	return self;
}

- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    self.avatarImage = nil;
	[userKey release];
    [screenName release];
    [name release];
	[province release];
	[city release];
    [location release];
    [description release];
    [url release];
    [profileImageUrl release];
	[domain release];
    
    userId          = [[dic objectForKey:@"id"] longLongValue];
    userKey			= [[NSNumber alloc] initWithLongLong:userId];
	screenName      = [dic objectForKey:@"screen_name"];
    name            = [dic objectForKey:@"name"];
	
	//int provinceId = [[dic objectForKey:@"province"] intValue];
	//int cityId = [[dic objectForKey:@"city"] intValue];
	province		= @"";
	city			= @"";
	
	location        = [dic objectForKey:@"location"];
	description     = [dic objectForKey:@"description"];
	url             = [dic objectForKey:@"url"];
    profileImageUrl = [dic objectForKey:@"profile_image_url"];
	domain			= [dic objectForKey:@"domain"];
	
	NSString *genderChar = [dic objectForKey:@"gender"];
	if ([genderChar isEqualToString:@"m"]) {
		gender = GenderMale;
	}
	else if ([genderChar isEqualToString:@"f"]) {
		gender = GenderFemale;
	}
	else {
		gender = GenderUnknow;
	}
    
	statusesCount   = ([dic objectForKey:@"statuses_count"]  == [NSNull null]) ? 0 : [[dic objectForKey:@"statuses_count"] longValue];
    favoritesCount  = ([dic objectForKey:@"favourites_count"]  == [NSNull null]) ? 0 : [[dic objectForKey:@"favourites_count"] longValue];
    
    allowAllActMsg	= ([dic objectForKey:@"allow_all_act_msg"]       == [NSNull null]) ? 0 : [[dic objectForKey:@"allow_all_act_msg"] boolValue];
    geoEnabled		= ([dic objectForKey:@"geo_enabled"]   == [NSNull null]) ? 0 : [[dic objectForKey:@"geo_enabled"] boolValue];
    
	NSString *stringOfCreatedAt   = [dic objectForKey:@"created_at"];
    if ((id)stringOfCreatedAt == [NSNull null]) {
        stringOfCreatedAt = @"";
    }
    createdAt = (long)[stringOfCreatedAt longLongValue];
	
    if ((id)screenName == [NSNull null]) screenName = @"";
    if ((id)name == [NSNull null]) name = @"";
    if ((id)province == [NSNull null]) province = @"";
    if ((id)city == [NSNull null]) city = @"";
    if ((id)location == [NSNull null]) location = @"";
    if ((id)description == [NSNull null]) description = @"";
    if ((id)url == [NSNull null]) url = @"";
    if ((id)profileImageUrl == [NSNull null]) profileImageUrl = @"";
    if ((id)domain == [NSNull null]) domain = @"";
    
    [screenName retain];
    [name retain];
	[province retain];
	[city retain];
    location = [[location unescapeHTML] retain];
    description = [[description unescapeHTML] retain];
    [url retain];
    [profileImageUrl retain];
	[domain retain];
	profileLargeImageUrl = [[profileImageUrl stringByReplacingOccurrencesOfString:@"/50/" withString:@"/180/"] retain];
}


+ (SinaUser*)userWithJsonDictionary:(NSDictionary*)dic
{
	//int userId = [[dic objectForKey:@"id"] intValue];
    SinaUser *u;
    
    u = [[SinaUser alloc] initWithJsonDictionary:dic];
    return [u autorelease];
}

- (void)dealloc
{
	[userKey release];
    [screenName release];
    [name release];
	[province release];
	[city release];
    [location release];
    [description release];
    [url release];
    [profileImageUrl release];
	[profileLargeImageUrl release];
	[domain release];
   	[super dealloc];
}


@end
