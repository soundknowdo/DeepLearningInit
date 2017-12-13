function [nNum,nRow,nCol,matxSampleMat] = ReadSampleMat(lstFileName)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   

% ==== �ļ�����  ====
% strFileName = 'LearnSamples.bin';
% ����ά����4�ֽ������� int32
% �������о���ͨ��֮����໥������

% strPermission = 'r';
% fid = fopen(strReadFileName,strPermission);
% % intFlagHead = 3331;% 00 00 0D 03 ������������ά
% % origin = 'bof' 'cof' 'eof'
% % status = fseek(fileID, offset, origin);
% intFlagHead = fread(fid, 'int32');
% nNum = fread(fid,'int32');
% nRow = fread(fid,'int32');
% nCol = fread(fid,'int32');
% 
% vecTmp = fwrite(fid,'float32');
% matxSample = reshape(vecTmp,[nRow, nNum]);
% ===========

[nNum,~] = size(lstFileName);%number of sample
nRow = 2000;%length of the sound sample
nCol = 1;%single sound channel,2 is stero, 3 multiple channel
matxSampleMat = zeros(nRow, nNum);

nStart = 2001;
index = nStart : nStart + nRow - 1;
% disp('������')
for ind = 1:nNum
    strFileName = lstFileName{ind,1}.name;
    strPathName = lstFileName{ind,1}.folder;
    data = load([strPathName '\' strFileName]);
%     dFs = str2double(data.File_Header.SampleFrequency);
    vecSig = data.Channel_1_Data;
    vecSigSeg = vecSig(index);
    matxSampleMat(:,ind) = vecSigSeg;
%     % === �������ļ�����
%     fwrite(fid,vecSigSeg,'float32');
%     % ===
%     if mod(ind,10)==0
%         disp([ num2str(ind) '...'])
%     end
    
end
% disp([ num2str(ind) '...'])
% 
% fclose(fid);
% 
% status = true;
end

