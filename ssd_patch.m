function [cost] = ssd_patch(sample, patchsize, overlap, imout, samplepos, imoutpos)

temparr = imout(imoutpos(1):imoutpos(1)+patchsize-1, imoutpos(2):imoutpos(2)+overlap-1, :) - sample(samplepos(1):samplepos(1)+patchsize-1, samplepos(2):samplepos(2)+overlap-1, :);
temparr = temparr(:, :, :) .* temparr(:, :, :);

temparr2 = imout(imoutpos(1):imoutpos(1)+overlap-1, imoutpos(2)+overlap:imoutpos(2)+patchsize-1, :) - sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2)+overlap:samplepos(2)+patchsize-1, :);
temparr2 = temparr2(:, :, :) .* temparr2(:, :, :);

cost = sum(sum(sum(temparr))) + sum(sum(sum(temparr2)));