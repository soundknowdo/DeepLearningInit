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

% % 数据维数，4字节整数， int32
% [nNum,~] = size(lstFileNameAndFlagForLearn);%number of sample
% nRow = 2000;%length of the sound sample
% nCol = 1;%single sound channel,2 is stero, 3 multiple channel
% % 可用来研究多通道之间的相互关联吗？

% ==== 两个文件中的数据比较  ====
% Bin文件中样本数据中信号 第17个信号
strFileNameBin = 'TestSamples.bin';
[intFlagHeadBin,nNumBin,nRowBin,nColBin,matxSampleBin] = ReadSampleBin(strFileNameBin);
% Mat文件中样本数据中信号 
[nNumMat,nRowMat,nColMat,matxSampleMat] = ReadSampleMat(lstFileNameAndFlagForTest);

% 比较
ind = 90;
dMove = 0.001;
plot([matxSampleBin(:,ind) matxSampleMat(:,ind)+dMove]);
legend('Bin','Mat')

