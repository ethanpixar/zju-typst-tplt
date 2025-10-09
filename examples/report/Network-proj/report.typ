#import "@local/tplt:0.2.0": *
#show: BL

#let course = [网络技术]
#let teacher = [ ]
#let proj = [基于Flask与Scapy的局域网安全态势感知与可视化平台]
#let proj-short = [局域网安全态势感知与可视化]

#zju-cover(
  course: course,
  proj-name: [基于Flask与Scapy的局域网\ 安全态势感知与可视化平台],
  teacher: teacher,
)

#show: RP.with(
  course: course,
  proj-name: proj-short,
)

#exp-info-chart(
  course: course,
  exp-cate: [自定实验],
  teacher: teacher,

  exp-name: proj,
  where: [ ],
)

#h0[摘　要]
本报告详细阐述了一个基于Python语言开发的局域网安全态势感知与可视化平台的设计与实现。该平台旨在解决传统局域网环境设备管理不便、网络状态不透明的问题。通过综合运用 ARP广播进行设备发现、多线程TCP Socket进行端口探测、ICMP协议进行网络延迟检测等底层网络技术，并结合Flask轻量级Web框架和前端动态可视化技术，项目成功实现了一个可通过浏览器访问的、直观的、实时的网络监控仪表盘。用户能够一键扫描并识别局域网内的所有活动设备，查看其IP/MAC地址、硬件厂商、开放端口及网络延迟等关键信息。

项目访问链接：#link("https://github.com/EthanPixar/lan-scanner")

#outline()

#pagebreak()

= 项目介绍
+ 项目背景与动机

  在现代家庭和小型办公环境中，网络设备日益增多，但普通用户和非专业网络管理员往往缺乏有效的工具来监控局域网（LAN）的状态。这导致了设备管理不透明、潜在安全风险难以发现等问题。传统的网络监控工具往往操作复杂，对专业知识要求高，不适合普通用户。本项目旨在弥补这一差距，提供一个轻量级、易于上手的解决方案。
  此外，本项目的一个重要动机是将抽象的网络协议概念具象化。通过亲手实现网络扫描与数据呈现，开发者和用户都能更深刻地理解如ARP、ICMP、TCP等协议在实际网络通信中的作用及其工作边界，例如广播域的限制对MAC地址获取的影响。

+ 项目目标与意义

  本项目的主要目标是开发一个轻量级、免安装的Web平台，用户通过浏览器即可一键式扫描局域网，以直观的可视化方式掌握网络内所有活动设备的关键信息，提升网络的可管理性和安全性。具体目标包括：
  1. 发现局域网内的活动设备，获取其IP和MAC地址。
  2. 识别设备的硬件制造商。
  3. 检测设备的网络延迟（RTT）。
  4. 扫描设备开放的常用端口。
  5. 通过Web界面友好地展示所有收集到的信息。
  6. 实现后台异步扫描，保证Web界面响应。

  项目意义在于：
  1. 提升网络透明度：帮助用户了解其网络中连接了哪些设备。
  2. 增强安全意识：通过展示开放端口等信息，辅助用户识别潜在风险。
  3. 简化网络管理：为非专业人士提供一个易用的网络概览工具。
  4. 教育价值：通过实践，将网络协议等理论知识应用于实际，揭示网络协议的适用边界（如ARP在路由环境下的局限性），加深对网络通信原理的理解。

