function status = ReadSampleFlagBin(strSaveFileName, lstFileNameAndFlag)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

% ==== �ļ�����  ====
% strFileName = 'LearnSamples.bin';
% ����ά����4�ֽ������� int32
[nNum,~] = size(lstFileNameAndFlag);%number of sample
% nRow = 2000;%length of the sound sample
% nCol = 1;%single sound channel,2 is stero, 3 multiple channel
% �������о���ͨ��֮����໥������

strPermission = 'w';
fid = fopen(strSaveFileName,strPermission);
intFlagHead = 2049;% 00 00 08 01 uint8��1ά
fwrite(fid, intFlagHead,'int32');
fwrite(fid,nNum,'int32');
% fwrite(fid,nRow,'int32');
% fwrite(fid,nCol,'int32');
% ===========
% nStart = 2001;
% index = nStart : nStart + nRow - 1;
disp('������ǩ��')
for ind = 1:nNum
%     strFileName = lstFileNameAndFlag{ind,1}.name;
%     strPathName = lstFileNameAndFlag{ind,1}.folder;
%     data = load([strPathName '\' strFileName]);
% %     dFs = str2double(data.File_Header.SampleFrequency);
%     vecSig = data.Channel_1_Data;
%     vecSigSeg = vecSig(index);
    % === �������ļ�����
    fwrite(fid,lstFileNameAndFlag{ind,2},'uint8');
    % ===
    if mod(ind,10)==0
        disp([ num2str(ind) '...'])
    end
end
disp([ num2str(ind) '...'])

fclose(fid);

status = true;
end

