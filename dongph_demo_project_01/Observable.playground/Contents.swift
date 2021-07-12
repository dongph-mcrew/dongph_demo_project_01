import UIKit
import RxSwift

let iOS = 1
let android = 2
let flutter = 3
let observable11 = Observable<Int>.just(iOS)
observable11.subscribe { event in
        print(event)
}

//  Khởi tạo biến observable1 mang kiểu Observable
//  1. .just Khởi tạo Observable và chỉ phát ra một lần duy nhất và kết thúc sau đó. (Ngoài .just ra còn có .of, .from, .empty, .nerver, .range)
//  Observable<Type> - Type: là kiểu dữ liệu mà Observable phát đi. Trong đoạn code dưới thì observable1 sẽ phát đi dữ liệu kiểu Int (iOS = 1)
let observable1 = Observable<Int>.just(iOS)//Observable<[Int]>.just([iOS, android, flutter])

//  2. .of sẽ tự suy luận ra kiểu dữ liệu và phát đi. Cho đễn khi phát đi tất cả giá trị hoặc lỗi.
    //  2.1 Các dữ liệu bên trong phải giống nhau.
        // Observable.of(iOS, android, flutter) -> True
        // Observable.of(iOS, android, flutter, 4.1) -> False
        // Observable.of(iOS, android, flutter, "1") -> False
let observable2 = Observable.of(iOS, android, flutter)

let observable3 = Observable.of([iOS, android, flutter], [iOS, android, flutter])

//  3. .from tham số cần truyền cho func này là một Array.
    //  Giống như of, from sẽ lập qua từng phần tử trong array cho đến khi Completed hoặt error
    //  From giúp chúng ta tránh được việc phải of nhiều lần
let observable4 = Observable.from([[iOS, android, flutter], [iOS, android, flutter], flutter])

//MARK: Subscribe
// Khi một Observable phát ra thì .subscribe sẽ nhận được giá trị mà Observable đã phát ra.

///Run 1.
//observable1.subscribe { event in
//        print(event)
//}

///Run 2.
//observable2.subscribe(onNext: { (value) in
//        print(value)
//    }, onError: { (error) in
//        print(error.localizedDescription)
//    }, onCompleted: {
//        print("Completed")
//    })

///Run 3.
//observable4.subscribe(onNext: { element in
//      print(element)
//}, onCompleted: {
//            print("Completed")
//        })

//MARK: Các dạng đặc biệt của Observables

//  4. .empty toán tử này sẽ không phát ra bất kì giá trị gì và sẽ kết thúc ngay lập tức. Thường dùng để phát ra sự kiện Completed mà không muốn gửi thêm bất kì giá trị nào kèm theo đó.
///Code sample
//let observable = Observable<Int>.empty()

//observable.subscribe(
//  onNext: { element in
//    print(element)
//},
//  onCompleted: {
//    print("Completed")
//  }
//)

//  5. Trái lại với .empty .never sẽ không phát ra bất kì thứ gì và nó cũng sẽ không kết thúc, không bao giờ.
///Code sample
//let observable = Observable<Any>.never()
//
//    observable.subscribe(
//        onNext: { element in
//            print(element)
//        },
//        onCompleted: {
//            print("Completed")
//        }
//    )

//  6. .range hiểu đơn giản thì range giống như một vòng for với điểm bắt đầu là start và sẽ chạy đến count, sau mỗi lần chạy start sẽ tăng lên 1 đơn vị
///Code sample
//let observable = Observable<Int>.range(start: 1, count: 10)
//    var sum = 0
//    observable
//        .subscribe(
//            onNext: { i in
//                sum += i
//        } , onCompleted: {
//            print("Sum = \(sum)")
//        }
//    )

