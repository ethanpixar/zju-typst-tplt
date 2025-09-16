## 使用方法

1. 使用 VS Code 打开仓库
2. VS Code 中安装 Tinymist Typst 插件
3. 把 `info-example.json` 文件中的信息为你自己的相关信息，并重命名为 `info.json`。
4. 在文件 `zju-typst-tplt/0.2.0/template/support/list/fonts.typ`，可以看到字体列表：

    ```typst
    #let ensans = "SF Pro Display" // 英文无衬线体
    ...
    #let mono = ("SF Mono", "PingFang SC")// 等宽字体
    ```

    为保证显示效果相同，需安装以下字体包`fontsForTypst.zip`（或者修改为你系统中已有的其他字体）。

    [字体包下载链接（使用浙大云盘）](https://pan.zju.edu.cn/share/cf92632a20a38535870a92f2e0)

5. 把 `zju-typst-tplt` 放在 Typst 指定的本地模版目录下，该目录需通过 VS Code 命令面板 `Cmd + Shift + P` 输入 `Typst: Create Local Packages` 在这个目录下先创建一个模版文件夹，打开这个文件夹的位置，再把 `zju-typst-tplt` 拷贝到这个名为 `local` 的文件夹中（原来创建的模版文件夹也就没用了，之后可以通过 `Typst: Open Local Packages` 来打开这个模版）。

    ps：这个路径在 macOS 下的地址为 `/Users/ethanpixar/Library/Application Support/typst/packages/local/`。

完成以上步骤后，在任意目录下新建 `xxx.typ`，都可以使用该模板，在 `xxx.typ` 文件开头输入：

```typst
#import "@local/zju-typst-tplt:0.2.0": *

#show: BL // 基本样式，务必首先使用
// 定义文件信息
#let ymd = "2025-04-8" // 日期，格式为 YYYY-MM-DD
#let course = "Biomedical Image Processing" // 课程名称
#let proj-name = "Homework 3" // 作业/项目名称

// 具体模版，可以选择 HW(Homework), NT(Note), RP(Report), AR(Article)
#show: HW.with( 
    proj-name: proj-name,
    course: course,
    english: true,
    ymd: ymd,
)

... // 正文内容
```

- 使用快捷键 `Cmd + K, V` 进行预览。
- 代码编辑器最上方的 `Export PDF` 可以导出 PDF。

- 使用命令面板 `Cmd + Shift + P`，输入 `Typst` 查看更多指令。

## 使用示例

参考以下几个仓库：
...等我上传

## 小贴士

1. 可以使用

    ```typst
    #codex(read("code/xxx.py"), lang: "python")
    ```

    来插入代码块
2. 可以使用

    ```typst
    #figure(image("pic/xxx.png/jpeg/svg", width: ?%), caption: [图片标题])
    ```

    来插入图片
