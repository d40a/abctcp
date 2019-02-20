clear;
%define tour tr from .tsp file

file = fopen('ftv64.txt','r');
matrix = fscanf(file, '%f', [65 Inf]);
fclose(file);
tr = randperm(65)';
%tr = tr(1:2, :)';
colonysize = 60;
tours = beecolony(tr, colonysize, matrix);
start_time = tic();
iterations = 200;
for iter = 1:iterations
    tours = tours.sendemployed();
    now = tic();
    tours = tours.updt_employed('two_opt');
    updt_time = toc(now);
    tours = tours.sendonlookers();
    tours = tours.sendscouts();
    tours = tours.waggledance();
end

bestcost = Inf;
for i=1:length(tours.onlookers)
    cost = tours.onlookers(i).cost;
    if cost<bestcost
        besttour = tours.onlookers(i);
        bestcost = cost;
    end
end

runtime = toc(start_time);
fprintf('\ntotal runtime = %d\n', runtime);

% figure;
% scatter(besttour.cities(:,1),besttour.cities(:,2))
% txt=(1:besttour.size)';
% txt=num2str(txt);
% txt=cellstr(txt);
% text(besttour.cities(:,1),besttour.cities(:,2),txt)
% hold on;
% for li=1:besttour.size-1
%     plot([besttour.cities(li,1),besttour.cities(li+1,1)],[besttour.cities(li,2),besttour.cities(li+1,2)])
% end

llll = besttour.cities;
ress = []
for k=1:length(llll)
    for i=1:length(tr)
        if llll(k,:) == tr(i,:)
            ress = [ress, i]
        end
    end
end
