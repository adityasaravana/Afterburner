import SwiftUI
import Defaults
import XCTest

@available(iOS 15, tvOS 15, watchOS 8, *)
final class DefaultsColorTests: XCTestCase {
	override func setUp() {
		super.setUp()
		Defaults.removeAll()
	}

	override func tearDown() {
		super.tearDown()
		Defaults.removeAll()
	}

	func testPreservesColorSpace() {
		let fixture = Color(.displayP3, red: 1, green: 0.3, blue: 0.7, opacity: 1)
		let key = Defaults.Key<Color?>("independentColorPreservesColorSpaceKey")
		Defaults[key] = fixture
		XCTAssertEqual(Defaults[key]?.cgColor?.colorSpace, fixture.cgColor?.colorSpace)
		XCTAssertEqual(Defaults[key]?.cgColor, fixture.cgColor)
	}
}
