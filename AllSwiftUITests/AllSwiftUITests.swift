//
//  AllSwiftUITests.swift
//  AllSwiftUITests
//
//  Created by Renjun Li on 2021/12/7.
//

import XCTest
@testable import AllSwiftUI
import Combine

class AllSwiftUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    @Converter(initialValue: "100", from: "USD", to: "CNY", rate: 6.88)
    var usd_cny
    
    @Converter(initialValue: "100", from: "CNY", to: "EUR", rate: 0.13)
    var cny_eur
    
    func testPropertyWrapper() {
        print("\(usd_cny) = \($usd_cny)") // wrappedValue = projectedValue
        print("\(cny_eur) = \($cny_eur)")
    }
    
    func testPunlisher() {
        // 如果我们对一连串的值感兴趣的话，可以使用的是 Publishers.Sequence
        check("Sequence") {
            Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
        }
        check("Array") {
            [1, 2, 3].publisher
        }
    }
    
    func testOperator() {
        check("map") {
            [1, 2, 3]
                .publisher
                .map { $0 * 2}
        }
        check("Just") {
            Just(5)
                .map { $0 * 2 }
        }
        check("reduce") {
            // Array 的 reduce 方法可以将数组中的元素按照某种规则进行合并，
            [1, 2, 3, 4, 5].publisher
                .reduce(0, +)
        }
        
        check("scan") {
            [1, 2, 3, 4, 5].publisher
                .scan(0, +)
        }
        
        check("flatMap") {
            [[1, 2, 3], ["a", "b"]]
                .publisher
                .flatMap { $0.publisher }
        }
        check("Remove Duplicates") {
            ["S", "Sw", "Sw", "Sw", "Swi",
             "Swif", "Swift", "Swift", "Swif"]
                .publisher
                .removeDuplicates()
        }
        
    }
    // 错误处理
    func testErrorHandle() {
        // 生成错误
        check("Fail") {
            Fail<Int, SampleError>(error: .sampleError)
        }
        // 准换错误类型
        check("Map Error") {
            Fail<Int, SampleError>(error: .sampleError)
                .mapError({_ in MyError.myError})
        }
        // 抛出错误
        check("Throw") {
            ["1", "Swift", "4"].publisher
                .tryMap { s -> Int in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
                }
        }
        // 从错误中恢复
        check("Replace Error") {
            ["1", "Swift", "4"]
                .publisher
                .tryMap { s -> Int in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
                }
                .replaceError(with: -1)
        }
        
        check("Catch with Just Error") {
            ["1", "Swift", "4"]
                .publisher
                .tryMap { s -> Int in
                    guard let value = Int(s) else {
                        throw MyError.myError
                    }
                    return value
                }
                .catch({_ in [-1, -2, -3].publisher })
            //                .catch({ _ in Just(-1) })
        }
        check("Catch and Continue") {
            ["1", "2", "Swift", "4"]
                .publisher
                .print("[ Original ]")
                .flatMap { s in
                    return Just(s)
                        .tryMap { s -> Int in
                            guard let value = Int(s) else {
                                throw MyError.myError
                            }
                            return value
                        }
                        .print("[ TryMap ]")
                        .catch { _ in
                            Just(-1)
                                .print("[ Just ]")
                        }
                        .print("[ Catch ]")
                }
        }
    }
    
    // 嵌套的泛型类型和类型抹消
    func testGenericType() {
        // eraseToAnyPublisher: 但就订阅者来说，只需要关心 Publisher 的 Output 和 Failure 两个类型就能顺利订 阅，它们并不需要具体知道这个 Publisher 是如何得到、如何嵌套的。Combine 提 供了 eraseToAnyPublisher 来帮助我们对复杂类型的 Publisher 进行类型抹消，这 个方法返回一个 AnyPublisher:
        // 在大多数情况下我们都只会关注某个部件所扮演的角色，也即，它 到底是一个 Publisher 还是一个 Subscriber
        let p1 = [[1, 2, 3], [4, 5, 6]]
            .publisher
            .flatMap { $0.publisher }
        let p3 = p1.eraseToAnyPublisher()

    }
    
    func testMerge() {
        let publisher = PassthroughSubject<Int, Never>()
        let pub2 = PassthroughSubject<Int, Never>()
        
        check("testMerge") {
            publisher.merge(with: pub2)
        }
        
        
        publisher.send(2)
        pub2.send(2)
        publisher.send(3)
        pub2.send(22)
        publisher.send(45)
        pub2.send(22)
        publisher.send(17)
        
    }
    // zip
    func testZip() {
        let subject1 = PassthroughSubject<Int, Never>()
        let subject2 = PassthroughSubject<String, Never>()
        
        check("Zip") {
          subject1.zip(subject2)
        }
        subject1.send(1)
        subject2.send("A")
        subject1.send(2)
        subject2.send("B")
        subject2.send("C")
        subject2.send("D")
        subject1.send(3)
        subject1.send(4)
        subject1.send(5)
    }
    // combineLatest
    func testCombineLatest() {
        // 它的语义接近于 “当...或...”，当 Publisher1 发布 值，或者 Publisher2 发布值时，将两个值合并，作为新的事件发布出去。
        let subject1 = PassthroughSubject<Int, Never>()
        let subject2 = PassthroughSubject<String, Never>()
        
        check("Zip") {
          subject1.combineLatest(subject2)
        }
        subject1.send(1)
        subject2.send("A") // 1A
        subject1.send(2) // 2A
        subject2.send("B") //2B
        subject2.send("C")
        subject2.send("D")
        subject1.send(3)
        subject1.send(4)
        subject1.send(5)
    }
    
    func loadPage(url: URL, handler: @escaping (Data?, URLResponse?, Error?) ->  Void) {
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            handler(data, response, error)
        }.resume()
    }

    // Future 如果我们希望订阅操作和值的发布是异步行为，不在同一时间发生的话，可以使用 Future == Obseranle.create
    // Future 只能为我们提供一次性 Publisher:对于提供的 promise，你只 有两种选择:发送一个值并让 Publisher 正常结束，或者发送一个错误。因此， Future 只适用于那些必然会产生事件结果，且至多只会产生一个结果的场景。比如 刚才看到的网络请求:它要么成功并返回数据及响应，要么直接失败并给出 URLError
    func testFuture() {
        Future<(Data, URLResponse), Error> { promise in
            self.loadPage(url: URL(string: "sdf")!) { data, response, error in
                if let data = data, let response = response {
                    promise(.success((data, response)))
                } else {
                    promise(.failure(error!))
                }
            }
        }
    }
    // 使用Subject  - 相对于单次事件的网络请求，可以发布多次事件的操作在日常开发中更加常见:
    func testSubject() {
        let subject = PassthroughSubject<Date, Never>()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            subject.send(Date())
        }
        let timer = check("Timer") {
            subject
        }
    }
    /**
     Foundation 中的 Publisher
     - URLSession Publisher
     - Timer Publisher 创建一个按照一定间隔发送事件 的 Publisher:
     - Notification Publisher Foundation 中的 NotificationCenter 也提供了创建 Publisher 的辅 助 API:
     */
    /**
     @Published
     - Combine 中存在 @Published 封装，用来把一个 class 的属性值转变为 Publisher。它同时提供了值的存储和对外的 Publisher (通过投影符号 $ 获取)。在被 订阅时，当前值也会被发送给订阅者，它的底层其实就是一个 CurrentValueSubject
     */
    func testPublishWrapper() {
        class Wrapper {
            @Published var text: String = "hoho"
        }
        var wrapper = Wrapper()
        check("Published") {
            wrapper.$text
        }
        wrapper.text = "123"
        wrapper.text = "abc"

    }
    
    func testPassthoughSubject() {
        let subject = PassthroughSubject<String, Never>()
        subject.send("1")
        subject.send("2")
        subject.eraseToAnyPublisher()
    }
}
