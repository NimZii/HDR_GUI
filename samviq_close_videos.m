%
% Close the videos that were open for the current scene
%

function samviq_close_videos (movie_list)

for i=1:17
    Screen ('PlayMovie', movie_list(i).movie, 0);
    Screen ('CloseMovie', movie_list(i).movie);
end
