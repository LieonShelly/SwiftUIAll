//
//  CombinePlayground.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/14.
//

import Foundation
import Combine
import CoreData

public func check<P: Publisher>(_ title: String, publisher: () -> P) -> AnyCancellable {
    print("----- \(title) -----")
    defer { print("") }
    return publisher()
        .print()
        .sink(
            receiveCompletion: { _ in},
            receiveValue: { _ in }
        )
}

public func delay(_ seconds: TimeInterval = 0, on queue: DispatchQueue = .main, block: @escaping () -> Void) {
    queue.asyncAfter(deadline: .now() + seconds, execute: block)
}

public enum SampleError: Error {
    case sampleError
}

public struct TimeEventItem<Value> {
    public let duration: TimeInterval
    public let value: Value

    public init(duration: TimeInterval, value: Value) {
        self.duration = duration
        self.value = value
    }
}

extension TimeEventItem: Equatable where Value: Equatable {}
extension TimeEventItem: CustomStringConvertible {
    public var description: String {
        return "[\(duration)] - \(value)"
    }
}

extension Sequence {
    public func scan<ResultElement>(
        _ initial: ResultElement,
        _ nextPartialResult: (ResultElement, Element) -> ResultElement
    ) -> [ResultElement] {
        var result: [ResultElement] = []
        for x in self {
            result.append(nextPartialResult(result.last ?? initial, x))
        }
        return result
    }
}


enum MyError: Error {
    case myError
}
