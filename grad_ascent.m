function [ X_ ] = grad_ascent( D, X )
%GRAD_ASCENT Summary of this function goes here
%   Detailed explanation goes here
    function [o] = tarfun(X)
        h0 = cell(3,1);
        p0 = cell(3,1);
        h0{1} = X;
        for l=2:size(h0,1)
            p0{l} = sigmoid(bsxfun(@plus, h0{l-1} * D.rec.W{l-1}, D.rec.biases{l}'));
            h0{l} = binornd(1, p0{l});
        end
        p_top = sigmoid(bsxfun(@plus, h0{3} * D.rec.W{3}, D.top.hbias'));
        top = binornd(1, p_top);
        o=double(1-p_top(1000));
    end

    maxiter=10000;
    learn_rate = 0.7;
    delta = 1e-12;
    grad = zeros(size(X));
    for iter=1:maxiter
        if  mod(iter,1000)==0
            disp(sprintf('%dth iter', iter));
        end
        for i=1:size(X,2)
            X1 = X; X2 = X;
            X1(i) = X1(i)-delta;
            X2(i) = X2(i)+delta;
            y1 = tarfun(X1);
            y2 = tarfun(X1);
            grad(i) = (y2-y1)/(2*delta);
        end
        X= X + grad*learn_rate;
    end
    
end