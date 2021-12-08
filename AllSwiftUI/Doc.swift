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

  */

 */
