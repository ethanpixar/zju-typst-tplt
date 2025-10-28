#import "@local/tplt:0.3.0": *

#let course = "生产实习"
#let ymd = "2025-07-12"
#let proj-name = [Gestureye 手视]
#let teacher = [　]

#show: BL

#zju-cover(
  title: "生产实习总结报告",
  proj-name: [Just try _*Gestureye*_,\ #K0[*手视*]，您的首次尝试],

  student-count: 5,
  leader: "XXX",
  students: "XXX, XXX, XXX, XXX",

  teacher: teacher,
  ymd: ymd,
)

#show: RP.with(
  course: course,
  proj-name: proj-name,
)
= 以下展示几种报告信息的格式
== 个人报告：仅显示组员姓名
=== 人数 $>=$ 3 `classmate-count: 3`
#v(20pt)

#exp-info-chart(
  titled: false, //为方便展示，取消标题
  course: course,
  exp-cate: "综合项目开发",
  teacher: teacher,
  exp-name: proj-name,

  classmate-count: 4,
  classmates: [XXX，XXX，XXX，XXX],

  where: [玉泉创客中心],
  ymd: ymd,
)

=== 人数 $<=$ 3 `classmate-count: 2`
#v(20pt)
#exp-info-chart(
  titled: false, //为方便展示，取消标题
  course: course,
  exp-cate: "综合项目开发",
  teacher: teacher,
  exp-name: proj-name,

  classmate-count: 2,
  classmates: [XXX，XXX],

  where: [玉泉创客中心],
  ymd: ymd,
)

== 小组报告：显示组员详细信息
=== 显示成员头衔 `is-student-titled: true`
#v(20pt)
#exp-info-chart(
  titled: false,
  course: course,
  exp-cate: "综合项目开发",
  teacher: teacher,

  exp-name: proj-name,

  student-count: 5,
  is-student-titled: true,
  students: (
    ([组#h(2em);长], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);一], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);二], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);三], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);四], "XXX", "32X010XXXX", "生物医学工程"),
  ),

  where: [玉泉创客中心],
  ymd: ymd,
)

=== 无成员头衔 `is-student-titled: false`
#v(20pt)
#exp-info-chart(
  titled: false,
  course: course,
  exp-cate: "综合项目开发",
  teacher: teacher,

  exp-name: proj-name,

  student-count: 5,
  students: (
    ("XXX", "32X010XXXX", "生物医学工程"),
    ("XXX", "32X010XXXX", "生物医学工程"),
    ("XXX", "32X010XXXX", "生物医学工程"),
    ("XXX", "32X010XXXX", "生物医学工程"),
    ("XXX", "32X010XXXX", "生物医学工程"),
  ),

  where: [玉泉创客中心],
  ymd: ymd,
)

#pagebreak()