+ 技术选型与可行性分析\
  项目技术选型充分考虑了轻量级、快速开发和跨平台运行的需求：
  - 后端：
    - Python 3: 作为主要的开发语言，其丰富的库和简洁的语法适合快速开发。
    - Flask: 一个轻量级的Python Web框架，用于构建API服务和处理Web请求，易于上手且资源消耗小。
    - Scapy: 一个强大的Python库，用于构造、发送、捕获和分析网络数据包，是实现底层网络扫描（如ARP、ICMP）的核心。
  - 前端：
    - HTML5, CSS3, JavaScript (原生): 无需引入复杂的前端框架，保持前端的轻量化，利用原生JS实现动态交互和数据展示。
  - 依赖管理: `requirements.txt` 文件用于管理Python依赖。
  - 数据存储: 扫描结果实时存储在服务端的内存中，不涉及持久化数据库，符合轻量级特性。

  可行性分析：
  1. 技术成熟度：所选技术均为成熟且广泛应用的技术，拥有丰富的文档和社区支持。
  2. 开发效率：Python和Flask的组合能够实现快速原型开发和迭代。Scapy简化了底层网络包的操作。
  3. 跨平台性：Python、Flask和Scapy均支持主流操作系统（Windows, macOS, Linux），保证了后端应用的可移植性。前端基于标准Web技术，可在任何现代浏览器运行。
  4. 性能考量：通过多线程处理端口扫描和设备信息获取，以及后续针对大规模网络的智能扫描范围优化，确保了在典型局域网环境下的可接受性能。
  5. 资源需求：项目设计为轻量级，对服务器资源要求不高，适合在个人电脑或小型服务器上运行。

  综上所述，该技术选型能够满足项目需求，并保证了项目的可行性和可维护性。

= 系统设计
== 整体架构设计
=== 前后端分离的分层架构
本平台采用经典的前后端分离的B/S（Browser/Server）架构，具体分层如下：

==== 表现层 (Frontend)
用户直接交互的界面，通过Web浏览器访问。
- 技术栈: HTML5, CSS3, JavaScript (原生)
- 作用:
  - 提供用户操作界面（如“开始扫描”按钮）。
  - 向后端API发送请求（启动扫描、获取数据）。
  - 动态解析和展示后端返回的设备信息和扫描状态。
  - 实现数据的定时自动刷新。
- 主要文件: index.html, style.css, script.js

==== 应用层 (Backend - Web Service)
处理前端请求，协调扫描任务。
- 技术栈: Python, Flask
- 作用:
  - 提供RESTful API接口（`/scan`, `/devices`, `/status`）。
  - 接收前端的扫描启动请求，并在后台线程中调用核心扫描模块。
  - 从核心扫描模块获取最新的扫描结果，并以JSON格式返回给前端。
  - 管理扫描任务的状态。
- 主要文件: app.py

==== 核心逻辑层 (Backend - Scanner)
执行实际的网络扫描和数据处理。
- 技术栈: Python, Scapy, `socket`, `threading`, `ipaddress`
- 作用:
  - 实现设备发现逻辑（ARP、Ping扫描，并针对路由/交换环境进行优化）。
  - 实现端口扫描逻辑（TCP连接尝试）。
  - 实现网络延迟检测逻辑（ICMP Ping）。
  - 实现MAC地址到设备厂商的转换（OUI查询）。
  - 管理扫描结果数据结构和线程安全。
  - 自动检测本机网络环境并调整扫描策略。
- 主要文件: scanner.py

==== 数据层 (Data)
- OUI数据: `oui.txt` 文件，存储MAC地址前缀与厂商的映射。
- 扫描结果: 实时存储在 scanner.py 模块的全局变量 `scan_results` (字典) 中，通过线程锁 `scan_lock` 保证并发访问安全。

#figure(image("graph/image.png"), caption: [系统架构设计示意图])

=== 模块划分与职责说明
+ 扫描模块 (scanner.py):

  负责所有底层的网络扫描操作。这包括自动确定网络范围，使用ARP或Ping发现活动设备，获取MAC地址，通过TCP Socket扫描开放端口，使用ICMP测量延迟，以及根据MAC地址查询OUI数据库获取设备厂商。该模块还实现了针对不同网络环境（如大型路由环境）的智能扫描策略和范围限制，以优化性能和结果准确性。扫描结果存储在该模块的全局变量中，并使用锁机制保证线程安全。

+ Web服务模块 (app.py):

  作为后端的核心控制器，使用Flask框架搭建。它定义了API端点，如 `/` 用于提供Web界面，`/scan` 用于异步启动后台扫描任务（通过创建一个新线程调用扫描模块的 `run_full_scan` 函数），`/devices` 用于前端轮询获取最新的扫描结果和状态。它负责请求的解析、响应的格式化（JSON），以及与扫描模块的数据交互。

