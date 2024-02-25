function [] = task_3_1()
    works = [12 13 15 23 24 25 36 45 46 56 57 58 67 68 78 88];
    conds = [
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
        ];

    pairs = [
        12 15 7 3
        23 25 7 3
        46 67 4 5
        57 58 5 7
    ];
    cond_len = length(conds) + 2 * length(pairs);
    x_len = length(works) + 2 * length(pairs);
    f = ones(x_len, 1);
    f(length(works) + 1:end) = 0;
    A = zeros(cond_len, x_len);
    b = zeros(1, cond_len);
    for i = 1:length(conds)
        t1 = find(works == conds(i, 1));
        t2 = find(works == conds(i, 2));
        A(i, t1) = -1;
        A(i, t2) = 1;
        b(1, i) = -conds(i, 3);
    end

    Aeq = zeros(length(pairs), x_len);
    beq = ones(1, length(pairs));

    for i = 1:length(pairs)
        t1 = find(works == pairs(i, 1));
        t2 = find(works == pairs(i, 2));
        tau1 = pairs(i, 3);
        tau2 = pairs(i, 4);
        Y1 = length(works) + 2 * i - 1;
        Y2 = length(works) + 2 * i;
        M = 1000;

        idx = length(conds) + 2 * i - 1;
        A(idx, Y1) = -(M + tau2);
        A(idx, t1) = -1;
        A(idx, t2) = 1;
        b(1, idx) = -tau2;

        idx = idx + 1;
        A(idx, Y2) = -(M + tau1);
        A(idx, t1) = 1;
        A(idx, t2) = -1;
        b(1, idx) = -tau1;

        Aeq (i, Y1) = 1;
        Aeq (i, Y2) = 1;
    end

    lb = zeros(x_len, 1);

    x = intlinprog(f, (length(works) + 1):x_len, A, b, Aeq, beq, lb);

    disp(x)
end