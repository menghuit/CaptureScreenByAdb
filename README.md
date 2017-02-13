# CaptureScreenByAdb
通过Adb对手机截屏，并保存在电脑上

截图保存位置：bat脚本同级目录下的result文件夹

----------
使用方法

1. 确保android手机打开开发者调试模式
2. 运行capscreen.bat脚本，两种方式
	- 命令行传参数-文件名。例如：capscreen.bat filename
	- 双击运行，然后根据提示输入要保存的文件名

----------

### 注意：

1. 在输入文件名时，不用后缀。默认保存成png格式
2. 如果使用命令行参数中有空格，使用""包裹参数。例如：capscreen.bat "file name"
