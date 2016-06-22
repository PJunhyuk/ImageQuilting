function [cost] = get_ssd(texture, texturepos, target, targetpos, patchsize)

temparr = texture(texturepos(1):texturepos(1)+patchsize-1, texturepos(2):texturepos(2)+patchsize-1, :) - target(targetpos(1):targetpos(1)+patchsize-1, targetpos(2):targetpos(2)+patchsize-1, :);
temparr = temparr(:, :, :) .* temparr(:, :, :);

cost = sum(sum(sum(temparr)));