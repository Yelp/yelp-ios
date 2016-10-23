//
//  YLPReviewsClientTestCase.swift
//  YelpAPI
//
//  Created by Steven Sheldon on 10/22/16.
//
//

import XCTest

class YLPReviewsClientTestCase: YLPClientTestCaseBase {
    override func setUp() {
        super.setUp()
        defaultResource = "reviews_response.json"
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
}
