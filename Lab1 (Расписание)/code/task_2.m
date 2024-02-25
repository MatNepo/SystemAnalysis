function [] = task_2()
    works = [12 13 15 23 24 25 36 45 46 56 57 58 67 68 78 88];
    conds = [
      % te - время конца работы
      % tb - время начала работы
      % td - длительность работы

      % te tb td
        23 12 6 % 1
        24 12 7 % 2
        25 12 7 % 3
        36 13 6 % 4
        36 23 7 % 5
        45 24 4 % 6
        46 24 4 % 7
        56 15 3 % 8
        56 25 3 % 9
        56 45 5 % 10
        57 15 3 % 11
        57 25 3 % 12
        57 45 5 % 13
        58 15 3 % 14
        58 25 3 % 15
        58 45 5 % 16
        67 36 4 % 17
        67 46 4 % 18
        67 56 7 % 19
        68 36 4 % 20
        68 46 4 % 21
        68 56 7 % 22
        78 57 5 % 23
        78 67 5 % 24

        % работы "фальшивки"
        88 58 7
        88 68 7
        88 78 6
        ];
    x0 = ones(length(works) * 2 - 1, 1);
    lb = zeros(length(works) * 2 - 1, 1);
    
    fun = @(x) sum(x(1:length(works)));
    
    res = fmincon(fun, x0, [], [], [], [], lb, [], @funs);
    
    function [c, ceq] = funs(x)
        c = [];
        for i = 1:length(conds)
            t1 = find(works == conds(i, 1));
            t2 = find(works == conds(i, 2));
            q = conds(i, 3);
            m = length(works) + t2;
            c(end + 1) = -x(t1(1)) + x(t2(1)) + q / x(m);
        end
        ceq = sum(x(length(works) + 1:end)) - 0.75 * (length(works) - 1);
    end

    t_res = res(1:length(works));
    m_res = res(length(works) + 1:end);
    sum_m_res = sum(m_res);
    mean_m_res = mean(m_res);

    disp(t_res);
    disp(m_res);
    disp(sum_m_res);
    disp(mean_m_res);
end