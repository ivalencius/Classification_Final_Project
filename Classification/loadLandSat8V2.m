function LandSatData=loadLandSat8V2(metaFileName,bandList)
%% This function requires Mapping Toolbox; Checking if it exists
if (~license('checkout','map_toolbox'))
  error(['can not check out Mapping Toolbox. ' ...
         'Make sure you have this toolbox and you can check it out']);
end

%% This function requires parseLandSat8MetaData.m; Checking if it is available
if (exist('parseLandSat8MetaData.m','file')~=2)
  error(['can not access parseLandSat8MetaData.m ' ...
         'Make sure MATLAB can access this file. ' ...
         ' parseLandSat8MetaData.m can be downloaded from Mathworks File Exchange.' ...
         'http://www.mathworks.com/matlabcentral/fileexchange/48614-parselandsat8metadata-filename-']);
end

%% Checking input filename
validateattributes(metaFileName,{'char'},{'row'});

%% Checking inputBandList
if ( nargin<2 || isempty(bandList) )
  bandList=1:12;
else
  validateattributes(bandList,{'numeric'},{'vector'});
  if ( any((bandList-round(bandList))~=0) )
    error('bandList must contains only integer numbers.');
  end
  if ( any(bandList>12 | bandList<1) )
    error('bandList can contains only integer numbers between 1 and 12. (12th band refers to Band Quality)');
  end
end

%% loading the meta data
metaData=parseLandSat8MetaData(metaFileName);

%% Checking if it was a L1 Meta Data and required field exists
if (~isfield(metaData,'LANDSAT_METADATA_FILE'))
  error('The meta data file must be LandSat8 L1 Meta Data');
end

if (~isfield(metaData.LANDSAT_METADATA_FILE,'PRODUCT_CONTENTS'))
  error('It appears meta data is not complete.');
end

%% Now loading data
LandSatData.Band=cell(11,1);
LandSatData.BandInfo=cell(11,1);
LandSatData.BQA=[];
LandSatData.BQAInfo=[];
LandSatData.MetaData=metaData;

[folder,~,~]=fileparts(metaFileName);
for i=1:numel(bandList)
  bandNumber=bandList(i);
  if (bandNumber>=1 && bandNumber<=11)
    fileNameField=['FILE_NAME_BAND_' num2str(bandNumber)];
    if (~isfield(metaData.LANDSAT_METADATA_FILE.PRODUCT_CONTENTS,fileNameField))
      warning(['information about Band ' num2str(bandNumber) ' is missing. skipping this band']);
    else
      LandSatData.Band{bandNumber}=imread(fullfile(folder,metaData.LANDSAT_METADATA_FILE.PRODUCT_CONTENTS.(fileNameField)));
      %LandSatData.BandInfo{bandNumber}=geotiffinfo(fullfile(folder,metaData.LANDSAT_METADATA_FILE.PRODUCT_CONTENTS.(fileNameField)));
    end
  elseif (bandNumber==12)
    fileNameField='FILE_NAME_BAND_QUALITY';
    if (~isfield(metaData.LANDSAT_METADATA_FILE.PRODUCT_CONTENTS,fileNameField))
      warning('information about Band quality is missing. skipping this band');
    else
      LandSatData.BQA=imread(fullfile(folder,metaData.LANDSAT_METADATA_FILE.PRODUCT_CONTENTS.(fileNameField)));
      LandSatData.BQAInfo=geotiffinfo(fullfile(folder,metaData.LANDSAT_METADATA_FILE.PRODUCT_CONTENTS.(fileNameField)));
    end  
  end
    
end
  
end