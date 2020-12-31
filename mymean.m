function outv = mymean(P)

for i = 1:length(P)
    mysum = mysum + P(i);
end

outv = mysum/length(P);
end
