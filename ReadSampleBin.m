function [intFlagHead,nNum,nRow,nCol,matxSample] = ReadSampleBin(strReadFileName)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   

% ==== �ļ�����  ====
% strFileName = 'LearnSamples.bin';
% ����ά����4�ֽ������� int32
% �������о���ͨ��֮����໥������

strPermission = 'r';
fid = fopen(strReadFileName,strPermission);
% intFlagHead = 3331;% 00 00 0D 03 ������������ά
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

