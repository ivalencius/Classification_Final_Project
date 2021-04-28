%%
% Copyright (c) 2014, Mohammad Abouali (maboualiedu@gmail.com)
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without 
% modification, are permitted provided that the following conditions are 
% met:
% 
%     * Redistributions of source code must retain the above copyright 
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright 
%       notice, this list of conditions and the following disclaimer in 
%       the documentation and/or other materials provided with the distribution
%       
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.

function mdata=parseLandSat8MetaData(filename)
%% Checking input filename
validateattributes(filename,{'char'},{'row'});

%% Opening the input file.
[fid,errmsg]=fopen(filename,'r');
if (~isempty(errmsg))
  error(errmsg)
end

%% Some initializations
groupList={'mdata'};
NotDoneYet=true;
mdata=[];

%% reading the file and assigning it to an structure
while (~feof(fid) && NotDoneYet)
  lineStr=fgetl(fid);
  lineFields=strsplit(lineStr,'=');
  switch lower(strtrim(lineFields{1}))
    case 'group'
      % Adding new subgroup
      groupList(end+1)={strtrim(lineFields{2})}; %#ok<AGROW>
      structTag=strjoin(groupList,'.');
    case 'end_group'
      % End of the subgroup; preparing for next subgroup
      groupList=groupList(1:end-1);
      structTag=strjoin(groupList,'.');
    case 'end'
      % end of metadata
      NotDoneYet=false; %#ok<NASGU>
    otherwise
      % attributes in the subgroup
      fieldName=strtrim(lineFields{1});
      fieldValue=strtrim(lineFields{2});
      if (fieldValue(1)=='"')
        fieldValue=fieldValue(2:end-1);
      end
      fieldValue_numeric=str2double(fieldValue);
      if (isempty(fieldValue_numeric) || isnan(fieldValue_numeric))
        eval([structTag '.' fieldName '=''' fieldValue ''';']);
      else
        eval([structTag '.' fieldName '=' fieldValue ';']);
      end
  end
end

if ( NotDoneYet || numel(groupList)~=1 )
  error('In consistency in Meta data file.');
end

%% closing the input file
fclose(fid);
end