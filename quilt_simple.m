function [imout] = quilt_simple(sample, outsize, patchsize, overlap, tol)
tic
% day2. quilt_simple.m
%
% Texture Synthesize
%   sample
%       image

sample = double(sample);
xtrim = patchsize - (outsize(2) - ((patchsize-overlap)*floor((outsize(2)-patchsize)/(patchsize-overlap))+1+patchsize-overlap));
ytrim = patchsize - (outsize(1) - ((patchsize-overlap)*floor((outsize(1)-patchsize)/(patchsize-overlap))+1+patchsize-overlap));

outsize_ = [outsize(1)+ytrim outsize(2)+xtrim];

if(size(sample,3) ==1)
    imout = zeros(outsize_);
else
    imout = zeros([outsize_(1:2) size(sample,3)]);
end

for i=1:patchsize-overlap:outsize_(1)-patchsize+1,
    for j=1:patchsize-overlap:outsize_(2)-patchsize+1,
        if(i == 1 && j == 1)
                sizein = size(sample);
                sizein = sizein(1:2);

                pos = ceil([rand*sizein(1) rand*sizein(2)]);
                pos(1) = min(pos(1), sizein(1)-patchsize+1);
                pos(2) = min(pos(2), sizein(2)-patchsize+1);
                
                patch =  sample(pos(1):pos(1)+patchsize-1,pos(2):pos(2)+patchsize-1,:);
                imout(i:i+patchsize-1,j:j+patchsize-1,:) = patch(:,:,:);
        else
            currentpos = [i j];

            patchpos = choose_sample(sample, patchsize, overlap, imout, currentpos, tol);

            imout = cut(sample, patchsize, overlap, imout, patchpos, currentpos);
        end
    end
end
imout = imout(1:outsize(1),1:outsize(2),:);
toc