+ 前端展示模块 (index.html, style.css, script.js):

  用户直接与之交互的部分。index.html 定义了页面的结构，包括扫描按钮、状态显示区域、统计面板和设备列表容器。style.css 负责页面的美化和响应式布局。script.js 实现了前端的动态逻辑，包括：向后端API发送扫描请求，定时轮询获取设备数据，动态生成和更新设备卡片到页面上，以及管理扫描过程中的UI状态（如加载动画、按钮禁用等）。

== 核心工作流程设计
用户触发扫描到数据呈现的完整流程:
1. 用户操作: 用户在浏览器中打开平台页面，点击“开始扫描”按钮。
2. 前端请求: script.js 捕获点击事件，向后端 `/scan` API端点发送一个异步的 `POST` 请求。同时，前端UI更新为“扫描中”状态（如按钮禁用，显示加载动画）。
3. 后端接收与处理 (app.py): Flask应用接收到 `/scan` 请求。
  - 检查当前是否已有扫描任务在进行，如果是，则返回错误。
  - 创建一个新的后台守护线程，该线程的目标函数是 scanner.py 中的 `run_full_scan`。
  - 立即向前端返回一个JSON响应，告知扫描已启动。
4. 后台扫描 (scanner.py): `run_full_scan` 函数在新线程中执行。
  - 更新全局 `scan_results` 状态为 "scanning"。
  - 调用 `get_network_cidr()` 自动确定本机网络段。
  - 调用 `discover_devices_alternative()` (已优化，包含路由环境检测和智能范围选择) 进行设备发现，获取初步的IP列表（可能包含MAC和初步服务信息）。
  - 遍历发现的设备列表，对于每个设备（或根据环境优化后的策略）：
    - 调用 `check_latency()` 检测网络延迟。
    - 调用 `scan_ports()` (如果需要更详细的端口扫描，或在交换环境中) 扫描预定义的常用端口。
    - 调用 `get_mac_address()` (如果未在发现阶段获取或需要确认)。
    - 调用 `get_vendor_from_mac()` 根据MAC地址查询设备厂商。
    - 整合所有信息，更新每个设备的详细状态。
  - 所有设备处理完毕后，将最终的设备列表存入全局 `scan_results["devices"]`，并更新状态为 "done" (或 "error")。
5. 前端轮询与数据获取: script.js 中的 `fetchData` 函数通过 `setInterval` 定期（例如每2秒）向后端 `/devices` API端点发送 `GET` 请求。
6. 后端响应 (app.py): Flask应用接收到 `/devices` 请求，调用 `scanner.get_scan_results()` (该函数会加锁安全地读取全局 `scan_results`)，并将当前的扫描状态和设备列表以JSON格式返回给前端。
7. 前端数据呈现: script.js 接收到 `/devices` 的响应数据。
  - 解析JSON数据。
  - 调用 `updateUI()` 函数，该函数会：
    - 更新扫描状态文本（如“扫描完成，发现X个设备”）。
    - 更新统计面板信息。
    - 清空旧的设备列表。
    - 遍历新的设备数据，为每个设备动态创建HTML设备卡片，并填充IP、MAC、厂商、延迟、开放端口等信息。
    - 将新创建的设备卡片追加到设备列表容器中。
  - 如果从后端获取的状态为 "done" 或 "error"，则更新前端UI，将扫描按钮恢复为可点击状态，并停止加载动画。
#figure(image("graph/network_scanning.svg"), caption: [核心工作流程设计示意图])
== 设备状态模型设计
=== 扫描过程状态
- Idle (空闲): 系统初始状态，或上一次扫描完成后。可以接受新的扫描请求。
- Scanning (扫描中): 用户触发扫描后，系统正在执行设备发现和信息收集。不接受新的扫描请求。
- Done (完成): 扫描过程正常结束，结果已生成。可以接受新的扫描请求。
- Error (错误): 扫描过程中发生严重错误导致无法完成。可以接受新的扫描请求。
#figure(image("graph/image-1.png"), caption: [扫描过程状态模型])
- *Transitions*:
  - Idle -> Scanning (on POST /scan)
  - Scanning -> Done (on scan completion)
  - Scanning -> Error (on scan failure)
  - Done -> Scanning (on POST /scan)
  - Error -> Scanning (on POST /scan)


