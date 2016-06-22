function imout = cut(sample, patchsize, overlap, imout, samplepos, imoutpos)

samplesz = size(sample);
sampledms = length(samplesz);

imout(imoutpos(1)+overlap:imoutpos(1)+patchsize-1, imoutpos(2)+overlap:imoutpos(2)+patchsize-1, :) = sample(samplepos(1)+overlap:samplepos(1)+patchsize-1, samplepos(2)+overlap:samplepos(2)+patchsize-1, :);

imoutsz = size(imout);
imoutdms = length(imoutsz);

samplet = zeros(patchsize, overlap);
imoutt = zeros(patchsize, overlap);
delta = zeros(patchsize, overlap);

if sampledms == 2
    samplet(:, :) = sample(samplepos(1):samplepos(1)+patchsize-1, samplepos(2):samplepos(2)+overlap-1);
else
    for k=1: 1: samplesz(3);
        samplet(:, :) = samplet(:, :) + sample(samplepos(1):samplepos(1)+patchsize-1, samplepos(2):samplepos(2)+overlap-1, k);
    end
end

if imoutdms == 2
    imoutt(:, :) = imout(imoutpos(1):imoutpos(1)+patchsize-1, imoutpos(2):imoutpos(2)+overlap-1);
else
    for p=1: 1: imoutsz(3);
        imoutt(:, :) = imoutt(:, :) + imout(imoutpos(1):imoutpos(1)+patchsize-1, imoutpos(2):imoutpos(2)+overlap-1, p);
    end
end

delta(:, :) = samplet(:, :) - imoutt(:, :);
delta(:, :) = abs(delta(:, :));

ddelta = zeros(patchsize, overlap);

ddelta(1, :) = delta(1, :);

for i=2: 1: patchsize;
    for j=1: 1: overlap;
        if j == 1
            ddelta(i, 1) = delta(i, 1) + min([delta(i-1, 1) delta(i-1, 2)]);
        elseif j == overlap
            ddelta(i, overlap) = delta(i, overlap) + min([delta(i-1, overlap-1) delta(i-1, overlap)]);
        else
            ddelta(i, j) = delta(i, j) + min([delta(i-1, j-1) delta(i-1, j) delta(i-1, j+1)]);
        end
    end
end

cutarr = zeros(patchsize, 1);

cutarr(patchsize) = find(ddelta(patchsize, :)==min(ddelta(patchsize, :)), 1, 'first');

for i=patchsize: -1: 2;
    if cutarr(i, 1) == 1
        temp = [ddelta(i-1, 1) ddelta(i-1, 2)];
        cutarr(i-1) = find(temp==min(temp), 1, 'first');
    elseif cutarr(i) == overlap
        temp = [ddelta(i-1, overlap) ddelta(i-1, overlap-1)];
        cutarr(i-1) = overlap + 1 - find(temp==min(temp), 1, 'first');
    else
        temp = [ddelta(i-1, cutarr(i)-1) ddelta(i-1, cutarr(i)) ddelta(i-1, cutarr(i)+1)];
        cutarr(i-1) = cutarr(i) - 2 + find(temp==min(temp), 1, 'first');
    end
end

for i=0: 1: patchsize-1;
    imout(imoutpos(1)+i, imoutpos(2)+cutarr(i+1)-1:imoutpos(2)+overlap-1, :) = sample(samplepos(1)+i, samplepos(2)+cutarr(i+1)-1:samplepos(2)+overlap-1, :);
end



samplet = zeros(overlap, patchsize);
imoutt = zeros(overlap, patchsize);
delta = zeros(overlap, patchsize);

if sampledms == 2
    samplet(:, :) = sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2):samplepos(2)+patchsize-1);
else
    for k=1: 1: samplesz(3);
        samplet(:, :) = samplet(:, :) + sample(samplepos(1):samplepos(1)+overlap-1, samplepos(2):samplepos(2)+patchsize-1, k);
    end
end

if imoutdms == 2
    imoutt(:, :) = imout(imoutpos(1):imoutpos(1)+overlap-1, imoutpos(2):imoutpos(2)+patchsize-1);
else
    for p=1: 1: imoutsz(3);
        imoutt(:, :) = imoutt(:, :) + imout(imoutpos(1):imoutpos(1)+overlap-1, imoutpos(2):imoutpos(2)+patchsize-1, p);
    end
end

delta(:, :) = samplet(:, :) - imoutt(:, :);
delta(:, :) = abs(delta(:, :));

ddelta = zeros(overlap, patchsize);

ddelta(:, 1) = delta(:, 1);

for i=2: 1: patchsize;
    for j=1: 1: overlap;
        if j == 1
            ddelta(1, i) = delta(1, i) + min([delta(1, i-1) delta(2, i-1)]);
        elseif j == overlap
            ddelta(overlap, i) = delta(overlap, i) + min([delta(overlap-1, i-1) delta(overlap, i-1)]);
        else
            ddelta(j, i) = delta(j, i) + min([delta(j-1, i-1) delta(j, i-1) delta(j+1, i-1)]);
        end
    end
end

cutarr = zeros(patchsize, 1);

cutarr(patchsize) = find(ddelta(:, patchsize)==min(ddelta(:, patchsize)), 1, 'first');

for i=patchsize: -1: 2;
    if cutarr(i) == 1
        temp = [ddelta(1, i-1) ddelta(2, i-1)];
        cutarr(i-1) = find(temp==min(temp), 1, 'first');
    elseif cutarr(i) == overlap
        temp = [ddelta(overlap, i-1) ddelta(overlap-1, i-1)];
        cutarr(i-1) = overlap + 1 - find(temp==min(temp), 1, 'first');
    else
        temp = [ddelta(cutarr(i)-1, i-1) ddelta(cutarr(i), i-1) ddelta(cutarr(i)+1, i-1)];
        cutarr(i-1) = cutarr(i) - 2 + find(temp==min(temp), 1, 'first');
    end
end

for i=0: 1: patchsize-1;
    imout(imoutpos(1)+cutarr(i+1)-1:imoutpos(1)+overlap-1, imoutpos(2)+i, :) = sample(samplepos(1)+cutarr(i+1)-1:samplepos(1)+overlap-1, samplepos(2)+i, :);
end
