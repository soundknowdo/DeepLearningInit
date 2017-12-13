% Exer_FileWrite.m
% �ļ�������ϰ

close all;
clear all; %#ok<CLALL>

% ��ǰĿ¼
strCurrentPath= 'E:\������������\ϴ�»���ȡ����\';
%��ȡ�ź���������
strDataFilePath = {...
    '20171030����ϴ�»�ʵ��������-����',0;...
    '20171030����ϴ�»�����������-����',1};

% �������ļ��б�����ӱ�ǩ
[rowNum, ~] = size(strDataFilePath);
lstFileNameAndFlagForLearn = [];
lstFileNameAndFlagForTest = [];

% ������2/3Ϊѧϰ��1/3Ϊ����
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

% % ����ά����4�ֽ������� int32
% [nNum,~] = size(lstFileNameAndFlagForLearn);%number of sample
% nRow = 2000;%length of the sound sample
% nCol = 1;%single sound channel,2 is stero, 3 multiple channel
% % �������о���ͨ��֮����໥������

% ==== �����ļ��е����ݱȽ�  ====
% Bin�ļ��������������ź� ��17���ź�
strFileNameBin = 'TestSamples.bin';
[intFlagHeadBin,nNumBin,nRowBin,nColBin,matxSampleBin] = ReadSampleBin(strFileNameBin);
% Mat�ļ��������������ź� 
[nNumMat,nRowMat,nColMat,matxSampleMat] = ReadSampleMat(lstFileNameAndFlagForTest);

% �Ƚ�
ind = 90;
dMove = 0.001;
plot([matxSampleBin(:,ind) matxSampleMat(:,ind)+dMove]);
legend('Bin','Mat')

