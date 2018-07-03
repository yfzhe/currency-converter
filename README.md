# 一个简单的汇率转换

在线地址：<https://yfzhe.github.io/currency-converter>

## 缘由

~~半个月前接触到 [Elm](https://elm-lang.org) ，写起来很舒服。~~

~~在跟着官网上教程走了一遍之后，感觉还是有些不熟悉，于是准备自己写个小东西试试手。一直想不到写什么东西好，~~事情的转机在于~~一天小众软件的 telegram 群里有人问有没有什么在 excel 里面用的汇率转换时，一个群友推荐了 [fixer.io](http://fixer.io)。于是就有了这个小玩意的想法。~~

后来感觉 Elm 这个语言太糟糕了（[这篇博文](http://reasonablypolymorphic.com/blog/elm-is-wrong/)有和我一致的感受），在简单完成基础功能之后，我就将这个项目放弃了。

在简单学习 React.js 之后，又重新对 The Elm Architecture 感兴趣，于是回来使用 ELm。同时，原来使用的 fixer.io 的 api 已经更新，现在转换到 [exchangerate-api.com](exchangerate-api.com)。

## 功能

现在的功能十分简陋。准备加上历史汇率图表的功能。另外还会加入数学表达式的输入方式，类似 100USD * 80% 这样，这样直接计算。