=== 单个设备状态
- Discovered (已发现): 设备在网络中被初步探测到（例如，响应了ARP或Ping）。
- Online (在线): 设备不仅被发现，且确认活动（例如，Ping有响应，延迟可测量）。
- Offline (离线): 设备曾被发现，但在当前或后续检查中无响应（例如，Ping超时）。
- Latency Status (延迟状态，视觉表现):
  - Low Latency (低延迟): RTT < 50ms (例如，绿色标记)。
  - Medium Latency (中延迟): 50ms <= RTT < 200ms (例如，橙色标记)。
  - High Latency (高延迟): RTT >= 200ms (例如，红色标记)。
#figure(image("graph/image-2.png", width: 80%), caption: [单个设备状态模型])
- *Transitions*:
  - (Initial) -> Discovered (on successful ARP/Ping response)
  - Discovered -> Online (on successful detailed check, e.g., latency measured)
  - Discovered -> Offline (if detailed check fails)
  - Online -> Offline (if subsequent checks fail, e.g., in a new scan)
  - Offline -> Online (if subsequent checks succeed)

= 核心功能实现与原理
== 主动设备发现模块
+ 实现原理：
  本项目的主动设备发现模块经历了优化迭代，以适应不同的网络环境。
  1. Scapy ARP广播 (理想情况，需root/管理员权限):
    - 原理：ARP (Address Resolution Protocol) 用于在局域网中将IP地址解析为MAC地址。通过向网络广播域发送一个ARP请求包，询问特定IP地址（或整个网段的IP）对应的MAC地址，所有在线且配置了该IP的设备会响应其MAC地址。
    - 实现：使用Scapy库的`ARP()`和`Ether()`构造ARP请求包，目标MAC地址设为广播地址`ff:ff:ff:ff:ff:ff`，目标IP地址设为网络CIDR（如`192.168.1.0/24`）。通过`srp()`函数发送数据包并捕获响应。
  2. 备用与优化方法 (`discover_devices_alternative`):
    - 路由环境适应性: 该方法首先通过 `detect_routed_environment()` 检测当前网络是否为路由环境。
    - 智能扫描范围 (`get_smart_scan_ranges_for_routed_env`, `get_standard_scan_ranges`):
      - 在大型路由环境（如`/16`网络）中，为避免扫描数万个IP导致性能低下和结果冗余，扫描范围被智能限制。优先扫描本机所在的`/24`子网、网络基础设施常见IP段（如`.1-.10`, `.250-.254`），并将总扫描IP数量限制在300个左右。
      - 在小型交换环境（如`/24`网络）中，则扫描整个定义的网段。
    - 设备探测: 对选定范围内的每个IP地址，并行执行系统`ping`命令。
    - MAC地址获取 (`get_mac_address`): 对于ping通的设备，尝试从系统的ARP缓存表 (`arp -n <ip>`) 中获取其MAC地址。在路由环境中，这通常获取到的是网关的MAC地址，代码中对此有特殊标记和处理。在同网段（交换环境）中，则能获取到设备的真实MAC。
    - 初步服务检测: 在路由环境优化中，对ping通的设备会进行快速的关键服务端口（如22, 80, 443, 3389）探测，以便优先展示有服务的设备。

+ 关键代码：
  - Scapy ARP扫描: scanner.py 中的 `discover_devices_scapy()` 函数。
    ```python
    # scanner.py
    # ...
    arp_request = ARP(pdst=network_cidr)
    broadcast = Ether(dst="ff:ff:ff:ff:ff:ff")
    arp_request_broadcast = broadcast / arp_request
    answered_list = srp(arp_request_broadcast, timeout=2, verbose=False)[0]
    for element in answered_list:
        device_info = {'ip': element[1].psrc, 'mac': element[1].hwsrc}
        # ...
    ```
  - 备用与优化方法: scanner.py 中的 `discover_devices_alternative()` 函数，以及其调用的 `detect_routed_environment()`, `get_smart_scan_ranges_for_routed_env()`, `ping_host()` (包含ping和初步端口检测逻辑), `get_mac_address()`。
    ```python
    # scanner.py
    # ...
    is_routed_environment = detect_routed_environment(local_ip, network)
    if is_routed_environment:
       scan_ranges = get_smart_scan_ranges_for_routed_env(network, local_ip)
    else:
        scan_ranges = get_standard_scan_ranges(network, local_ip)
    # ...
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = [executor.submit(ping_host, ip) for ip in unique_ips]
    # ...
    def ping_host(ip):
    #     # ... system ping ...
    #     # ... if routed_env: quick port check ...
        mac = get_mac_address(str(ip))
        return {'ip': str(ip), 'mac': mac, ...}
    ```

