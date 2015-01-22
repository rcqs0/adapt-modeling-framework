function [hp1, hp2] = plotMad(this, comp, color)
% plot median absolute deviation
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
hp1 = fill(X, Y, color);
hp2 = plot(time, meta(:,1), '-k', 'LineWidth', 2);  

end

