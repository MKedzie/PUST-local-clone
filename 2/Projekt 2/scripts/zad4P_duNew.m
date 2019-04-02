function duPopN = zad4P_duNew(duPop,du)
    duPopN = [0 duPop(1:end-1)];
    duPopN(1) = du;
end

