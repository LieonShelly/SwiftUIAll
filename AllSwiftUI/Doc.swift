//
//  Doc.swift
//  AllSwiftUI
//
//  Created by Renjun Li on 2021/12/8.
//

import Foundation
/**
 
 /**
  # view modifier 分为两种类别:
  -  像是 font，foregroundColor 这样定义在具体类型 (比如例中的 Text) 上，然 后返回同样类型 (Text) 的原地 modifier。
  - 像是 padding，background 这样定义在 View extension 中，将原来的 View 进行包装并返回新的 View 的封装类 modifier。
  
  @State 修饰的值，在 SwiftUI 内部会被自动转换为一对 setter 和 getter，对这个属性进行赋值的操作将会触发 View 的刷新，它的 body 会 被再次调用，底层渲染引擎会找出界面上被改变的部分，根据新的属性值计算出新 的 View，并进行刷新
  @State 属性值仅只能在属性本身被设置时会触发 UI 刷新，这个特性让 它非常适合用来声明一个值类型的值:因为对值类型的属性的变更，也会触发整个 值的重新设置，进而刷新 UI。不过，在把这样的值在不同对象间传递时，状态值将 会遵守值语义发生复制。
  
  
  @Binding 就是用来解决这个问题的。和 @State 类似，@Binding 也是对属性的修 饰，它做的事情是将值语义的属性 “转换” 为引用语义。对被声明为 @Binding 的属 性进行赋值，改变的将不是属性本身，而是它的引用，这个改变将被向外传递
  
  传递 brain 时，我们在它前面加上美元符号 $。在 Swift 5.1 中，对一个由 @ 符号 修饰的属性，在它前面使用 $ 所取得的值，被称为投影属性 (projection property)。 有些 @ 属性，比如这里的 @State 和 @Binding，它们的投影属性就是自身所对应 值的 Binding 类型。
  
  State 非常适合 struct 或者 enum 这样的值类型，它可以自动为我们完成从状态 到 UI 更新等一系列操作。但是它本身也有一些限制，我们在使用 @State 之前，对 于需要传递的状态，最好关心和审视下面这两个问题:
  1. 这个状态是属于单个 View 及其子层级，还是需要在平行的部件之间传递和使 用?@State 可以依靠 SwiftUI 框架完成 View 的自动订阅和刷新，但这是有 条件的:对于 @State 修饰的属性的访问，只能发生在 body 或者 body 所调 用的方法中。你不能在外部改变 @State 的值，它的所有相关操作和状态改变 都应该是和当前 View 挂钩的。如果你需要在多个 View 中共享数据，@State 可能不是很好的选择;如果还需要在 View 外部操作数据，那么 @State 甚至 就不是可选项了。
  2. 状态对应的数据结构是否足够简单?对于像是单个的 Bool 或者 String， @State 可以迅速对应。含有少数几个成员变量的值类型，也许使用 @State 也还不错。但是对于更复杂的情况，例如含有很多属性和方法的类型，可能其 中只有很少几个属性需要触发 UI 更新，也可能各个属性之间彼此有关联，那 么我们应该选择引用类型和更灵活的可自定义方式。
  
  # Text
  # HStack
  # VStack
  # RoundedRectangle
  # Rectangle
  # Form
  # Picker
  # TextField
  # Section
  # SecureField
  # Button
  # NavigationView
  
  
  # Combine
   - 异步编程的本质是响应未来发生的事件流。
  - 我们可以将 “状态变化” 看作是被发布出来的异步操作的事件，订阅这个事件，并对 订阅了事件的 View 根据更新后的状态进行绘制，这就是 SwiftUI 的核心逻辑。
  
  在响应式异步编程中，一个事件及其 对应的数据被发布出来，最后被订阅者消化和使用。期间这些事件和数据需要通过 一系列操作变形，成为我们最终需要的事件和数据。Combine 中最重要的角色有三 种，恰好对应了这三种操作:负责发布事件的 Publisher，负责订阅事件的 Subscriber，以及负责转换事件和数据的 Operator。
  
  ## Publisher
  
  有限事件流和无限事件流
  虽然 Publisher 可以发布三种事件，但是它们并不是必须的。一个 Publisher 可能发 出一个或多个 output 值，也可能一个值都不发出;Publisher 有可能永远不会停止 终结，也有可能通过 failure 或者 finished 事件来表明不再会发出新的事件。我们将 最终会终结的事件流称为有限事件流，而将不会发出 failure 或者 finished 的事件流 称为无限事件流。
  
  Publisher 可以发布三种事件:
  1. 类型为 Output 的新值:这代表事件流中出现了新的值。
  2. 类型为 Failure 的错误:这代表事件流中发生了问题，事件流到此终止。 3. 完成事件:表示事件流中所有的元素都已经发布结束，事件流到此终止
  
  ## Operator
  
  在响应式编程中，绝大部分的逻辑和关键代码的编写，都发生在数据处理和变形中。 每个 Operator 的行为模式都一样:它们使用上游 Publisher 所发布的数据作为输入， 以此产生的新的数据，然后自身成为新的 Publisher，并将这些新的数据作为输出， 发布给下游。
  
  ## Subscriber
  - Combine 中也定义了几个比较常见的 Subscriber，我们承接上面的按钮的例子来进 行说明。在上面，我们通过 scan 和 map，对 buttonClicked 进行了变形，将它从一 个不含数据的按钮事件流，转变为了以 String 表示的按钮按下次数的计数。如果我 们想要订阅和使用这些值，可以使用 sink:

- assign assign 接受一个 class 对象以及对 象类型上的某个键路径 (key path)。每当 output 事件到来时，其中包含的值就将被 设置到对应的属性上去:
  
  
  Subject
  Subject 本身也是一个 Publisher:

  PassthroughSubject 并不会对接受到的值进行保留，当订阅开始后，它将监听并响 应接下来的事件
  
  和 PassthroughSubject 不同，CurrentValueSubject 则会包装和持有一个值，并在 设置该值时发送事件并保留新的值。在订阅发生的瞬间，CurrentValueSubject 会把 当前保存的值发送给订阅者。
  
  Scheduler
  如果说 Publisher 决定了发布怎样的 (what) 事件流的话，Scheduler 所要解决的就 是两个问题:在什么地方 (where)，以及在什么时候 (when) 来发布事件和执行代码。
  */
 
 - 从哪里来
 - 到那里去

 Publisher 中的 zip 和 Sequence 的 zip 相类似:它会把两个 (或多个) Publisher 事 件序列中在同一 index 位置上的值进行合并，也就是说，Publisher1 中的第一个事 件和 Publisher2 中的第一个事件结对合并，Publisher1 中的第二个事件和 Publisher2 中的第二个事件合并，以此类推:
 # 订阅和绑定
 ## 通过 sink 订阅 Publisher 事件
 ## 通过 assign 绑定 Publisher 值
    - 除了 Subscribers.Sink 以外，Combine 里还有另一个内建的 Subscriber: Subscribers.Assign，它可以用来将 Publisher 的输出值通过 key path 绑定到一个 对象的属性上去。在 SwiftUI 中，这种值通常会是 ObservableObject 中的属性值， 它进一步会被用来驱动 View 的更新
 ## Cancellable, AnyCancellable 和内存管理
 # propertyWrapper
 
 # 动画与导航
 ## 隐式动画，显式动画
 ## 手势 @GestureState
 ## NavigationLink
 ## Tabbar
 ## URL Schema
 
 */