== 多线程端口扫描模块
+ 实现原理：
  端口扫描通过尝试与目标设备的特定TCP端口建立连接来实现。如果连接成功建立，则认为该端口是开放的。为提高效率，对多个端口的扫描以及对多个设备的端口扫描均采用多线程并行处理。
  - TCP连接: 使用Python的`socket`库。
  `socket.socket(socket.AF_INET, socket.SOCK_STREAM)`创建一个TCP套接字。
  - 连接尝试: `socket.connect_ex((ip, port))`方法尝试连接到目标IP的指定端口。与`connect()`不同，`connect_ex()`在连接失败时返回错误码而不是抛出异常，这使得处理更简洁。返回值为0表示连接成功。
  - 超时设置: `socket.settimeout(0.5)`设置一个较短的超时时间（0.5秒），以避免在扫描不响应的端口时长时间阻塞。
  - 多线程: 使用`concurrent.futures.ThreadPoolExecutor`来创建一个线程池，将每个端口的扫描任务提交给线程池并发执行。

+ 关键代码：scanner.py 中的 `scan_ports()` 函数。
  ```python
  # scanner.py
  # ...
  def scan_ports(ip, ports_to_scan):
      open_ports = []
      def scan_single_port(port):
          try:
              sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
              sock.settimeout(0.5) # 超时设置
              result = sock.connect_ex((ip, port)) # 尝试连接
              sock.close()
              if result == 0: # 连接成功
                  return port
          except Exception:
              pass
          return None

      with ThreadPoolExecutor(max_workers=20) as executor: # 使用线程池
          futures = [executor.submit(scan_single_port, port) for port in ports_to_scan]
          for future in futures:
              result = future.result()
              if result is not None:
                  open_ports.append(result)
      return sorted(open_ports)
  ```
  在`run_full_scan`中，对每个设备的信息获取（包括端口扫描）也是通过`ThreadPoolExecutor`并行化的。

== 网络延迟检测模块
+ 实现原理：
  网络延迟通常通过发送ICMP (Internet Control Message Protocol) Echo Request包（即Ping命令的核心）到目标设备，并测量从发送请求到接收到ICMP Echo Reply包的往返时间（RTT）来检测。
  1. Scapy ICMP (首选):
    - 使用Scapy库构造`IP()`层（指定目标IP）和`ICMP()`层（Echo Request类型）。
    - 使用`sr1()`函数发送数据包并等待单个响应。`sr1`会自动处理发送和接收。
    - 通过记录发送前和接收到响应后的时间戳，计算差值得到RTT。
  2. 系统Ping命令 (备用):
    - 如果Scapy不可用或出错，则调用操作系统的`ping`命令。
    - 根据操作系统类型（Windows, macOS, Linux）构造不同的`ping`命令参数（如 `-n 1` 或 `-c 1` 发送一个包，`-w` 或 `-W` 设置超时）。
    - 通过`subprocess.run()`执行命令，并解析其标准输出来提取RTT值。如果无法精确解析，则使用执行命令的整体耗时作为近似RTT。

