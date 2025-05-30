function display_img(hObject, eventdata, handles)

%%% MODIFIED ION 5/25/2025 BY NIMA FOR HDR IMAGES

video_mapping = getappdata (handles.video_selection_group, 'video_mapping');
video_index   = getappdata (handles.video_selection_group, 'video_index');
video_list    = getappdata (handles.video_selection_group, 'video_list');

%%% STIMULI MODIFY %%%
if(video_index == 5)
    movie_path    = video_list(5).movie_path;
else
    movie_path    = video_list(video_mapping(video_index)).movie_path;
end

%%
% img = imread(movie_path);
% gray_break = imread('C:\My data\CIC2015\HDR color apearance\SAMVIQ_iTMO_CAM\SAMVIQ\stimuli\main_experiment\break_gray.bmp');
drawnow;

[img, info] = HDRRead(movie_path);

img = imresize(img, [900 1400]);

% Show metadata:
disp(info);


trial_win = getappdata (handles.video_selection_group, 'trial_win');
% 
% PsychImaging('PrepareConfiguration');
% PsychImaging('AddTask', 'General', 'EnableHDR', 'Nits', 'HDR10');
% Note: This would also work, as above settings are used by default:
% PsychImaging('AddTask', 'General', 'EnableHDR');
% win = PsychImaging('OpenWindow', screenid, 0);
% HideCursor(win);

[~, img] = ConvertRGBSourceToRGBTargetColorSpace(info.ColorGamut, trial_win, img);


switch info.format
    case 'rgbe'
        % HACK: Multiply by 179.0 as a crude approximation of Radiance
        % units to nits: This is not strictly correct, but will do to get a
        % nice enough picture for demo purpose. See 'help HDRRead' for the
        % motivation for the 179 multiplicator for Radiance images:
        % This is always RGB, no alpha channel to deal with.
        img = img * 179;

    case 'openexr'
        % Known scaling factor for scaling pixel values into units of nits?
        % Otherwise it is best to just leave it as is:
        % if info.sampleToNits > 0
        %     % Only scale RGB channels, not the alpha channel.
        %     img(:,:,1:3) = img(:,:,1:3) * info.sampleToNits;
        % end

        img = img * 2990;

    otherwise
        error('Unknown image format. Do not know how to convert into units of Nits.');
end

% Compute maximum and max mean luminance of the image:
[maxFALL, maxCLL] = ComputeHDRStaticMetadataType1ContentLightLevels(img);

% Tell the HDR display about maximum frame average light level and maximum
% content light level of the image:
PsychHDR('HDRMetadata', trial_win, 0, maxFALL, maxCLL);


% Texture = Screen('MakeTexture',trial_win,gray_break);% read in the image
% Screen('DrawTexture',trial_win, Texture);% Draw the image to the screen'win'
% Screen('Flip',trial_win);% present to the screen
% WaitSecs(1);
% 
Texture = Screen('MakeTexture',trial_win, img);% read in the image
Screen('DrawTexture',trial_win, Texture);% Draw the image to the screen'win'
Screen('Flip',trial_win); %pr

varlist = {'img','test','trial_win'};
clear(varlist{:})
Screen('Close',Texture)

end