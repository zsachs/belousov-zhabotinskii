function dy =rigid(t,y)
dy = zeros(4,1);
dy(2) = 0.01 * y(1) - 0.03 * y(2) * y(3);
dy(3) = 0.03 * y(2) * y(3) - 0.02 * y(3);
dy(4) = 0.02 * y(3);
