//
//  AdessoErrorTest.swift
//  SampleAppSwiftUITests
//
//  Created by Uslu, Teyhan on 3.06.2023.
//

@testable import SampleAppSwiftUI
import XCTest

final class AdessoErrorTest: XCTestCase {

    let validURL = "https://www.adesso.com.tr/"
    let validErrorMessage = "Error"
    let validDomainName = "google"
    let validNumber = 200
    let defaultNumberIsZero = 0

    func test_httpErrorErrorCode_isValidNumber() {
        // GIVEN
        guard let status = HTTPStatus(rawValue: validNumber) else { return }
        // WHEN
        let error = AdessoError.httpError(status: status)
        // THEN
        XCTAssertEqual(error.errorCode, validNumber)
    }

    func test_unknownErrorErrorCode_isValidNumber() {
        // GIVEN
        let status = NSError(domain: validDomainName, code: validNumber)
        // WHEN
        let error = AdessoError.unknown(error: status)
        // THEN
        XCTAssertEqual(error.errorCode, validNumber)
    }

    func test_customErrorErrorCode_isValidNumber() {
        // WHEN
        let error = AdessoError.customError(validNumber, validErrorMessage)
        // THEN
        XCTAssertEqual(error.errorCode, validNumber)
    }

    func test_mappingFailedErrorCode_isZero() {
        // WHEN
        let error = AdessoError.mappingFailed()
        // THEN
        XCTAssertEqual(error.errorCode, defaultNumberIsZero)
    }

    func test_badResponseErrorCode_isZero() {
        // WHEN
        let error = AdessoError.badResponse
        // THEN
        XCTAssertEqual(error.errorCode, defaultNumberIsZero)
    }

    func test_badURLErrorCode_isZero() {
        // WHEN
        let error = AdessoError.badURL(validURL)
        // THEN
        XCTAssertEqual(error.errorCode, defaultNumberIsZero)
    }

    func test_httpErrorResponse_isNil() {
        // GIVEN
        guard let status = HTTPStatus(rawValue: validNumber) else { return }
        // WHEN
        let error = AdessoError.httpError(status: status)
        // THEN
        XCTAssertNil(error.response)
    }

    func test_httpErrorResponse_isValidResponse() { // TODO: Ask ErrorResponse Codable
        // GIVEN
        guard let status = HTTPStatus(rawValue: validNumber) else { return }
        // WHEN
        let error = AdessoError.httpError(status: status, data: dataFromErrorResponse())
        // THEN
        XCTAssertEqual(error.response?.code, anyErrorResponse().code)
    }

    func test_customErrorResponse_isValidResponse() {
        // WHEN
        let error = AdessoError.customError(validNumber, validErrorMessage, dataFromErrorResponse())
        // THEN
        XCTAssertEqual(error.response?.code, anyErrorResponse().code)
    }

    func test_badResponseResponse_isNil() {
        // WHEN
        let error = AdessoError.badResponse
        // THEN
        XCTAssertNil(error.response)
    }

    func test_mappingFailedResponse_isNil() {
        // WHEN
        let error = AdessoError.mappingFailed()
        // THEN
        XCTAssertNil(error.response)
    }

    func test_unknownResponse_isNil() {
        // GIVEN
        let status = NSError(domain: validDomainName, code: validNumber)
        // WHEN
        let error = AdessoError.unknown(error: status)
        // THEN
        XCTAssertNil(error.response)
    }

    func test_badURLResponse_isNil() {
        // WHEN
        let error = AdessoError.badURL(validURL)
        // THEN
        XCTAssertNil(error.response)
    }

    // MARK: Helpers
    func dataFromErrorResponse() -> Data? {
        try? JSONEncoder().encode(anyErrorResponse())
    }

    func anyErrorResponse() -> ErrorResponse {
        let data = ErrorResponse()
        data.code = validNumber
        data.message = validErrorMessage
        data.messages = [validErrorMessage: validErrorMessage]
        return data
    }
}
