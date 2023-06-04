//
//  AdessoErrorTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 3.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AdessoErrorTest: XCTestCase {

    func test_httpErrorErrorCode_isValidNumber() {
        guard let status = HTTPStatus(rawValue: validNumber()) else { return }
        let error = AdessoError.httpError(status: status)
        XCTAssertEqual(error.errorCode, validNumber())
    }

    func test_unknownErrorErrorCode_isValidNumber() {
        let status = NSError(domain: validDomainName(), code: validNumber())
        let error = AdessoError.unknown(error: status)
        XCTAssertEqual(error.errorCode, validNumber())
    }

    func test_customErrorErrorCode_isValidNumber() {
        let error = AdessoError.customError(validNumber(), validErrorMessage())
        XCTAssertEqual(error.errorCode, validNumber())
    }

    func test_mappingFailedErrorCode_isZero() {
        let error = AdessoError.mappingFailed()
        XCTAssertEqual(error.errorCode, defaultNumberIsZero())
    }

    func test_badResponseErrorCode_isZero() {
        let error = AdessoError.badResponse
        XCTAssertEqual(error.errorCode, defaultNumberIsZero())
    }

    func test_badURLErrorCode_isZero() {
        let error = AdessoError.badURL(validURL())
        XCTAssertEqual(error.errorCode, defaultNumberIsZero())
    }

    func test_httpErrorResponse_isNil() {
        guard let status = HTTPStatus(rawValue: validNumber()) else { return }
        let error = AdessoError.httpError(status: status)
        XCTAssertNil(error.response)
    }

    func test_httpErrorResponse_isValidResponse() { // TODO: Ask ErrorResponse Codable
        guard let status = HTTPStatus(rawValue: validNumber()) else { return }
        let error = AdessoError.httpError(status: status, data: dataFromErrorResponse())
        XCTAssertEqual(error.response?.code, anyErrorResponse().code)
    }

    func test_customErrorResponse_isValidResponse() {
        let error = AdessoError.customError(validNumber(), validErrorMessage(), dataFromErrorResponse())
        XCTAssertEqual(error.response?.code, anyErrorResponse().code)
    }

    func test_badResponseResponse_isNil() {
        let error = AdessoError.badResponse
        XCTAssertNil(error.response)
    }

    func test_mappingFailedResponse_isNil() {
        let error = AdessoError.mappingFailed()
        XCTAssertNil(error.response)
    }

    func test_unknownResponse_isNil() {
        let status = NSError(domain: validDomainName(), code: validNumber())
        let error = AdessoError.unknown(error: status)
        XCTAssertNil(error.response)
    }

    func test_badURLResponse_isNil() {
        let error = AdessoError.badURL(validURL())
        XCTAssertNil(error.response)
    }

    // MARK: Helpers
    func dataFromErrorResponse() -> Data? {
        try? JSONEncoder().encode(anyErrorResponse())
    }

    func anyErrorResponse() -> ErrorResponse {
        let data = ErrorResponse()
        data.code = validNumber()
        data.message = validErrorMessage()
        data.messages = [validErrorMessage(): validErrorMessage()]
        return data
    }

    func validURL() -> String {
        "https://www.adesso.com.tr/"
    }

    func validErrorMessage() -> String {
        "Error"
    }

    func validDomainName() -> String {
        "google"
    }

    func validNumber() -> Int {
        200
    }

    func defaultNumberIsZero() -> Int {
        0
    }
}
