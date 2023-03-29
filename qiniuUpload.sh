npm run build

# 获取上个版本文件列表
qshell listbucket2 tool-mytool  -p usetool/ -o  qiniutempfiles.txt

# 删除上个版本数据
qshell batchdelete tool-mytool -i  qiniutempfiles.txt

# 上传新版本
qshell qupload qiniu.conf