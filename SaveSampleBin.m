function status = SaveSampleBin(strSaveFileName, lstFileNameAndFlag)
%UNTITLED 此处显示有关此函数的摘要
%   

% ==== 文件操作  ====
% strFileName = 'LearnSamples.bin';
% 数据维数，4字节整数， int32
[nNum,~] = size(lstFileNameAndFlag);%number of sample
nRow = 2000;%length of the sound sample
nCol = 1;%single sound channel,2 is stero, 3 multiple channel
% 可用来研究多通道之间的相互关联吗？

strPermission = 'w';
fid = fopen(strSaveFileName,strPermission);
intFlagHead = 3331;% 00 00 0D 03 单精度数，三维
fwrite(fid, intFlagHead,'int32');
fwrite(fid,nNum,'int32');
fwrite(fid,nRow,'int32');
fwrite(fid,nCol,'int32');
% ===========
nStart = 2001;
index = nStart : nStart + nRow - 1;
disp('样本：')
for ind = 1:nNum
    strFileName = lstFileNameAndFlag{ind,1}.name;
    strPathName = lstFileNameAndFlag{ind,1}.folder;
    data = load([strPathName '\' strFileName]);
%     dFs = str2double(data.File_Header.SampleFrequency);
    vecSig = data.Channel_1_Data;
    vecSigSeg = vecSig(index);
    % === 下面是文件操作
    fwrite(fid,vecSigSeg,'float32');
    % ===
    if mod(ind,10)==0
        disp([ num2str(ind) '...'])
    end
    
end
disp([ num2str(ind) '...'])

fclose(fid);

status = true;
end

