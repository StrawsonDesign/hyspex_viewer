%% graphical viewer for hyspex files

clear all 
close all
clc

%% prompt user for file
[filename,pathname] = uigetfile('*.hyspex','Select a HySpex File');

%% get data
[bands, width, lines, wavelengths] = hyspex_file_details(fullfile(pathname, filename));

fprintf('bands: %d\n', bands)
fprintf('line width: %d\n', width)
fprintf('lines: %d\n', lines)
fprintf('shortest wavelength: %f\n', wavelengths(1))
fprintf('longest wavelength: %f\n', wavelengths(bands))


%% read in all data
% allocate memory for everything first
data = zeros(width,lines,bands); 
for i=1:bands
   data(:,:,i) = band_from_hyspex(fullfile(pathname, filename),i);
end

%% open figure
close all
fig1 = figure();
current_band = 100;

draw_image(data,current_band)

b = uicontrol('Parent',fig1,'Style','slider','Position',[81,54,419,23],...
              'value', current_band, 'min',1, 'max', bands, 'SliderStep',[1/bands 0.10]);
bgcolor = fig1.Color;
bl1 = uicontrol('Parent',fig1,'Style','text','Position',[50,54,23,23],...
                'String','1','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',fig1,'Style','text','Position',[500,54,30,30],...
                'String',bands,'BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',fig1,'Style','text','Position',[240,25,100,23],...
                'String','Band','BackgroundColor',bgcolor);
            
b.Callback = @(es,ed) draw_image(data,round(es.Value));