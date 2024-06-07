function computeAndPlotFiltersIndividualImpulseResponse(delay_lines_sizes,nbrOfFilters,cfilters)

for j = 1:nbrOfFilters
%plot the impulse response of a filter
currentFilter = j;
audioInput = zeros(1, delay_lines_sizes(currentFilter));
audioInput(1) = 1;

for i = 1:delay_lines_sizes(currentFilter)
        cfilters(currentFilter) = cfilters(currentFilter).filterOutput(audioInput(i));
end
filter_responses = zeros(1, delay_lines_sizes(currentFilter));

% Compute the response for each filter

for i = 1:delay_lines_sizes(currentFilter)
    filter_responses(1, i) = cfilters(currentFilter).content(i);
end

figure;
plot(filter_responses(1, 1:100));
title(['Response of filter ', num2str(currentFilter)]);
xlabel('Index');
ylabel('Magnitude');

filename = sprintf('impulse_res_filter_%d_delay_line_%d.png', currentFilter,delay_lines_sizes(currentFilter));
print(filename, '-dpng');
endfor
endfunction