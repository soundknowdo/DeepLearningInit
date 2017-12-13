% Exer_FileWrite.m
% 文件操作练习

close all;
clear all; %#ok<CLALL>

% 当前目录
strCurrentPath= 'E:\海尔测试数据\洗衣机提取数据\';
%读取信号样本数据
strDataFilePath = {...
    '20171030海尔洗衣机实验室数据-故障',0;...
    '20171030海尔洗衣机生产线数据-正常',1};

% 将样本文件列表，并添加标签
[rowNum, ~] = size(strDataFilePath);
lstFileNameAndFlagForLearn = [];
lstFileNameAndFlagForTest = [];

% 样本的2/3为学习，1/3为测试
dRatio = 2/3;
for ind = 1:rowNum
    cd(strDataFilePath{ind,1});
    lstFileNameStruct = dir('**/*.mat');
    nSampleNum = length(lstFileNameStruct);
    lstFileName = mat2cell(lstFileNameStruct,ones(1,nSampleNum));
    lstFlag = mat2cell(ones(nSampleNum,1)*strDataFilePath{ind,2},ones(1,nSampleNum));
    
    indexLearn = 1:floor(nSampleNum*dRatio);
    indexTest = length(indexLearn)+1:nSampleNum;
    
    lstFileNameTmp = lstFileName(indexLearn);
    lstFlagTmp = lstFlag(indexLearn);
    lstFileNameAndFlagForLearn = [lstFileNameAndFlagForLearn; [lstFileNameTmp lstFlagTmp]];
    
    lstFileNameTmp = lstFileName(indexTest);
    lstFlagTmp = lstFlag(indexTest);
    lstFileNameAndFlagForTest = [lstFileNameAndFlagForTest;[lstFileNameTmp  lstFlagTmp]];
    cd(strCurrentPath);

end

% 数据维数，4字节整数， int32
[nNum,~] = size(lstFileNameAndFlagForLearn);%number of sample
nRow = 2000;%length of the sound sample
nCol = 1;%single sound channel,2 is stero, 3 multiple channel
% 可用来研究多通道之间的相互关联吗？

% ==== 文件操作  ====
% 学习样本数据
strFileName = 'LearnSamples.bin';
lstFileNameAndFlag = lstFileNameAndFlagForLearn;
SaveSampleBin(strFileName, lstFileNameAndFlag);
% 学习样本标签数据
strSaveFileName = 'LearnSamplesflag.bin';
SaveSampleFlagBin(strSaveFileName, lstFileNameAndFlag)

% 测试样本数据
strFileName = 'TestSamples.bin';
lstFileNameAndFlag = lstFileNameAndFlagForTest;
SaveSampleBin(strFileName, lstFileNameAndFlag);
% 测试样本标签
strSaveFileName = 'TestSamplesflag.bin';
SaveSampleFlagBin(strSaveFileName, lstFileNameAndFlag)

% % ==== 文件操作  ====
% strFileName = 'LearnSamples.bin';
% strPermission = 'w';
% fid = fopen(strFileName,strPermission);
% intFlagHead = 3331;% 00 00 0D 03 单精度数，三维
% fwrite(fid, intFlagHead);
% fwrite(fid,nNum,'int32');
% fwrite(fid,nRow,'int32');
% fwrite(fid,nCol,'int32');
% % ===========
% nStart = 2001;
% index = nStart : nStart + nRow - 1;
% disp('样本：')
% for ind = 1:nNum
%     strFileName = lstFileNameTmp(ind).name;
%     strPathName = lstFileNameTmp(ind).folder;
%     data = load([strPathName '\' strFileName]);
%     dFs = str2double(data.File_Header.SampleFrequency);
%     vecSig = data.Channel_1_Data;
%     vecSigSeg = vecSig(index);
%     % === 下面是文件操作
%     fwrite(fid,vecSigSeg,'float32');
%     % ===
%     disp([ num2str(ind) '...'])
% end
% 
% fclose(fid);

% % 生成一个数组
% matxMagic5 = magic(5);
% 
% % 将数组数据存入二进制文件 FileExer.bin
% strFileName = 'FileExer.bin';
% strPermission = 'w';
% fid = fopen(strFileName,strPermission);
% fwrite(fid,matxMagic5,'integer*2');
% fclose(fid);
