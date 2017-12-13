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

% ����ά����4�ֽ������� int32
[nNum,~] = size(lstFileNameAndFlagForLearn);%number of sample
nRow = 2000;%length of the sound sample
nCol = 1;%single sound channel,2 is stero, 3 multiple channel
% �������о���ͨ��֮����໥������

% ==== �ļ�����  ====
% ѧϰ��������
strFileName = 'LearnSamples.bin';
lstFileNameAndFlag = lstFileNameAndFlagForLearn;
SaveSampleBin(strFileName, lstFileNameAndFlag);
% ѧϰ������ǩ����
strSaveFileName = 'LearnSamplesflag.bin';
SaveSampleFlagBin(strSaveFileName, lstFileNameAndFlag)

% ������������
strFileName = 'TestSamples.bin';
lstFileNameAndFlag = lstFileNameAndFlagForTest;
SaveSampleBin(strFileName, lstFileNameAndFlag);
% ����������ǩ
strSaveFileName = 'TestSamplesflag.bin';
SaveSampleFlagBin(strSaveFileName, lstFileNameAndFlag)

% % ==== �ļ�����  ====
% strFileName = 'LearnSamples.bin';
% strPermission = 'w';
% fid = fopen(strFileName,strPermission);
% intFlagHead = 3331;% 00 00 0D 03 ������������ά
% fwrite(fid, intFlagHead);
% fwrite(fid,nNum,'int32');
% fwrite(fid,nRow,'int32');
% fwrite(fid,nCol,'int32');
% % ===========
% nStart = 2001;
% index = nStart : nStart + nRow - 1;
% disp('������')
% for ind = 1:nNum
%     strFileName = lstFileNameTmp(ind).name;
%     strPathName = lstFileNameTmp(ind).folder;
%     data = load([strPathName '\' strFileName]);
%     dFs = str2double(data.File_Header.SampleFrequency);
%     vecSig = data.Channel_1_Data;
%     vecSigSeg = vecSig(index);
%     % === �������ļ�����
%     fwrite(fid,vecSigSeg,'float32');
%     % ===
%     disp([ num2str(ind) '...'])
% end
% 
% fclose(fid);

% % ����һ������
% matxMagic5 = magic(5);
% 
% % ���������ݴ���������ļ� FileExer.bin
% strFileName = 'FileExer.bin';
% strPermission = 'w';
% fid = fopen(strFileName,strPermission);
% fwrite(fid,matxMagic5,'integer*2');
% fclose(fid);