+ 关键代码：scanner.py 中的 `check_latency()` 函数，它会尝试调用 `check_latency_scapy()` 或 `check_latency_alternative()`。
  ```python
  # scanner.py
  # ...
  def check_latency_scapy(ip):
      if not SCAPY_AVAILABLE or IP is None or ICMP is None or sr1 is None:
          raise RuntimeError("Scapy not available")
      packet = IP(dst=ip) / ICMP()
      start_time = time.time()
      response = sr1(packet, timeout=1, verbose=False)
      if response:
          end_time = time.time()
          rtt = (end_time - start_time) * 1000 # ms
          return round(rtt, 2)
      return None

  def check_latency_alternative(ip):
      system = platform.system().lower()
      if system == "windows":
          cmd = ["ping", "-n", "1", "-w", "1000", ip]
      else:
          cmd = ["ping", "-c", "1", "-W", "1", ip]
      # ... execute subprocess and parse output ...
      # import re
      # windows_match = re.search(r'time[<=](\d+)ms', output)
      # unix_match = re.search(r'time=(\d+\.?\d*)\s*ms', output)
      # ...
  ```

== Web服务与API设计
+ 实现框架：Python Flask
  Flask被选为后端Web服务的框架，因为它轻量、灵活且易于与Python的其他库（如Scapy）集成。它负责处理HTTP请求、路由、模板渲染以及提供JSON API。

+ API接口定义 (`/scan`, `/devices`):
  在 app.py 中定义了以下主要的API接口：
  - `GET /`:
    - 功能: 渲染并返回前端主页面 index.html。
    - 实现: 使用Flask的`render_template`函数。
  - `POST /scan`:
    - 功能: 启动一次新的网络扫描任务。
    - 请求体 (JSON, 可选): 可以包含 `network_cidr` 来指定扫描网段，如果未提供则自动检测。
    - 响应 (JSON):
      - 成功: `{"message": "Scan started", "status": "scanning"}` (HTTP 200)
      - 失败 (如扫描已在进行): `{"error": "Scan already in progress", ...}` (HTTP 400)
      - 失败 (其他错误): `{"error": "...", "message": "启动扫描失败", ...}` (HTTP 500)
    - 实现: 检查当前扫描状态，如果空闲则创建一个新的后台线程执行 `scanner.run_full_scan()`，并立即返回成功响应。
  - `GET /devices`:
    - 功能: 获取最新的扫描结果和当前扫描状态。前端会定期轮询此接口。
    - 响应 (JSON): 一个包含设备列表、扫描状态和最后扫描时间的字典。
      ```json
      {
        "devices": [
          {
            "ip": "192.168.1.1",
            "mac": "00:1A:2B:...",
            "vendor": "Apple, Inc.",
            "latency": 10.5,
            "open_ports": [80, 443],
            "status": "online",
            "device_type": "Gateway/Router",
            // ... (其他如 category, importance 在路由环境下)
          }
          // ... more devices
        ],
        "status": "done", // "idle", "scanning", "done", "error"
        "last_scan": "2025-06-14 22:00:00"
      }
      ```
    - 实现: 调用 `scanner.get_scan_results()` 获取线程安全的扫描数据副本，并将其JSON化返回。
  - `GET /status` (辅助接口):
    - 功能: 获取简化的当前扫描状态，包括状态字符串、设备数量和最后扫描时间。
    - 实现: 类似 `/devices`，但返回更简洁的数据。

#pagebreak()
= 功能运行截图与说明
+ 平台主仪表盘界面
  #figure(
    grid(
      image("image/start.png"),
      image("image/scanning.png"),
    ),
    caption: [平台主仪表盘界面 - 扫描中],
  )
  扫描前，界面显示欢迎信息和“开始扫描”按钮，设备列表为空或显示“暂无设备信息”的提示。扫描后（或扫描中），“开始扫描”按钮可能变为“扫描中”并禁用，状态区域更新，统计面板显示数据，设备列表区域填充发现的设备卡片。

- 设备列表扫描结果
  #figure(image("image/1.png"), caption: [设备列表扫描结果 - 扫描完成])
  此截图展示了扫描完成后，设备列表区域的详细情况。每个设备以一个“卡片”的形式展示，清晰列出其IP地址、MAC地址、识别出的设备制造商、当前在线状态、网络延迟

- 后台扫描进程终端输出
  当Flask应用在终端中运行时，scanner.py 和 app.py 中的 `print()` 语句会输出扫描过程的日志信息。这包括：Scapy加载状态、OUI文件加载情况、检测到的网络CIDR、开始扫描的网段、发现的设备数量、每个阶段的进度（如“Scanned X/Y addresses”）、检测到的网络环境（路由/交换）、错误信息等。
