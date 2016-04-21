[![Build Status](https://travis-ci.org/Yelp/yelp-ios.svg?branch=master)](https://travis-ci.org/Yelp/yelp-ios)


# YelpAPI

To run the example project, clone the repo, and run `pod install` from the Example directory first.

This is a Cocoapod for the Yelp API. It'll simplify the process of consuming data
from the Yelp API for developers using Objective-C or Swift. The library encompasses Search
, Business, and Phone Search API functions.

Please remember to read and follow the Terms of Use and display requirements
before creating your applications.

## Installation

YelpAPI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YelpAPI"
```

## Usage
### Basic Usage
```objective-c
    YLPClient *client = [[YLPClient alloc]initWithConsumerKey:<key>
                                               consumerSecret:<consumer_secret>
                                                        token:<token>
                                                  tokenSecret:<token_secret>];
```

### [Search API](http://www.yelp.com/developers/documentation/v2/search_api)
Once you have a `YLPClient` object you can use the various search related function:

##### Search With Location
```objective-c
- (void)searchWithLocation:(NSString *)location
            currentLatLong:(nullable YLPCoordinate *)cll
                      term:(nullable NSString *)term
                     limit:(NSUInteger)limit
                    offset:(NSUInteger)offset
                      sort:(YLPSortType)sort
         completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithLocation:(NSString *)location
         completionHandler:(YLPSearchCompletionHandler)completionHandler;
```
---
##### Search With Geographic Bounding Box
```objective-c
- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
          currentLatLong:(nullable YLPCoordinate *)cll
                    term:(nullable NSString *)term
                   limit:(NSUInteger)limit
                  offset:(NSUInteger)offset
                    sort:(YLPSortType)sort
       completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithBounds:(YLPGeoBoundingBox *)bounds
       completionHandler:(YLPSearchCompletionHandler)completionHandler;
```
---
##### Search With Geographic Coordinate
```objective-c
- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
                 currentLatLong:(nullable YLPCoordinate *)cll
                           term:(nullable NSString *)term
                          limit:(NSUInteger)limit
                         offset:(NSUInteger)offset
                           sort:(YLPSortType)sort
              completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithGeoCoordinate:(YLPGeoCoordinate *)geoCoordinate
              completionHandler:(YLPSearchCompletionHandler)completionHandler;
``` 

Each interface provides a different way to query the Search API depending on the
type of information that you have on hand. There are three different methods of 
querying the Search API, each of which accepts a different format for location input.
Consequentially, there are three sets of functions in the clientlib to support
calls into each version of the Search API. Each set of functions contains a 
version to call the API with only the required parameters, while another which 
accepts arguments for all optional parameters. 

`YLPSearchCompletionHandler` is a block which takes a `YLPSearch*` and
`NSError*` object as arguments. Upon successful completion of an API call the 
result will be returned in the `YLPSearch*` object, alternatively errors 
will be returned in the `NSError*` object. 

#### Example Search Usage

```objective-c
[self.client searchWithLocation:@"San Francisco, CA" completionHandler:^
    (YLPSearch *search, NSError *error) {
    // Perform any tasks you need to here
}];
``` 

### [Business API](https://www.yelp.com/developers/documentation/v2/business)
The `YLPClient` object will also provide access to the Business API, the
relevant functions are:

```objective-c
- (void)businessWithId:(NSString *)businessId
           countryCode:(nullable NSString *)countryCode
          languageCode:(nullable NSString *)languageCode
        languageFilter:(BOOL)languageFilter
           actionLinks:(BOOL)actionLinks
     completionHandler:(YLPBusinessCompletionHandler)completionHandler;

- (void)businessWithId:(NSString *)businessId
     completionHandler:(YLPBusinessCompletionHandler)completionHandler;
```

`YLPBusinessCompletionHandler` is a block which takes a `YLPBusiness*` and an
`NSError*` object as arguments. Upon successful completion of an API call the 
result will be returned in the `YLPBusiness*` object, alternatively errors will
be returned in the `NSError*` object. 

#### Example Business Usage

```objective-c
[self.client businessWithId:@"yelp-san-francisco" completionHandler:^
    (YLPBusiness *search, NSError *error) {
    // Perform any tasks you need to here
}];
```

### [Phone Search API](https://www.yelp.com/developers/documentation/v2/phone_search)
The `YLPClient` object will also provide access to the Phone Search API,
the relevant functions are:

```objective-c
- (void)businessWithPhoneNumber:(NSString *)phoneNumber
                    countryCode:(nullable NSString *)countryCode
                       category:(nullable NSString *)category
              completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler;

- (void)businessWithPhoneNumber:(NSString *)phoneNumber
              completionHandler:(YLPPhoneSearchCompletionHandler)completionHandler;
```

`YLPPhoneSearchCompletionHandler` is a block which takes a `YLPPhoneSearch*` and an `NSError*`
object as arguments. Upon successful completion of an API call the result will be returned
in the `YLPPhoneSearchCompletionHandler*` object, alternatively errors will be
returned in the `NSError*` object. 

#### Example Phone Search Usage

```objective-c
[self.client businessWithPhoneNumber:@"4159083801" completionHandler:^
    (YLPPhoneSearch *search, NSError *error) {
    // Perform any tasks you need to here
}];
```

## Responses
A `Response` object is a data structure returned after each successful API call. The objects are
readily available to be used. They will contain all available response fields as
documented in our [API documentation](https://www.yelp.com/developers/documentation/v2/overview).

`Response` objects returned by an API call may contain other `Response` objects.
For example, the `YLPPhoneSearch` object contains an array of `YLPBusiness` objects as well.
All `Response` objects can be found [here](https://github.com/Yelp/yelp-ios/tree/master/Classes/Response)

## Contributing
1. Fork it (http://github.com/yelp/yelp-ios/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
