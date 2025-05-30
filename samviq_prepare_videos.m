%
% Prepare the videos. This opens movies, and returns the movie_list
% structure
%

function movie_list = samviq_prepare_videos (trial_win, scene_number, video_mapping)

% f_stop_spacing     = [1, 3, 5, 7]; % need to be the same values as used for
% time_spacing       = [0, 2, 4, 6]; % stimuli creation

%%% MODIFIED HERE %%%
%%% MODIFY STIMULI NUMBER %%%

psychophyics_path  = 'C:\Users\Nima\Desktop\HDR images\Experiment Images\samviq_still_images - Copy\HDR_stimuli\';
d = dir(psychophyics_path);
isub = [d(:).isdir];
name_methods = {d(isub).name}';
name_methods(ismember(name_methods,{'.','..'})) = [];

mname{1}           = 'PeckLake.exr';
mname{2}           = 'PeckLakeiTM.hdr';
% mname{3}           = 'sink.hdr';
% mname{4}           = 'DelicateArch_adapted_ldr_final.bmp';
% mname{5}           = 'HancockKitchenInside_adapted_ldr_final.bmp';
% mname{6}           = 'LabBooth_adapted_ldr_final.bmp';
% mname{7}           = 'LasVegasStore_adapted_ldr_final.bmp';
% mname{8}           = 'NiagaraFalls_adapted_ldr_final.bmp';
% mname{9}           = 'PaulBunyan_adapted_ldr_final.bmp';
% mname{10}          = 'PeckLake_adapted_ldr_final.bmp';

%%% MODIFY STIMULI NUMBER %%%
for i=1:2
    outdir{i}      = mname(i);%strcat(psychophyics_path,mname(i));
end


% SHOULD CREATE AND COPY ALL 4 METHODS HDR IMAGES
for f=1:5
        movie_name = strcat(psychophyics_path,name_methods{f},'\',mname{scene_number});
        img_path = movie_name;
        movie_list(f).movie             = [];
        movie_list(f).movie_path        = img_path;
        movie_list(f).movie_name        = mname{scene_number};
        
end

% The hidden reference movie (f = 7, t = 0) is located in space 13.
% We copy this into the explicit reference movie, located in space 17.

%%% MODIFIED HERE %%%
%%% MODIFY STIMULI NUMBER %%%
[x,y] = find(video_mapping == 2);
movie_list(2) = movie_list(video_mapping(x,y));
movie_list.movie_path 
end