#codex(read("terminal.txt"), lang: "fish")

#pagebreak()
= 测试与分析
== 测试环境描述
项目在2种模拟和真实局域网环境下进行了测试，包括：
- 家庭WiFi环境: 通常为小型交换环境，网络规模较小，设备类型多样（手机、电脑、智能家居设备）。
- 模拟大型路由环境: 通过配置和用户反馈，针对`/16`等大规模网络下的扫描行为进行了重点测试和优化，特别是在MAC地址获取和扫描范围限制方面。

== 功能测试结果
=== 家庭WiFi环境（使用个人热点模拟）
- 扫描结果: 成功发现所有在线设备（如手机、电脑等），获取了IP和MAC地址，识别了设备厂商（如Apple Inc）。
#figure(image("image/home.png"), caption: [家庭WiFi环境扫描结果])

=== 大型路由环境（校园网）
- 扫描结果: 成功发现了本机所在子网的设备（如路由器、交换机等），并对常见的网络基础设施IP段进行了扫描。由于路由环境的限制，MAC地址获取主要是网关的MAC，其他设备的MAC地址获取受限。
#figure(
  grid(
    columns: 2,
    column-gutter: 5pt,
    image("image/2.png"), image("image/3.png"),
  ),
  caption: [大型路由环境扫描结果],
)

== 性能分析
- 扫描耗时:
  - 小型网络 (`/24`子网, 约254个IP): 在典型的交换环境下，完整扫描（包括设备发现、端口扫描、延迟检测）能在几十秒内完成，具体取决于网络中活动设备的数量和响应速度。
  - 大型网络 (`/16`子网, 约65536个IP):
    - 优化前: 若尝试全量扫描，耗时极长，不具备实用性。
    - 优化后: 通过智能范围限制（如限制到300个关键IP，优先扫描本机子网和基础设施IP段），扫描时间大幅缩短至几十秒到数分钟（如测试中约13-30秒完成对约300-400个IP的探测），显著提高了在大网络环境下的可用性。
- 并发处理: 使用`ThreadPoolExecutor`进行设备信息获取和端口扫描的并行化，有效利用了多核CPU资源，缩短了总体扫描时间。线程数也根据扫描范围进行了动态调整。
- 内存占用: 由于扫描结果存储在内存中，对于超大规模网络并发现大量设备时，内存占用会相应增加，但对于项目定位的家庭和小型办公环境，内存占用在可接受范围内。

== 项目遇到的问题与解决方案

在项目开发和测试过程中，遇到了一系列挑战，并通过迭代得到解决：
1. Scapy权限问题: Scapy发送原始数据包通常需要root/管理员权限。
  - 解决方案: 检测Scapy可用性，若无权限或加载失败，则自动降级使用系统的`ping`和`arp`命令作为备用扫描方法。提示用户使用`sudo`运行以获得完整功能。
2. 网络段自动检测不准确: 初期可能依赖简单的IP推断或Scapy的默认路由，导致在复杂网络中获取的CIDR不正确（如将`/16`误判为`/24`）。
  - 解决方案: 改进`get_network_cidr()`函数，增加通过解析系统命令（如`ifconfig`, `ip addr`, `ipconfig`）的输出来获取真实的子网掩码和网络段，提高了准确性。
3. 扫描大型网络耗时过长: 直接扫描`/16`等大网段不切实际。
  - 解决方案: 实现`discover_devices_alternative`中的智能扫描范围限制。检测网络环境，若是大型路由环境，则优先扫描本机所在`/24`子网、常见的网络基础设施IP段（如网段的.1-.10, .250-.254等），并设定一个扫描IP总数上限（如300个）。
4. 路由环境下MAC地址获取问题: 在路由环境中，扫描跨网段设备时，ARP只能获取到默认网关的MAC地址，导致所有设备MAC相同或无法识别真实厂商。
  - 解决方案:
    - 实现`detect_routed_environment()`自动检测网络环境。
    - 在路由环境下，调整策略：认识到获取远端真实MAC的困难，转而重点关注设备的可达性、开放的服务（通过快速端口探测），并将获取到的网关MAC特殊标记。
    - 前端展示上，对于此类情况，MAC和厂商信息的重要性降低，更突出IP和服务。
