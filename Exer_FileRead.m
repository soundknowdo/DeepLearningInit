% Exer_FileOperationRead.m
% 文件操作练习 读取

close all;

% % 生成一个数组
% matxMagic5 = magic(5);

% 读取二进制文件 FileExer.bin
strFileName = 'FileExer.bin';
strPermission = 'r';
fid = fopen(strFileName,strPermission);
matx = fread(fid,'integer*2');
fclose(fid);
