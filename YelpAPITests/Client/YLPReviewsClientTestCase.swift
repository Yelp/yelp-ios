//
//  YLPReviewsClientTestCase.swift
//  YelpAPI
//
//  Created by Steven Sheldon on 10/22/16.
//
//

import OHHTTPStubs
import XCTest

class YLPReviewsClientTestCase: YLPClientTestCaseBase {
    override func setUp() {
        super.setUp()
        defaultResource = "reviews_response.json"
    }

    func testGetReviews() {
        let expect = expectation(description: "Test that reviews were returned.")

        OHHTTPStubs.stubRequests(passingTest: { $0.url?.host == kYLPAPIHost }) { _ in
            return OHHTTPStubsResponse(fileAtPath: OHPathForFile(self.defaultResource, type(of: self))!,
                                       statusCode: 200,
                                       headers: ["Content-Type": "application/json"])
        }

        client.reviewsForBusiness(withId: "bizId") { (reviews, error) in
            XCTAssertNil(error)
            guard let reviews = reviews else {
                XCTFail("Nil business reviews from reviews lookup")
                return
            }
            XCTAssertEqual(reviews.reviews.count, 3)
            expect.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testBusinessReviewsParsing() {
        guard let reviewsResponseJSON = loadExpectedResponse(defaultResource) else {
            XCTFail("Could not load reviews JSON")
            return
        }

        let reviews = YLPBusinessReviews(dictionary: reviewsResponseJSON)
        XCTAssertEqual(reviews.total, 3)
        XCTAssertEqual(reviews.reviews.count, 3)
    }

    func testReviewParsing() {
        guard let reviewsResponseJSON = loadExpectedResponse(defaultResource),
              let reviewsJSONArray = reviewsResponseJSON["reviews"] as? [[String: Any]],
              let reviewJSON = reviewsJSONArray.first else {
            XCTFail("Could not load review JSON")
            return
        }

        let review = YLPReview(dictionary: reviewJSON)
        XCTAssertEqual(review.rating, 5)
        XCTAssert(review.excerpt.hasPrefix("Went back again to this place since"))

        let expectedDate = DateComponents(calendar: Calendar(identifier: .gregorian),
                                          timeZone: TimeZone(abbreviation: "PST"),
                                          year: 2016, month: 8, day: 29,
                                          hour: 0, minute: 41, second: 13).date!
        XCTAssertEqual(review.timeCreated, expectedDate)

        let user = review.user
        XCTAssertEqual(user.name, "Ella A.")
        XCTAssertNotNil(user.imageURL)
    }

    func testUserParsingNullImage() {
        let userJSON: [String: Any] = [
            "name": "Ella A.",
            "image_url": NSNull(),
        ]

        let user = YLPUser(dictionary: userJSON)
        XCTAssertNil(user.imageURL)
    }
}
