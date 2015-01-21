function this = plots(this, names, mode)

if nargin < 3, mode = 'TRAJ'; end

import AMF.utils.defineCustomColormap

if isa(names, 'char')
    names = {names};
end

n = length(names);
ns = sqrt(n);

numIter = this.options.numIter;

for i = 1:length(names)
    subplot(ceil(ns),ceil(ns),i); hold on;
    name = names{i};

    comp = this.ref.(name);

    switch upper(mode)
        case 'TRAJ'
            colorMap = defineCustomColormap({[0.8 0.6 0.6] [0.8 0 0] [0.2 0 0]}, numIter);
            plotTraj(this, comp, colorMap);

        case 'HIST'
            colorMap = defineCustomColormap({[1 1 1] [0.8 0 0] [0.2 0 0]}, numIter);
            plotHist(this, comp, colorMap);

        case 'HIST_LOG'

            % TODO: plot logarithmic histograms
        case 'MAD' % median absolute deviation
            time_steps = this.options.numTimeSteps;
            meta = zeros(time_steps,4);
            for dt = 1:time_steps
                y = quantile(comp.val(dt,:),[0.05 0.16 0.25 0.5 0.75 0.84 0.95], 2);
                meta(dt,1) = y(4);
                meta(dt,2) = median(abs(comp.val(dt,:)- meta(dt,1)));
                meta(dt,3) = meta(dt,1)+meta(dt,2);
                meta(dt,4) = meta(dt,1)-meta(dt,2);    
            end
            time = 1:time_steps;
            time = time*this.time(end)/time_steps;
            X = [time fliplr(time)];
            Yupp = meta(:,3)';
            Ylwr = meta(:,4)';
            Y = [Ylwr fliplr(Yupp)];
            hp = fill(X, Y, 'g');
            plot(time, meta(:,1), '-k', 'LineWidth', 2);         

        otherwise
            error('Unknown plot mode %s', mode);
    end

    xlabel([this.predictor.unitType, ' [', this.predictor.unit, ']']);
    xlim([this.time(1) this.time(end)]);

    if comp.label
        title(comp.label);
    else
        title(comp.name);
    end

    if comp.unit
        ylabel(sprintf('%s [%s]', comp.unitType, comp.unit));
    else
        ylabel(comp.unitType);
    end
end