%% HW3-b
% Calculate the fundamental matrix using the normalized eight-point
% algorithm.
function f = calculate_fundamental_matrix(pts1, pts2)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    [pts1,T]=normalize_points(pts1', 2);
    [pts2,Tp]=normalize_points(pts2', 2);
    pts1=pts1';
    pts2=pts2';
    x1=pts1(:,1);
    y1=pts1(:,2);
    x2=pts2(:,1);
    y2=pts2(:,2);
    %A = [x2 .* x1, x2 .* y1, x2, y2 .* x1, y2 .* y1, y2, x1, y1, ones(8, 1)];
    A = [x2 .* x1, x1 .* y2, x1, y1 .* x2, y2 .* y1, y1, x2, y2, ones(8, 1)];
    temp= A'*A;
    [V,D] = eig(temp);
    [d,ind] = sort(diag(D));
    Ds = D(ind,ind);
    Vs = V(:,ind);
    f=Vs(:,1);
    F=reshape(f,[3,3]);
    [U,S,V] = svd(F);
    S(3,3)=0;
    F=U*S*V';
    %% Delete here when you run your code
    f = Tp'*F*T;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
