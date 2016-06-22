function samplepos = choose_sample(sample, patchsize, overlap, imout, imoutpos, tol)

sizein = size(sample);
sizein = sizein(1:2);

ssdarr = zeros(sizein(1)-patchsize+1, sizein(2)-patchsize+1);

for i=1 : 1 : sizein(1)-patchsize+1;
    for j=1 : 1 : sizein(2)-patchsize+1;
        mpos = [i j];
        temp = ssd_patch(sample, patchsize, overlap, imout, mpos, imoutpos);
        if temp == 0
            ssdarr(i, j) = 100000000;
        else
            ssdarr(i, j) = temp;
        end
    end
end

minssd = min(min(ssdarr));

min_mat = repmat(minssd, size(ssdarr));

d_mat = min_mat*(1+tol) - ssdarr;

[temp_x, temp_y] = find(d_mat>0);

samplepos = [ temp_x(randperm(size(temp_x, 1) ,1)), temp_y(randperm(size(temp_y, 1), 1)) ];