5. 厂商识别率低: 初始`oui.txt`文件较小，很多设备厂商无法识别。
  - 解决方案: 扩展`oui.txt`数据库，增加了更多常见和网络设备厂商的OUI条目。
6. Web App与扫描逻辑不一致/UI问题:
  - 问题: 后端扫描逻辑优化后，Web App调用的函数未及时更新，导致表现与预期不符；前端出现预期外元素、滚动条样式不佳、扫描完成后一直转圈等。
  - 解决方案: 确保app.py调用的`run_full_scan`函数内部统一使用最新的、优化后的扫描逻辑（特别是`discover_devices_alternative`）。修复了前端HTML结构、CSS样式，并完善了JavaScript中处理扫描状态和数据更新的逻辑。

这些问题的解决过程，不仅完善了项目功能，也加深了对网络协议在不同环境下行为特性以及系统设计鲁棒性的理解。

= 总结与展望
+ 项目总结：

  本项目成功设计并实现了一个局域网安全态势感知与可视化平台。通过综合运用Python Flask、Scapy以及原生前端技术，实现了对局域网内活动设备的发现、IP/MAC地址获取、设备厂商识别、网络延迟检测和开放端口扫描等核心功能，并以直观的Web仪表盘形式呈现给用户。项目达到了预期的轻量级、易用性和实时性的目标。
  在开发过程中，深入实践了ARP、ICMP、TCP等网络协议的原理与应用，掌握了使用Scapy进行网络包构造与分析的技能，以及Flask Web框架的API设计和后端服务构建。前端部分则锻炼了原生JavaScript进行DOM操作、异步数据请求和动态UI更新的能力。特别是在处理不同网络环境（交换环境 vs. 路由环境）下的扫描策略差异、性能优化以及线程安全方面，获得了宝贵的经验。

+ 项目遇到的问题与解决方案

  项目的主要挑战包括Scapy的权限依赖、网络环境的复杂性（如大网段扫描、路由环境下的MAC地址获取）、以及前后端逻辑的协同。通过引入备用扫描机制、实现智能网络环境检测与扫描范围优化、扩展OUI数据库、并细致调试前后端交互逻辑，这些问题均得到了有效解决。

+ 项目亮点与创新点
  1. 易用性与可视化: 将复杂的底层网络扫描数据转化为普通用户易于理解的图形化界面，一键启动扫描，降低了网络监控的门槛。
  2. 环境自适应扫描: 针对不同网络环境（特别是大型路由环境与小型交换环境）实现了差异化的智能扫描策略，平衡了扫描的全面性、准确性和性能。
  3. 网络协议的实践性揭示: 项目的实现过程本身就是一个对网络协议理论知识的实践验证。例如，通过实际编码和测试，清晰地展示了ARP协议在广播域内的有效性，以及在跨网段的路由环境中其获取远端真实MAC地址的局限性。这使得抽象的网络概念变得具体可感知。
  4. 轻量级与免安装: 基于Python和标准Web技术，无需用户安装额外客户端软件，具有良好的可移植性和便捷性。

+ 未来展望
  1. 历史数据存储与趋势分析: 引入轻量级数据库（如SQLite）存储历次扫描结果，实现设备上下线历史、网络延迟变化等趋势分析功能。
  2. 增强安全告警机制:
    - 实现更智能的安全风险提示，如检测到新设备接入时告警、发现设备开放了高危端口时告警。
    - 尝试集成如ARP欺骗检测、可疑网络流量模式识别等更高级的安全功能。
  3. 持续性能优化: 进一步优化扫描算法，研究更高效的设备发现技术（如结合mDNS、SSDP等），以支持更大规模网络的快速扫描。
  4. 用户体验提升:
    - 开发移动端适配界面或专门的移动版视图。
    - 增加设备自定义备注、分组管理等功能。
    - 提供更详细的设备信息查询接口或与外部资产管理系统联动。
  5. 可配置性增强: 允许用户自定义扫描的端口列表、扫描超时参数等。

通过持续迭代和功能增强，有望成为一个更全面、更智能的局域网安全管理助手。
