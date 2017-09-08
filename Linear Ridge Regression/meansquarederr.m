function err = meansquarederr(T, Tdash)
err = mean((T-Tdash).^2);
end

