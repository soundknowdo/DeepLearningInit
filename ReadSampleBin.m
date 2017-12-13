function [intFlagHead,nNum,nRow,nCol,matxSample] = ReadSampleBin(strReadFileName)
%UNTITLED 此处显示有关此函数的摘要
%   

% ==== 文件操作  ====
% strFileName = 'LearnSamples.bin';
% 数据维数，4字节整数， int32
% 可用来研究多通道之间的相互关联吗？

strPermission = 'r';
fid = fopen(strReadFileName,strPermission);
% intFlagHead = 3331;% 00 00 0D 03 单精度数，三维
% origin = 'bof' 'cof' 'eof'
% status = fseek(fileID, offset, origin);
intFlagHead = fread(fid, 1,'int32');
nNum = fread(fid,1,'int32');
nRow = fread(fid,1,'int32');
nCol = fread(fid,1,'int32');

matxSample = fread(fid,[nRow,nRow],'float32');

fclose(fid);

% matxSample = reshape(vecTmp,[nRow, nNum]);

end

