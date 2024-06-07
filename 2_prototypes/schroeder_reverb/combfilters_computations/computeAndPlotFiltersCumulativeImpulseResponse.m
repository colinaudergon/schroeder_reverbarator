function computeAndPlotFiltersCumulativeImpulseResponse(delay_lines_sizes,nbrOfFilters,cfilters)
  % Initialize variables
  audioInput = zeros(1, max(delay_lines_sizes));
  audioInput(1) = 1;
  tolerance = 0.001 * 0.10; % 10% tolerance of 0.001

  % Filter processing
  for i = 1:max(delay_lines_sizes)
      for f = 1:nbrOfFilters
          cfilters(f) = cfilters(f).filterOutput(audioInput(i));
      end
  end

  % Initialize sumr matrix to store cumulative sums
  sumr = zeros(nbrOfFilters, max(delay_lines_sizes));

  % Compute cumulative sums for each filter
  for f = 1:nbrOfFilters
      for i = 1:max(delay_lines_sizes)
          if f == 1
              sumr(f, i) = cfilters(f).content(i);
          else
              sumr(f, i) = sumr(f-1, i) + cfilters(f).content(i);
          end
      end
  end

  % Plot results in subplots
  figure;
  for f = 1:nbrOfFilters
      subplot(nbrOfFilters, 1, f);
      plot(sumr(f, 1:200));
      hold on;
      x = xlim(); % Get the current x-axis limits
      plot(x, [0.01, 0.01], 'r--', 'LineWidth', 1.5); % Draw the horizontal line at y = 0.01
      hold off;
      title(['Cumulative sum of filter responses up to filter ', num2str(f)]);
  end

endfunction