#exp-info-chart(
  course: course,
  exp-cate: "综合项目开发",
  teacher: teacher,

  exp-name: proj-name,

  student-count: 5,
  is-student-titled: true,
  students: (
    ([组#h(2em);长], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);一], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);二], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);三], "XXX", "32X010XXXX", "生物医学工程"),
    ([组#h(0.5em);员#h(0.5em);四], "XXX", "32X010XXXX", "生物医学工程"),
  ),

  where: [玉泉创客中心],
  ymd: ymd,
)

#show: chap-num


#outline(depth: 2)

#pagebreak()

#h0(outlined: true)[实验分工]
#d2
#H[XXX：]下位机手势识别 Mediapipe 框架搭建，手势分类以及定义 Detector 架构接口，手势识别算法编写，数据传输协议定义，下位机与上位机之间 Socket 与蓝牙通信原型实现，以及下位机传输客户端 API 及调用，上位机 Linux API 的设计与实现，项目整体架构把握及联调。\
#H[XXX：]手势与指令的对应设计。\
#H[XXX：]macOS API 设计与实现，并辅助 Linux API 的设计与实现。\
#H[XXX：]上位机指令转换与跨平台 API 设计实现，负责 OSManager 接口设计、Windows系统部分功能实现、双通信协议客户端开发、完整客户端 UI 系统开发，以及 IP Webcam 远程调试功能实现。\
#H[XXX：]Windows API 设计与实现，完成包含窗口管理、鼠标控制、键盘操作、手势映射等核心功能模块，并提供了图形化演示界面和完整的测试套件，随后简化版本，提供简洁易用的 API 接口。\


= 项目概述
+ 背景：
  + 随着人工智能和计算机视觉技术的发展，手势识别作为一种自然的人机交互方式，越来越受到关注。
  + 目前市面上已有多种手势识别产品，但大多数产品仅支持单一平台，缺乏跨平台的解决方案，现有的手势识别系统多集中于特定应用场景，如游戏控制、智能家居等，缺乏通用性和可扩展性。
  + 现有系统往往依赖于特定的硬件设备，如深度摄像头或专用传感器，限制了其应用范围和普及性。
  + 手势识别系统的开发需要综合考虑手势识别算法、数据传输协议、系统操作 API 等多个方面的技术细节，现有的解决方案往往缺乏系统性和完整性。
  + 此外，现有的手势识别系统往往缺乏良好的用户界面和易用性，用户需要具备一定的技术背景才能进行配置和使用。

  本项目旨在填补这一空白，提供一个可扩展的手势识别控制UI界面和通讯API接口，可在多个平台（包括Windows、macOS和Linux）上部署和运行。

+ 目标：
  + 实现手势识别控制系统，支持多种手势识别和系统操作。
  + 提供跨平台的用户界面和通讯API接口。
  + 实现手势到系统操作的映射，支持窗口管理、音量控制、媒体播放等功能。

+ 技术栈：
  - UI：PyQt6
  - 手势识别：mediapipe
  - 数据传输与通信：socket
  - 系统操作 API
    - *macOS*：Apple Script + pyautogui
    - *Windows*：pywin32 + pyautogui
    - *Linux*：kdotool / xdotool + pyautogui + pactl





= 整体架构

本项目采用了分布式架构设计，主要分为下位机和上位机两部分。下位机负责手势识别和通信，上位机负责用户界面和指令转换。
== 下位机
- 识别手势
- 将手势信息发送给上位机
  - 手势类型
  - 左手 / 右手
  - 静态手势的开始与结束
  - 动态手势（可能包括位移数据）
== 上位机
- 接收下位机信息
- 将手势信息翻译成系统的操作
- 通过 API 完成操作

= 下位机实现
== 手势识别



=== 静态手势


=== 动态手势




== 通信协议：统一的管理接口


= 上位机实现
== UI界面

== 通信

== 指令转换


== API设计与实现

== IP Webcam远程调试功能
IP Webcam功能支持通过Android设备进行远程手势识别调试。用户可以在Android设备上安装IP Webcam应用，将手机或平板摄像头作为远程摄像头使用。系统通过WiFi网络实现低延迟的视频流传输，自动调整分辨率、帧率以匹配本地摄像头配置。



该功能在开发调试阶段使用，生产环境则使用的树莓派。


= 项目开发流程

1. 项目方案敲定：
  - 确定项目目标、技术栈和开发流程
  - 分析现有手势识别系统的不足之处
  - 设计系统架构和功能模块
2. 可行性与需求分析：
  - 评估手势识别技术的可行性
  - 确定系统需求和功能列表
  - 制定项目计划和时间表
3. 任务分配：
  - 根据团队成员的特长和兴趣分配任务
  - 确定每个模块的负责人和开发周期
  - 制定详细的任务清单和里程碑
4. 上位机与下位机开发：
  - 上位机开发环境搭建
  - 下位机固件开发
  - 上下位机通信协议设计
5. UI开发
  - 上位机用户界面设计与实现
  - 实现手势识别结果的实时显示和操作反馈
  - 完成配置管理和日志系统
6. 组合联调
  - 上下位机功能联调
  - 系统整体性能优化
7. 初步验收
8. 项目文档总结
9. 视频拍摄与剪辑


= 难点与解决方案
== 手势识别的准确性

== 通信延迟




== 跨平台兼容性问题




== Windows API开发难点





== 动态手势轨迹处理






== Bluetooth通信稳定性



== UI响应性能





= 经验与总结

回首整个“Gestureye手视”项目的开发历程，我们收获的远不止一个功能完备、跨平台的手势控制系统，更是一次宝贵的、从理论到实践、从个体到团队的全面淬炼。这段旅程充满了挑战的荆棘与创新的火花，最终沉淀为我们未来道路上坚实的基石。

== 技术深潜与能力跃迁

== 架构设计：从蓝图到大厦的基石

== 团队协作：$1 + 1 > N$ 的化学反应


== 结语：技术之外的成长


“Gestureye手视”项目为我们的大学生涯画上了浓墨重彩的一笔。它不仅是一份优秀的课程设计作品，更是我们从学生向准工程师转变的重要里程碑。我们深知，当前系统仍有优化的空间，未来的路还很长。但我们坚信，这段旅程的终点，正是我们下一段更精彩征程的起点。




