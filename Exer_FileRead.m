% Exer_FileOperationRead.m
% �ļ�������ϰ ��ȡ

close all;

% % ����һ������
% matxMagic5 = magic(5);

% ��ȡ�������ļ� FileExer.bin
strFileName = 'FileExer.bin';
strPermission = 'r';
fid = fopen(strFileName,strPermission);
matx = fread(fid,'integer*2');
fclose(fid);
